<?php

use Tygh\Registry;

$schema = array(
    'section' => 'faq',
    'pattern_id' => 'faq',
    'name' => __('faq'),
    'key' => array('question_id'),
    'order' => 5,
    'table' => 'faq_questions',
    'references' => array(
        'faq_question_descriptions' => array(
            'reference_fields' => array('question_id' => '#key', 'lang_code' => '#lang_code'),
            'join_type' => 'LEFT'
        ),
    ),
    'options' => array(
        'lang_code' => array(
            'title' => 'language',
            'type' => 'languages',
            'default_value' => array(DEFAULT_LANGUAGE),
        ),
    ),
    'export_fields' => array(
        'Question ID' => array(
            'db_field' => 'question_id',
            'alt_key' => true,
            'required' => true,
        ),
        'Language' => array(
            'table' => 'faq_question_descriptions',
            'db_field' => 'lang_code',
            'type' => 'languages',
            'required' => true,
            'multilang' => true
        ),
        'Question' => array(
            'table' => 'faq_question_descriptions',
            'db_field' => 'question',
            'required' => true,
            'multilang' => true,
        ),
        'Answer' => array(
            'table' => 'faq_question_descriptions',
            'db_field' => 'answer',
            'multilang' => true,
        ),
        'Author' => array(
            'table' => 'faq_question_descriptions',
            'db_field' => 'author',
            'multilang' => true,
        ),
        'Creation Date' => array(
            'db_field' => 'timestamp',
            'process_get' => array('fn_timestamp_to_date', '#this'),
            'convert_put' => array('fn_date_to_timestamp', '#this'),
        ),
        'Position' => array(
            'db_field' => 'position',
        ),
        'Status' => array(
            'db_field' => 'status',
        ),
    )
);

return $schema;
