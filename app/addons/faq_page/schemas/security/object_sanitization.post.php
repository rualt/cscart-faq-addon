<?php

use Tygh\Tools\SecurityHelper;

$schema['question'] = array(
    SecurityHelper::SCHEMA_SECTION_FIELD_RULES => array(
        'question' => SecurityHelper::ACTION_REMOVE_HTML,
        'answer' => SecurityHelper::ACTION_SANITIZE_HTML
    )
);

return $schema;
