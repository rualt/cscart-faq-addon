<?php

use Tygh\Registry;

defined('BOOTSTRAP') or die('Access denied');

if ($mode == 'view') {
    fn_add_breadcrumb(__('faq'));

    list($questions, $params) = fn_get_faq_page_questions(
        $_REQUEST,
        DESCR_SL,
        Registry::get('settings.Appearance.admin_elements_per_page')
    );

    Tygh::$app['view']->assign([
        'questions'  => $questions,
        'search' => $params
    ]);
}
