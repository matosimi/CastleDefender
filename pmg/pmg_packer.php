<?php
//castle defender pmg packer

$levels = 4;

//deflate 4 generated level png files
for ($i = 0; $i < $levels; $i++)
    {
	    $name = getcwd() . "\\lvl" . ($i+1) . ".pmg";
        exec(getcwd() . "\\..\\tools\\zopfli --deflate --i150 $name");
        echo $name, ".deflate - ",filesize($name), " => ",filesize($name . ".deflate"), "\n";
    }
?>
