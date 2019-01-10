<?php
//castle defender level packer

$levels = 4;

//deflate 4 generated level fnt files
for ($i = 0; $i < $levels; $i++)
    {
	    $name = getcwd() . "\\L" . ($i+1) . ".fnt";
        exec(getcwd() . "\\..\\tools\\zopfli --deflate --i150 $name");
        echo $name, ".deflate - ",filesize($name), " => ",filesize($name . ".deflate"), "\n";
    }

//deflate 4 generated level data files
for ($i = 0; $i < $levels; $i++)
    {
	    $name = getcwd() . "\\L" . ($i+1) . "data.bin";
        exec(getcwd() . "\\..\\tools\\zopfli --deflate --i150 $name");
        echo $name, ".deflate - ",filesize($name), " => ",filesize($name . ".deflate"), "\n";
    }
?>
