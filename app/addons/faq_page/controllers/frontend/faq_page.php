<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) {
    die('Access denied');
}

if ($mode == 'view') {

    list($questions, $params) = fn_get_questions(
        $_REQUEST,
        DESCR_SL,
        Registry::get('settings.Appearance.admin_elements_per_page')
    );

    Tygh::$app['view']->assign([
        'questions'  => $questions,
        'search' => $params
    ]);
}
