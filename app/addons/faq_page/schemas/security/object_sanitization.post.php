<?php

use Tygh\Tools\SecurityHelper;

$schema['question'] = [
    SecurityHelper::SCHEMA_SECTION_FIELD_RULES => [
        'question' => SecurityHelper::ACTION_REMOVE_HTML,
        'answer' => SecurityHelper::ACTION_SANITIZE_HTML
    ]
];

return $schema;
