<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) {
    die('Access denied');
}

if ($mode == 'view') {
    fn_add_breadcrumb(__('faq'));

    list($questions, $params) = fn_get_questions(
        $_REQUEST,
        DESCR_SL,
        Registry::get('settings.Appearance.admin_elements_per_page')
    );

    // $breadcrumbs = Tygh::$app['view']->getTemplateVars('breadcrumbs');
    Tygh::$app['view']->assign([
        'questions'  => $questions,
        'search' => $params
    ]);
}
