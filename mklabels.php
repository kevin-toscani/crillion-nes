<?php

/**
 *  mklabels.php
 *
 *  Primitive script to generate a Mesen label file (.mlb) from asm6 demo output
 *
 **/
 
 
 
// Set default labels (or, rather, label)
$labels = [
    'R:0200:sprite_ram',
];

// Get demo output
$file = file_get_contents('output/crillion.txt');
$lines = explode("\n", $file);

// Go through all lines
foreach($lines as $line) {
    
    // Find RAM labels
    if(preg_match("/^0(0[0-9A-F]{3})\s+([a-zA-Z0-9_]+)\s+\.dsb ([0-9]+)/", $line, $match)) {
        list($void, $address, $label, $length) = $match;
        if($length == 1) {
            $labels[] = 'R:' . $address . ':' . $label;
            continue;
        }

        $address_end = strtoupper(str_pad(dechex(hexdec($address) + $length - 1), 4, '0', STR_PAD_LEFT));

        $labels[] = 'R:' . $address . '-' . $address_end . ':' . $label;
        continue;
    }
    
    // Find subroutines, tables and level data
    if(preg_match("/^0([0-9A-F]{4})\s+(sub|tbl|lvl)_([a-zA-Z0-9_]+):/", $line, $match)) {
        $labels[] = 'G:' . $match[1] . ':' . $match[2] . '_' . $match[3];
    }
    
    // Find interrupt addresses
    if(preg_match("/^0([0-9A-F]{4})\s+(RESET|IRQ|NMI):/", $line, $match)) {
        $labels[] = 'G:' . $match[1] . ':' . $match[2];
    }
}

$fh = fopen('output/crillion.mlb', 'w');
fwrite($fh, implode("\r\n", $labels) . "\r\n");
fclose($fh);
