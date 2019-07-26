<?php
//deflate g2f scr,font,pmg 

$basename = "cd_title";
//exec(getcwd() . "\\..\\tools\\zopfli --deflate --i350 -v $basename.pmg");
exec(getcwd() . "\\..\\..\\tools\\zopfli --deflate --i350 -v $basename.fnt");
exec(getcwd() . "\\..\\..\\tools\\zopfli --deflate --i350 -v $basename.scr");
?>
