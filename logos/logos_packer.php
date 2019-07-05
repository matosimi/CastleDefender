<?php
//castle defender logo packer

//deflate 

$name = getcwd() . "\\levcomp2.fnt";
exec(getcwd() . "\\..\\tools\\zopfli --deflate --i3500 $name");
echo $name, ".deflate - ",filesize($name), " => ",filesize($name . ".deflate"), "\n";

$name = getcwd() . "\\windef.fnt";
exec(getcwd() . "\\..\\tools\\zopfli --deflate --i3500 $name");
echo $name, ".deflate - ",filesize($name), " => ",filesize($name . ".deflate"), "\n";

?>
