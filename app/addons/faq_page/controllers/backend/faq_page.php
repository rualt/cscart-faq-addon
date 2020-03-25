<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) {
    die('Access denied');
}

if ($_SERVER['REQUEST_METHOD']	== 'POST') {

    //
    // Add/edit banners
    //
    if ($mode == 'update') {
        $banner_id = fn_faq_page_update_question($_REQUEST['question_data'], $_REQUEST['question_id'], DESCR_SL);

        $question_id = $_REQUEST['question_id'];

        $suffix = ".update?question_id=$question_id";
    }

    return array(CONTROLLER_STATUS_OK, 'faq_page' . $suffix);
}

//
// GET SECTION
//

if ($mode == 'update') {

    $question = fn_get_question_data($_REQUEST['question_id'], DESCR_SL);

    if (empty($question)) {
        return array(CONTROLLER_STATUS_NO_PAGE);
    }

    Registry::set('navigation.tabs', array (
        'general' => array (
            'title' => __('general'),
            'js' => true
        ),
    ));

    Tygh::$app['view']->assign('question', $question);

} elseif ($mode == 'manage') {

    list($questions, $params) = fn_get_questions($_REQUEST, DESCR_SL, Registry::get('settings.Appearance.admin_elements_per_page'));

    Tygh::$app['view']->assign([
        'questions'  => $questions
    ]);
}
