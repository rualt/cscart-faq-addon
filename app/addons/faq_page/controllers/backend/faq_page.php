<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) {
    die('Access denied');
}

$questions = [
    [
        'question_id' => 1,
        'question' => "ВОПРОС 1. Что будет если если если если если если если если да кабы",
        'answer' => 'Ответ 1. Будет то то и то то, то то и то то, то то и то то, то то и то',
        'author' => 'John Snow',
        'position' => 20,
        'status' => "A",
    ],
    [
        'question_id' => 2,
        'question' => "ВОПРОС 2. Что будет если если если если если если если если да кабы",
        'answer' => 'Ответ 2. Будет то то и то то, то то и то то, то то и то то, то то и то',
        'author' => 'Tirion Lannister',
        'position' => 10,
        'status' => "A"
    ],
    [
        'question_id' => 3,
        'question' => "ВОПРОС 3. Что будет если если если если если если если если да кабы",
        'answer' => 'Ответ 3. Будет то то и то то, то то и то то, то то и то то, то то и то',
        'author' => 'Aria Stark',
        'position' => 30,
        'status' => "A"
    ]
];

if ($_SERVER['REQUEST_METHOD']	== 'POST') {

    // fn_trusted_vars('banners', 'banner_data');
    // $suffix = '';

    // //
    // // Delete banners
    // //
    // if ($mode == 'm_delete') {
    //     foreach ($_REQUEST['banner_ids'] as $v) {
    //         fn_delete_banner_by_id($v);
    //     }

    //     $suffix = '.manage';
    // }

    //
    // Add/edit banners
    //
    if ($mode == 'update') {
        $banner_id = fn_faq_page_update_question($_REQUEST['question_data'], $_REQUEST['question_id'], DESCR_SL);

        $question_id = $_REQUEST['question_id'];

        $suffix = ".update?question_id=$question_id";
    }

    // if ($mode == 'delete') {
    //     if (!empty($_REQUEST['banner_id'])) {
    //         fn_delete_banner_by_id($_REQUEST['banner_id']);
    //     }

    //     $suffix = '.manage';
    // }

    return array(CONTROLLER_STATUS_OK, 'faq_page' . $suffix);
}

if ($mode == 'update') {
    //temporary data
    $question = [];
    foreach ($questions as $array) {
        if (($array['question_id']) == $_REQUEST['question_id']) {
            $question = $array;
        }
    }

    // $banner = fn_get_banner_data($_REQUEST['banner_id'], DESCR_SL);

    // if (empty($banner)) {
    //     return array(CONTROLLER_STATUS_NO_PAGE);
    // }

    // Registry::set('navigation.tabs', array (
    //     'general' => array (
    //         'title' => __('general'),
    //         'js' => true
    //     ),
    // ));

    Tygh::$app['view']->assign('question', $question);
} elseif ($mode == 'manage') {
// list($banners, $params) = fn_get_banners($_REQUEST, DESCR_SL, Registry::get('settings.Appearance.admin_elements_per_page'));

   

    Tygh::$app['view']->assign([
        'questions'  => $questions
    ]);

    // Tygh::$app['view']->assign('question', $question);
}
