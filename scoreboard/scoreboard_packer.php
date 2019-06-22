<?php
//castle defender scoreboard packer

//deflate 
$name = getcwd() . "\\scoreboard.fnt";
exec(getcwd() . "\\..\\tools\\zopfli --deflate --i350 $name");
echo $name, ".deflate - ",filesize($name), " => ",filesize($name . ".deflate"), "\n";

?>
