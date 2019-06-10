<?php
//castle defender pmg packer

$levelnames = array("1","2","3","4_1");
$levels = 4;

//deflate 4 generated level png files
for ($i = 0; $i < $levels; $i++)
    {
	    $name = getcwd() . "\\lvl" . ($levelnames[$i]) . ".pmg";
        exec(getcwd() . "\\..\\tools\\zopfli --deflate --i350 $name");
        echo $name, ".deflate - ",filesize($name), " => ",filesize($name . ".deflate"), "\n";
    }
?>
