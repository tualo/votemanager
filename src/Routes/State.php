<?php

namespace Tualo\Office\VoteManager\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;

class State extends \Tualo\Office\Basic\RouteWrapper
{
    public static function putRequest(string $url, string  $data): array
    {
        $success = false;
        $msg = '';
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, FALSE);
        curl_setopt($ch, CURLOPT_NOBODY, FALSE);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Expect:'));
        curl_setopt($ch, CURLOPT_TIMEOUT, 3);

        $data = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $json = json_decode($data, true);
        if (is_null($json)) {
            $success = false;
            $msg = 'Invalid JSON response';
        } else if ($httpCode != 200) {
            $success = false;
            $msg = 'Nicht erlaubte Aktion (HTTP Code ' . $httpCode . ')';
        } else if (isset($json['success']) && $json['success'] === true) {
            $success = true;
            $msg = 'OK';
        } else if (isset($json['success']) && $json['success'] === false) {
            $success = false;
            $msg = $json['msg'] ?? 'Unknown error';
        }
        if ($data === false) {
            $data = '';
        }
        return [
            'success' => $success,
            'msg' => $msg
        ];
    }


    public static function scope(): string
    {
        return  'basic'; // 'votemanager.state';
    }

    public static function register()
    {
        BasicRoute::add('/votemanager/state', function () {
            App::contenttype('application/json');
            App::result('success', false);
            try {

                $session = App::get('session');
                $db = $session->getDB();
                App::result('phase', $db->singleValue('select phase from voting_state', [], 'phase'));


                App::result('success', true);
            } catch (\Exception $e) {
                App::result('msg', $e->getMessage());
            }
        }, ['get'], true, [], self::scope());

        BasicRoute::add('/votemanager/state', function () {
            App::contenttype('application/json');
            App::result('success', false);
            $session = App::get('session');
            $db = $session->getDB();
            try {

                $putData = file_get_contents('php://input');
                $data = json_decode($putData, true);
                $db->direct('start transaction;');
                $db->direct('update voting_state set phase={phase}', ['phase' => $data['phase']]);

                // ggf an die onlinewahl schicken
                if (class_exists('\Tualo\Office\PaperVote\APIRequestHelper')) {

                    $o = $db->directMap("
                        select if(property<>'',1,0) v,'api' text FROM system_settings WHERE system_settings_id = 'remote-erp/url' 
                        union all
                        select property v,'api_url' text FROM system_settings WHERE system_settings_id = 'remote-erp/url'
                        union all
                        select property v,'api_token' text FROM system_settings WHERE system_settings_id = 'remote-erp/token'
                        union all
                        select property v,'api_private' text FROM system_settings WHERE system_settings_id = 'erp/privatekey'
                    ", [], 'text', 'v');

                    if (isset($o['api_url'])) {
                        $put_result = self::putRequest($o['api_url'] . '/~/' . $o['api_token'] . '/onlinevote/votemanager/state', $putData);
                        if (!$put_result['success']) {
                            throw new \Exception('Remote API Error: ' . $put_result['msg']);
                        }

                        App::result('put_result', $put_result);
                    }
                }

                App::result('success', true);
                $db->direct('commit;');
            } catch (\Exception $e) {
                $db->direct('rollback;');
                App::result('msg', $e->getMessage());
            }
        }, ['put'], true, [], self::scope());
    }
}
