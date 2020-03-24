<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) {
    die('Access denied');
}

if ($mode == 'manage') {
// list($banners, $params) = fn_get_banners($_REQUEST, DESCR_SL,
// Registry::get('settings.Appearance.admin_elements_per_page'));

    $questions = [
        [   
            'question_id' => 1,
            'question' => "question 1?",
            'answer' => 'answer 1',
            'author' => 'John Snow',
            'position' => 20,
            'status' => "A",
        ],
        [   
            'question_id' => 2,
            'question' => "question 2?",
            'answer' => 'answer 2',
            'author' => 'Tirion Lannister',
            'position' => 10,
            'status' => "A"
        ],
        [   
            'question_id' => 3,
            'question' => "question 3?",
            'answer' => 'answer 3',
            'author' => 'Aria Stark',
            'position' => 30,
            'status' => "A"
        ]
    ];
    $answer = "It's alright dog";

    Tygh::$app['view']->assign([
        'questions'  => $questions,
        'answer' => $answer,
    ]);

    // Tygh::$app['view']->assign('question', $question);
}
