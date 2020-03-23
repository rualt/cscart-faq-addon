<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) {
    die('Access denied');
}

if ($mode == 'manage') {
// list($banners, $params) = fn_get_banners($_REQUEST, DESCR_SL,
// Registry::get('settings.Appearance.admin_elements_per_page'));

    $question = 'Whazaap?';

    // Tygh::$app['view']->assign(
    //     'banners'  => $banners,
    //     'search' => $params,
    // ));

    Tygh::$app['view']->assign(
        'question' => $question,
    );
}
