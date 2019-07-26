<?php
//deflate rmt module incl. its 6-byte header
exec(getcwd() . "\\..\\tools\\zopfli --deflate --i350 -v menu_stripped_1000.rmt");

?>
