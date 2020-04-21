<?php

use Tygh\Registry;

$schema = [
    'section' => 'faq',
    'pattern_id' => 'faq',
    'name' => __('faq'),
    'key' => ['question_id'],
    'order' => 5,
    'table' => 'faq_questions',
    'references' => [
        'faq_question_descriptions' => [
            'reference_fields' => ['question_id' => '#key', 'lang_code' => '#lang_code'],
            'join_type' => 'LEFT'
        ],
    ],
    'options' => [
        'lang_code' => [
            'title' => 'language',
            'type' => 'languages',
            'default_value' => [DEFAULT_LANGUAGE],
        ],
    ],
    'export_fields' => [
        'Question ID' => [
            'db_field' => 'question_id',
            'alt_key' => true,
            'required' => true,
        ],
        'Language' => [
            'table' => 'faq_question_descriptions',
            'db_field' => 'lang_code',
            'type' => 'languages',
            'required' => true,
            'multilang' => true
        ],
        'Question' => [
            'table' => 'faq_question_descriptions',
            'db_field' => 'question',
            'required' => true,
            'multilang' => true,
        ],
        'Answer' => [
            'table' => 'faq_question_descriptions',
            'db_field' => 'answer',
            'multilang' => true,
        ],
        'Author' => [
            'table' => 'faq_question_descriptions',
            'db_field' => 'author',
            'multilang' => true,
        ],
        'Creation Date' => [
            'db_field' => 'timestamp',
            'process_get' => ['fn_timestamp_to_date', '#this'],
            'convert_put' => ['fn_date_to_timestamp', '#this'],
        ],
        'Position' => [
            'db_field' => 'position',
        ],
        'Status' => [
            'db_field' => 'status',
        ],
    ]
];

return $schema;
