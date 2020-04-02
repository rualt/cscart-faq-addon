<?php

use Tygh\Registry;
use Tygh\Languages\Languages;
use Tygh\BlockManager\Block;
use Tygh\Tools\SecurityHelper;

if (!defined('BOOTSTRAP')) {
    die('Access denied');
}

function fn_get_questions($params = array(), $lang_code = CART_LANGUAGE, $items_per_page = 0)
{
    // Set default values to input params
    $default_params = array(
        'page' => 1,
        'items_per_page' => $items_per_page
    );

    $params = array_merge($default_params, $params);

    if (AREA == 'C') {
        $params['status'] = 'A';
    }

    $sortings = array(
        'position' => '?:faq_questions.position',
        'timestamp' => '?:faq_questions.timestamp',
        'name' => '?:faq_question_descriptions.question',
        'author' => '?:faq_question_descriptions.author',
        'status' => '?:faq_questions.status',
    );

    $condition = $limit = $join = '';

    if (!empty($params['limit'])) {
        $limit = db_quote(' LIMIT 0, ?i', $params['limit']);
    }

    $sorting = db_sort($params, $sortings, 'position', 'asc');

    if (!empty($params['item_ids'])) {
        $condition .= db_quote(' AND ?:faq_questions.question_id IN (?n)', explode(',', $params['item_ids']));
    }

    if (!empty($params['name'])) {
        $condition .= db_quote(' AND ?:faq_question_descriptions.question LIKE ?l', '%' . trim($params['name']) . '%');
    }

    if (!empty($params['status'])) {
        $condition .= db_quote(' AND ?:faq_questions.status = ?s', $params['status']);
    }

    if (!empty($params['period']) && $params['period'] != 'A') {
        list($params['time_from'], $params['time_to']) = fn_create_periods($params);
        $condition .= db_quote(
            ' AND (?:faq_questions.timestamp >= ?i AND ?:faq_questions.timestamp <= ?i)',
            $params['time_from'],
            $params['time_to']
        );
    }

    $fields = array(
        '?:faq_questions.question_id',
        '?:faq_questions.timestamp',
        '?:faq_questions.status',
        '?:faq_questions.position',
        '?:faq_question_descriptions.question',
        '?:faq_question_descriptions.answer',
        '?:faq_question_descriptions.author',
    );

    $join .= db_quote(
        ' LEFT JOIN ?:faq_question_descriptions ON ?:faq_question_descriptions.question_id = 
        ?:faq_questions.question_id AND ?:faq_question_descriptions.lang_code = ?s',
        $lang_code
    );

    if (!empty($params['items_per_page'])) {
        $params['total_items'] = db_get_field("SELECT COUNT(*) FROM ?:faq_questions $join WHERE 1 $condition");
        $limit = db_paginate($params['page'], $params['items_per_page'], $params['total_items']);
    }

    $questions = db_get_hash_array(
        "SELECT ?p FROM ?:faq_questions " .
        $join .
        "WHERE 1 ?p ?p ?p",
        'question_id',
        implode(', ', $fields),
        $condition,
        $sorting,
        $limit
    );

    if (!empty($params['item_ids'])) {
        $questions = fn_sort_by_ids($questions, explode(',', $params['item_ids']), 'question_id');
    }

    // fn_set_hook('get_questions_post', $questions, $params);

    return array($questions, $params);
}

function fn_get_question_data($question_id, $lang_code = CART_LANGUAGE)
{
    // Unset all SQL variables
    $fields = $joins = array();
    $condition = '';

    $fields = array(
        '?:faq_questions.question_id',
        '?:faq_questions.status',
        '?:faq_question_descriptions.question',
        '?:faq_questions.timestamp',
        '?:faq_questions.position',
        '?:faq_question_descriptions.author',
        '?:faq_question_descriptions.answer',
    );

    if (fn_allowed_for('ULTIMATE')) {
        $fields[] = '?:faq_questions.company_id as company_id';
    }

    $joins[] = db_quote(
        "LEFT JOIN ?:faq_question_descriptions ON ?:faq_question_descriptions.question_id = 
        ?:faq_questions.question_id AND ?:faq_question_descriptions.lang_code = ?s",
        $lang_code
    );

    $condition = db_quote("WHERE ?:faq_questions.question_id = ?i", $question_id);
    $condition .= (AREA == 'A') ? '' : " AND ?:faq_questions.status IN ('A', 'H') ";

    // /**
    //  * Prepare params for question data SQL query
    //  *
    //  * @param int   $question_id question ID
    //  * @param str   $lang_code Language code
    //  * @param array $fields    Fields list
    //  * @param array $joins     Joins list
    //  * @param str   $condition Conditions query
    //  */
    // fn_set_hook('get_question_data', $question_id, $lang_code, $fields, $joins, $condition);

    $question = db_get_row(
        "SELECT "
        . implode(", ", $fields)
        . " FROM ?:faq_questions "
        . implode(" ", $joins)
        ." $condition"
    );

    // /**
    //  * Post processing of question data
    //  *
    //  * @param int   $question_id question ID
    //  * @param str   $lang_code Language code
    //  * @param array $question    question data
    //  */
    // fn_set_hook('get_question_data_post', $question_id, $lang_code, $question);

    return $question;
}

/**
 * Deletes faq question and all related data
 *
 * @param int $question_id Question identificator
 */
function fn_delete_question_by_id($question_id)
{
    if (!empty($question_id)) {
        db_query("DELETE FROM ?:faq_questions WHERE question_id = ?i", $question_id);
        db_query("DELETE FROM ?:faq_question_descriptions WHERE question_id = ?i", $question_id);

        // fn_set_hook('delete_banners', $question_id);
        // Block::instance()->removeDynamicObjectData('questions', $question_id);
    }
}

function fn_faq_page_update_question($data, $question_id, $lang_code = DESCR_SL)
{
    SecurityHelper::sanitizeObjectData('question', $data);

    if (isset($data['timestamp'])) {
        $data['timestamp'] = fn_parse_date($data['timestamp']);
    }

    if (!empty($question_id)) {
        db_query("UPDATE ?:faq_questions SET ?u WHERE question_id = ?i", $data, $question_id);
        db_query(
            "UPDATE ?:faq_question_descriptions"
            . ' SET ?u'
            . ' WHERE question_id = ?i'
            . ' AND lang_code = ?s',
            $data,
            $question_id,
            $lang_code
        );
    } else {
        $question_id = $data['question_id'] = db_query("REPLACE INTO ?:faq_questions ?e", $data);

        foreach (Languages::getAll() as $data['lang_code'] => $v) {
            db_query("REPLACE INTO ?:faq_question_descriptions ?e", $data);
        }
    }
    return $question_id;
}
