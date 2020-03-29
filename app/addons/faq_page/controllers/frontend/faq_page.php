<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) {
    die('Access denied');
}

if ($mode == 'view') {
    $test = 'this is a view mode';
    Tygh::$app['view']->assign('test', $test);
}
