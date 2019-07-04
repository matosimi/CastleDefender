<?php
//castle defender logo packer

//deflate 
$name = getcwd() . "\\levcomp.fnt";
exec(getcwd() . "\\..\\tools\\zopfli --deflate --i350 $name");
echo $name, ".deflate - ",filesize($name), " => ",filesize($name . ".deflate"), "\n";

$name = getcwd() . "\\windef.fnt";
exec(getcwd() . "\\..\\tools\\zopfli --deflate --i350 $name");
echo $name, ".deflate - ",filesize($name), " => ",filesize($name . ".deflate"), "\n";

?>
