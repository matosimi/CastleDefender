<?php
//castle defender wave data packer
//deflate 20 generated wave data files

$levels = 4;
$waves = 5; 

for ($i = 0; $i < $levels; $i++)
    for ($j = 0; $j < $waves; $j++)
    {
        $name = getcwd() . "\\L" . ($i+1) . "W" . ($j+1) . ".bin";
        exec(getcwd() . "\\..\\tools\\zopfli --deflate --i150 $name");
        echo $name, ".deflate - ",filesize($name), " => ",filesize($name . ".deflate"), "\n";
    }

?>
