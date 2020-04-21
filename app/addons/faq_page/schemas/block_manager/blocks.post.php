<?php

$schema['faq'] = [
    'content' => [
        'items' => [
            'remove_indent' => true,
            'hide_label' => true,
            'type' => 'enum',
            'object' => 'questions',
            'items_function' => 'fn_get_faq_page_questions',
            'fillings' => [
                'manually' => [
                    'picker' => 'addons/faq_page/pickers/faq_page/picker.tpl',
                    'picker_params' => [
                        'type' => 'links',
                        'positions' => true,
                    ],
                    'params' => [
                        'sort_by' => 'position',
                        'sort_order' => 'asc'
                    ]
                ],
                'newest' => [
                    'params' => [
                        'sort_by' => 'timestamp',
                        'sort_order' => 'desc',
                        'ignore_settings' => ['cid']
                    ]
                ],
            ],
        ],
    ],
    'templates' => [
        'addons/faq_page/blocks/original.tpl' => [],
    ],
    'wrappers' => 'blocks/wrappers',
    'cache' => [
        'update_handlers' => [
            'faq_questions', 'faq_question_descriptions'
        ]
    ],
    'brief_info_function' => 'fn_block_get_block_with_items_info'
];

return $schema;
