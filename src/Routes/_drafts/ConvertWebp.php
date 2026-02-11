<?php

namespace Tualo\Office\VoteManager\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSFiles;
use Tualo\Office\DS\DSTable;

class ConvertWebp extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return 'votemanager.image';
    }
    public static function register()
    {


        BasicRoute::add('/votemanager/convertwebp/(?P<type>[\/.\w\d\-\_\.]+)/(?P<id>[\/.\w\d\-\_\.]+)' . '', function ($matches) {
            App::contenttype('application/json');
            App::result('success', false);

            if (is_numeric($matches['type'])) {

                //                $kandidaten = DSTable::instance('kandidaten')->f('id', '=', $matches['id'])->read()->getSingle();
                $field = 'cropped_id';
                if (is_numeric($matches['id'])) {
                    $field = 'id';
                }
                $kandidaten = DSTable::instance('kandidaten')->f($field, '=', $matches['id'])->read()->getSingle();

                //$cropped = json_decode($kandidaten['imagecropdata'], true);


                $bild = DSTable::instance('kandidaten_bilder')
                    ->f('kandidat', '=', $kandidaten['id'])
                    ->f('typ', '=', $matches['type'])
                    ->read()->getSingle();

                //print_r($kandidaten);
                $image = DSFiles::instance('kandidaten_bilder');
                $imagedata = $image->getBase64('id', $bild['id'], true);

                // Bildausschnitt aus Base64-Bild erstellen
                list($mime, $data) = explode(',', $imagedata);
                if ($mime != 'data:image/webp;base64') {
                    //$data = str_replace('data:image/webp;base64,', '', $imagedata);
                    $imageSource = imagecreatefromstring(base64_decode($data));

                    $imgWidth = imagesx($imageSource);
                    $imgHeight = imagesy($imageSource);
                    // Ausschnitt erstellen
                    $croppedImage = imagecreatetruecolor($imgWidth, $imgHeight);
                    imagecopy(
                        $croppedImage,
                        $imageSource,
                        0,
                        0,
                        0,
                        0,
                        $imgWidth,
                        $imgHeight
                    );


                    // Bild in Base64 konvertieren
                    ob_start();
                    imagewebp($croppedImage, null, 95);
                    $croppedData = ob_get_contents();
                    ob_end_clean();

                    $imagedata = 'data:image/webp;base64,' . base64_encode($croppedData);



                    $dataToSave = [
                        '__table_name' => 'kandidaten_bilder',
                        'typ' => $matches['type'],
                        'kandidat' => $kandidaten['id'],
                        '__id' => 'kandidaten_bilder-' . uniqid(),
                        'id' => '',
                        'titel' => $bild['titel'],
                        //                    'title' => $bild['title'],
                        '__file_name' => $bild['__file_name'],
                        '__file_size' => strlen($croppedData),
                        '__file_type' => 'image/webp',
                        '__file_data' => $imagedata,
                        'export_name_template' => '',
                        'file_id' => '',
                        'hash' => '',
                        'include_in_export' => false,
                        'ctime' => null,
                        'mtime' => null,
                        'path' => '',
                    ];

                    DSTable::instance('kandidaten_bilder')->insert([$dataToSave]);
                    App::result('converted', true);


                    // Ressourcen freigeben
                    imagedestroy($imageSource);
                    imagedestroy($croppedImage);
                }
            }
            App::result('success', true);
        }, ['get'], true, [], self::scope());
    }
}
