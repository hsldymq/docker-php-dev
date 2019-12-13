<?php

$showVersion = ($argv[1] ?? 'n') === 'y';
$exts = array_merge(get_loaded_extensions(false));
natcasesort($exts);

foreach ($exts as $each) {
    echo "* {$each}";
    if ($showVersion) {
        echo ": ".phpversion($each).PHP_EOL;
    } else {
        echo "\n";
    }
}