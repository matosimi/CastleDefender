<?php
//castle defender level packer

$levelnames = array("1","2","3","41");
$levels = 4;

//deflate 4 generated level fnt files
for ($i = 0; $i < $levels; $i++)
    {
	    $name = getcwd() . "\\L" . ($levelnames[$i]) . ".fnt";
        exec(getcwd() . "\\..\\tools\\zopfli --deflate --i350 $name");
        echo $name, ".deflate - ",filesize($name), " => ",filesize($name . ".deflate"), "\n";
    }

//deflate 4 generated level data files
for ($i = 0; $i < $levels; $i++)
    {
	    $name = getcwd() . "\\L" . ($i+1) . "data.bin";
        exec(getcwd() . "\\..\\tools\\zopfli --deflate --i350 $name");
        echo $name, ".deflate - ",filesize($name), " => ",filesize($name . ".deflate"), "\n";
    }
?>
