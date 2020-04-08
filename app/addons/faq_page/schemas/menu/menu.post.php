<?php

$schema['central']['website']['items']['faq'] = [
    'attrs' => [
        'class' => 'is-addon'
    ],
    'href' => 'faq_page.manage',
    'position' => 900
];

$schema['top']['administration']['items']['import_data']['subitems']['faq'] = [
    'href' => 'exim.import?section=faq',
    'position' => 600,
];

$schema['top']['administration']['items']['export_data']['subitems']['faq'] = [
    'href' => 'exim.export?section=faq',
    'position' => 600,
];

return $schema;
