<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) {
    die('Access denied');
}

if ($mode == 'view') {
    $test = 'this is a view mode';

    list($questions, $params) = fn_get_questions($_REQUEST, DESCR_SL, Registry::get('settings.Appearance.admin_elements_per_page'));
    db_sort($params, $sortings, 'position', 'asc');
    Tygh::$app['view']->assign([
        'questions'  => $questions,
        'search' => $params
    ]);
}
