<?php

use Tygh\Registry;
use Tygh\Languages\Languages;
use Tygh\BlockManager\Block;
use Tygh\Tools\SecurityHelper;

if (!defined('BOOTSTRAP')) { die('Access denied'); }


function fn_faq_page_update_question($data, $question_id, $lang_code = DESCR_SL) {

    SecurityHelper::sanitizeObjectData('question', $data);

    if (isset($data['timestamp'])) {
        $data['timestamp'] = fn_parse_date($data['timestamp']);
    }

    $data['localization'] = empty($data['localization']) ? '' : fn_implode_localizations($data['localization']);

    if (!empty($question_id)) {
        db_query("UPDATE ?:questions SET ?u WHERE question_id = ?i", $data, $question_id);
        db_query("UPDATE ?:question_descriptions SET ?u WHERE question_id = ?i AND lang_code = ?s", $data, $question_id, $lang_code);
    } else {
        $question_id = $data['question_id'] = db_query("REPLACE INTO ?:questions ?e", $data);

        foreach (Languages::getAll() as $data['lang_code'] => $v) {
            db_query("REPLACE INTO ?:question_descriptions ?e", $data);
        }
    }
    return $question_id;
}
