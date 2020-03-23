<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) {
    die('Access denied');
}

if ($mode == 'manage') {
// list($banners, $params) = fn_get_banners($_REQUEST, DESCR_SL,
// Registry::get('settings.Appearance.admin_elements_per_page'));

    $question = 'Whazaap?';
    $answer = "It's alright dog";

    Tygh::$app['view']->assign([
        'question'  => $question,
        'answer' => $answer,
    ]);

    // Tygh::$app['view']->assign('question', $question);
}
