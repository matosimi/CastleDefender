<?php
//deflate rmt module incl. its 6-byte header
exec(getcwd() . "\\..\\tools\\zopfli --deflate --i350 -v menu_stripped_5b00.rmt");

?>
