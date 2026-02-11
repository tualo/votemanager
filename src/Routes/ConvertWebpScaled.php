<?php

namespace Tualo\Office\VoteManager\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSFiles;
use Tualo\Office\DS\DSTable;
use Tualo\Office\VoteManager\Votemanager;
use Tualo\Office\VoteManager\VotemanagerPhase;

class ConvertWebpScaled extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return 'votemanager.image';
    }

    public static function register()
    {

        BasicRoute::add('/votemanager/convertsetup' . '', function ($matches) {
            App::contenttype('application/json');
            App::result('success', false);
            try {

                $session = App::get('session');
                $db = $session->getDB();


                if (!Votemanager::isAllowed([VotemanagerPhase::Setup, VotemanagerPhase::Test])) {
                    throw new \Exception('Operation not allowed in current phase');
                }

                App::result('wm_print_imagetype', DSTable::instance('votemanager_setup')->f('id', 'eq', 'wm_print_imagetype')->getSingleValue('val') || 'jpg');
                App::result('wm_web_imagetype', DSTable::instance('votemanager_setup')->f('id', 'eq', 'wm_web_imagetype')->getSingleValue('val') || 'webp');
                App::result('wm_convert_sourceid', DSTable::instance('votemanager_setup')->f('id', 'eq', 'wm_convert_sourceid')->getSingleValue('val') || '1');

                App::result('id', $db->directArray('SELECT id FROM kandidaten', [], 'id'));


                App::result('success', true);
            } catch (\Exception $e) {
                App::result('msg', $e->getMessage());
            }
        }, ['get'], true, [], self::scope());

        BasicRoute::add('/votemanager/convert/(?P<imagetype>(webp|jpg|png))/(?P<sourcetype>[\d]+)/(?P<targettype>[\d]+)/(?P<pixelwidth>[\d]+)/(?P<id>[\/.\w\d\-\_\.]+)' . '', function ($matches) {
            App::contenttype('application/json');
            App::result('success', false);
            try {
                if (!Votemanager::isAllowed([VotemanagerPhase::Setup, VotemanagerPhase::Test])) {
                    throw new \Exception('Operation not allowed in current phase');
                }
                if (is_numeric($matches['sourcetype']) && is_numeric($matches['targettype']) && is_numeric($matches['pixelwidth'])) {

                    $field = 'cropped_id';
                    if (is_numeric($matches['id'])) {
                        $field = 'id';
                    }
                    $kandidaten = DSTable::instance('kandidaten')->f($field, '=', $matches['id'])->read()->getSingle();

                    $resultMimeType = 'image/webp';
                    switch ($matches['imagetype']) {
                        case 'jpg':
                            $resultMimeType = 'image/jpeg';
                            break;
                        case 'png':
                            $resultMimeType = 'image/png';
                            break;
                    }


                    $bild = DSTable::instance('kandidaten_bilder')
                        ->f('kandidat', '=', $kandidaten['id'])
                        ->f('typ', '=', $matches['sourcetype'])
                        ->read()->getSingle();

                    //print_r($kandidaten);
                    $image = DSFiles::instance('kandidaten_bilder');
                    $imagedata = $image->getBase64('id', $bild['id'], true);

                    // Bildausschnitt aus Base64-Bild erstellen
                    list($mime, $data) = explode(',', $imagedata);

                    $imageSource = imagecreatefromstring(base64_decode($data));

                    $imgWidth = imagesx($imageSource);
                    $imgHeight = imagesy($imageSource);

                    $targetWidth = (int)$matches['pixelwidth'];
                    $targetHeight = (int)($imgHeight * ($targetWidth / $imgWidth));

                    $croppedImage = imagecreatetruecolor($targetWidth, $targetHeight);

                    imagecopyresampled(
                        $croppedImage,
                        $imageSource,
                        0,
                        0,
                        0,
                        0,
                        $targetWidth,
                        $targetHeight,
                        $imgWidth,
                        $imgHeight
                    );


                    // Bild in Base64 konvertieren
                    ob_start();
                    switch ($matches['imagetype']) {
                        case 'jpg':
                            imagejpeg($croppedImage, null, 100);
                            break;
                        case 'png':
                            imagepng($croppedImage, null, 9);
                            break;
                        default:
                            imagewebp($croppedImage, null, 100);
                    }
                    $croppedData = ob_get_contents();
                    ob_end_clean();

                    $imagedata = 'data:' . $resultMimeType . ';base64,' . base64_encode($croppedData);


                    $dataToSave = [
                        '__table_name' => 'kandidaten_bilder',
                        'typ' => $matches['targettype'],
                        'kandidat' => $kandidaten['id'],
                        '__id' => 'kandidaten_bilder-' . uniqid(),
                        'id' => '',
                        'titel' => $bild['titel'],
                        '__file_name' => $bild['__file_name'],
                        '__file_size' => strlen($croppedData),
                        '__file_type' => $resultMimeType,
                        '__file_data' => $imagedata,
                        'export_name_template' => '',
                        'file_id' => '',
                        'hash' => md5($imagedata),
                        'include_in_export' => false,
                        'ctime' => null,
                        'mtime' => null,
                        'path' => '',
                    ];

                    DSTable::instance('kandidaten_bilder')->insert([$dataToSave]);
                    App::result('converted', true);


                    // Ressourcen freigeben
                    /*
                imagedestroy($imageSource);
                imagedestroy($croppedImage);
                */
                }
                App::result('success', true);
            } catch (\Exception $e) {
                App::result('msg', $e->getMessage());
            }
        }, ['get'], true, [], self::scope());
    }
}
