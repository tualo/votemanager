<?php

namespace Tualo\Office\VoteManager\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSFiles;
use Tualo\Office\DS\DSTable;

class Cropped extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return 'votemanager.image';
    }
    public static function register()
    {


        BasicRoute::add('/tualocms/page/cropped/(?P<id>[\/.\w\d\-\_\.]+)' . '', function ($matches) {
            $matches['type'] = 'portrait';

            if ($matches['type'] == 'portrait') {

                //                $kandidaten = DSTable::instance('kandidaten')->f('id', '=', $matches['id'])->read()->getSingle();
                $field = 'cropped_id';
                if (is_numeric($matches['id'])) {
                    $field = 'id';
                }
                $kandidaten = DSTable::instance('kandidaten')->f($field, '=', $matches['id'])->read()->getSingle();

                $cropped = json_decode($kandidaten['imagecropdata'], true);


                $bild = DSTable::instance('kandidaten_bilder')
                    ->f('kandidat', '=', $kandidaten['id'])
                    ->f('typ', '=', 1)
                    ->read()->getSingle();

                //print_r($kandidaten);
                $image = DSFiles::instance('kandidaten_bilder');
                $imagedata = $image->getBase64('id', $bild['id'], true);

                // Bildausschnitt aus Base64-Bild erstellen
                list($mime, $data) = explode(',', $imagedata);
                $imageSource = imagecreatefromstring(base64_decode($data));

                // Ausschnitt erstellen
                $croppedImage = imagecreatetruecolor($cropped['width'], $cropped['height']);
                imagecopy(
                    $croppedImage,
                    $imageSource,
                    0,
                    0,
                    $cropped['start']['x'],
                    $cropped['start']['y'],
                    $cropped['width'],
                    $cropped['height']
                );




                // Bild in Base64 konvertieren
                ob_start();
                imagewebp($croppedImage, null, 95);
                $croppedData = ob_get_contents();
                ob_end_clean();

                $imagedata = 'data:image/webp;base64,' . base64_encode($croppedData);

                // Ressourcen freigeben
                imagedestroy($imageSource);
                imagedestroy($croppedImage);
            }

            BasicRoute::$finished = true;
            http_response_code(200);

            list($mime, $data) =  explode(',', $imagedata);
            $etag = md5($data);
            App::contenttype(str_replace('data:', '', $mime));


            // header("Last-Modified: ".gmdate("D, d M Y H:i:s", $last_modified_time)." GMT"); 
            header("Etag: $etag");
            header('Cache-Control: public');

            if (
                (isset($_SERVER['HTTP_IF_NONE_MATCH']) && (trim($_SERVER['HTTP_IF_NONE_MATCH']) == $etag))
            ) {
                header("HTTP/1.1 304 Not Modified");
                exit;
            }

            App::body(base64_decode($data));
            BasicRoute::$finished = true;
            http_response_code(200);
        }, ['get'], true, [], self::scope());










        BasicRoute::add('/votemanager/fixcropped/(?P<id>[\/.\w\d\-\_\.]+)' . '', function ($matches) {
            $matches['type'] = 'portrait';

            if ($matches['type'] == 'portrait') {

                $kandidaten = DSTable::instance('kandidaten')->f('id', '=', $matches['id'])->read()->getSingle();
                $cropped = json_decode($kandidaten['imagecropdata'], true);


                $bild = DSTable::instance('kandidaten_bilder')
                    ->f('kandidat', '=', $kandidaten['id'])
                    ->f('typ', '=', 1)
                    ->read()->getSingle();

                //print_r($kandidaten);
                $image = DSFiles::instance('kandidaten_bilder');
                $imagedata = $image->getBase64('id', $bild['id'], true);

                // Bildausschnitt aus Base64-Bild erstellen
                list($mime, $data) = explode(',', $imagedata);
                $imageSource = imagecreatefromstring(base64_decode($data));

                // Ausschnitt erstellen
                $croppedImage = imagecreatetruecolor($cropped['width'], $cropped['height']);
                imagecopy(
                    $croppedImage,
                    $imageSource,
                    0,
                    0,
                    $cropped['start']['x'],
                    $cropped['start']['y'],
                    $cropped['width'],
                    $cropped['height']
                );




                // Bild in Base64 konvertieren
                ob_start();
                imagejpeg($croppedImage, null, 95);
                $croppedData = ob_get_contents();
                ob_end_clean();

                $imagedata = 'data:image/jpeg;base64,' . base64_encode($croppedData);


                $dataToSave = [
                    '__table_name' => 'kandidaten_bilder',
                    'typ' => 3,
                    'kandidat' => $kandidaten['id'],
                    '__id' => 'kandidaten_bilder-' . uniqid(),
                    'id' => '',
                    'titel' => $bild['titel'],
                    //                    'title' => $bild['title'],
                    '__file_name' => $bild['__file_name'],
                    '__file_size' => strlen($croppedData),
                    '__file_type' => 'image/jpeg',
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

                // Ressourcen freigeben
                imagedestroy($imageSource);
                imagedestroy($croppedImage);
            }

            BasicRoute::$finished = true;
            http_response_code(200);

            list($mime, $data) =  explode(',', $imagedata);
            $etag = md5($data);
            App::contenttype(str_replace('data:', '', $mime));


            // header("Last-Modified: ".gmdate("D, d M Y H:i:s", $last_modified_time)." GMT"); 
            header("Etag: $etag");
            header('Cache-Control: public');

            if (
                (isset($_SERVER['HTTP_IF_NONE_MATCH']) && (trim($_SERVER['HTTP_IF_NONE_MATCH']) == $etag))
            ) {
                header("HTTP/1.1 304 Not Modified");
                exit;
            }

            App::body(base64_decode($data));
            BasicRoute::$finished = true;
            http_response_code(200);
        }, ['get'], true, [], self::scope());






        BasicRoute::add('/votemanager/portrait-json/(?P<id>[\/.\w\d\-\_\.]+)' . '', function ($matches) {
            $matches['type'] = 'portrait';

            App::contenttype('application/json');
            App::result('success', false);

            if ($matches['type'] == 'portrait') {

                $kandidaten = DSTable::instance('kandidaten')->f('id', '=', $matches['id'])->read()->getSingle();


                $bild = DSTable::instance('kandidaten_bilder')
                    ->f('kandidat', '=', $kandidaten['id'])
                    ->f('typ', '=', 1)
                    ->read()->getSingle();

                //print_r($kandidaten);
                $image = DSFiles::instance('kandidaten_bilder');
                $imagedata = $image->getBase64('id', $bild['id'], true);

                // Bildausschnitt aus Base64-Bild erstellen
                list($mime, $data) = explode(',', $imagedata);
                $imageSource = imagecreatefromstring(base64_decode($data));


                // Bild in Base64 konvertieren
                ob_start();
                imagejpeg($imageSource, null, 100);
                $data = ob_get_contents();
                ob_end_clean();

                file_put_contents(App::get('tempPath') . '/test.jpg', $data);

                // portrait -min-pixels 1200000 -image file
                $cmd = 'portrait -min-pixels 1200000 -image ' . App::get('tempPath') . '/test.jpg 2>&1';
                exec($cmd, $output, $return_var);
                unlink(App::get('tempPath') . '/test.jpg');
                $imagedata = implode("\n", $output);

                App::contenttype('application/json');
                App::result('success', true);
                App::result('data', json_decode($imagedata, true));
            }
            BasicRoute::$finished = true;
            http_response_code(200);
            //echo 1; exit();
        }, ['get'], true, [], self::scope());


        BasicRoute::add('/votemanager/portrait-svg/(?P<id>[\/.\w\d\-\_\.]+)' . '', function ($matches) {
            $matches['type'] = 'portrait';

            App::contenttype('image/svg+xml');
            App::result('success', false);

            if ($matches['type'] == 'portrait') {

                $kandidaten = DSTable::instance('kandidaten')->f('id', '=', $matches['id'])->read()->getSingle();


                $bild = DSTable::instance('kandidaten_bilder')
                    ->f('kandidat', '=', $kandidaten['id'])
                    ->f('typ', '=', 1)
                    ->read()->getSingle();

                //print_r($kandidaten);
                $image = DSFiles::instance('kandidaten_bilder');
                $imagedata = $image->getBase64('id', $bild['id'], true);

                // Bildausschnitt aus Base64-Bild erstellen
                list($mime, $data) = explode(',', $imagedata);
                $imageSource = imagecreatefromstring(base64_decode($data));


                // Bild in Base64 konvertieren
                ob_start();
                imagejpeg($imageSource, null, 100);
                $data = ob_get_contents();
                ob_end_clean();

                file_put_contents(App::get('tempPath') . '/test.jpg', $data);

                // portrait -min-pixels 1200000 -image file
                $cmd = 'portrait -min-pixels 1200000 -image ' . App::get('tempPath') . '/test.jpg 2>&1';
                exec($cmd, $output, $return_var);
                unlink(App::get('tempPath') . '/test.jpg');
                $jsondata = implode("\n", $output);

                /*
                beispielausgabe:
                {
                    "rectangle": {
                        "x": 323,
                        "y": 2343,
                        "x2": 1346,
                        "y2": 3707
                    },
                    "width": 1023,
                    "height": 1364,
                    "aspect_ratio": 0.75,
                    "pixel_count": 1395372,
                    "face_detected": true
                }
                */

                $portraitData = json_decode($jsondata, true);
                $imgWidth = imagesx($imageSource);
                $imgHeight = imagesy($imageSource);

                // SVG erstellen - responsiv ohne feste Größe
                $svg = '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
                $svg .= '<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 ' . $imgWidth . ' ' . $imgHeight . '" preserveAspectRatio="xMidYMid meet">' . "\n";
                $svg .= '  <image href="' . $imagedata . '" x="0" y="0" width="' . $imgWidth . '" height="' . $imgHeight . '" />' . "\n";

                // Rechteck zeichnen falls Face erkannt wurde
                if (isset($portraitData['rectangle'])) {
                    $rect = $portraitData['rectangle'];
                    $rectWidth = $rect['x2'] - $rect['x'];
                    $rectHeight = $rect['y2'] - $rect['y'];
                    $svg .= '  <rect x="' . $rect['x'] . '" y="' . $rect['y'] . '" width="' . $rectWidth . '" height="' . $rectHeight . '" fill="none" stroke="blue" stroke-width="5" />' . "\n";
                }

                $svg .= '</svg>';

                App::contenttype('image/svg+xml');
                App::body($svg);
                // **
            }
            BasicRoute::$finished = true;
            http_response_code(200);
            //echo 1; exit();
        }, ['get'], true, [], self::scope());
    }
}
