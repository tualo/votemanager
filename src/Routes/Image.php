<?php

namespace Tualo\Office\VoteManager\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSFiles;

class Image extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        /*
        insert ignore into route_scopes (`scope`) values ('votemanager.image');
        insert ignore into route_scopes_permissions (`scope`, `group`, `allowed`) values ('votemanager.image', '_default_', 1);

        */
        return 'votemanager.image';
    }
    public static function register()
    {


        BasicRoute::add('/tualocms/page/votemanager/(?P<type>[\/.\w\d\-\_\.]+)/(?P<id>[\/.\w\d\-\_\.]+)' . '', function ($matches) {


            if ($matches['type'] == 'portrait') {
                $image = DSFiles::instance('kandidaten_bilder');
                $imagedata = $image->getBase64('id', $matches['id'], true);
            } else if ($matches['type'] == 'img') {
                $image = DSFiles::instance('tualocms_bilder');
                $imagedata = $image->getBase64('titel', $matches['id'], true);
            }
            $image_error = $image->getError();
            if ($image_error != '') {

                $image = DSFiles::instance('tualocms_bilder');
                $imagedata = $image->getBase64('titel', 'sample-male', true);
                $image_error = $image->getError();
                if ($image_error != '') {
                    throw new \Exception($image_error);
                }
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
    }
}
