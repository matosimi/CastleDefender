<?php
//deflate atari texts and font
exec(getcwd() . "\\..\\tools\\zopfli --deflate --i350 -v scrolltext.xex");
exec(getcwd() . "\\..\\tools\\zopfli --deflate --i350 -v title.fnt");

?>
