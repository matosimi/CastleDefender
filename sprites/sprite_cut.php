<?php
//castle defender sprite cutter to 14+14 bytes + merger (output to allsprites.fnt)
//input are files from sprite_convert.php and other files based on same design
//takes converted sprite fnt files (4 chars) and converts them to 14-line format
//suitable for gamecode
//sprite pre-shifting has been moved to 6502 code

$name = getcwd() . "\\allsprites.fnt";
$ofi=fopen($name,"wb");
if (!$ofi) { echo "Can't open file $name for writing.\n"; exit(); }

echo "sprite_base\tins '\\sprites\\allsprites.fnt'\n";
$shift = 0;

cut("E1","exp1");
cut("E2","exp2");
cut("E3","exp3");
cut("E4","exp4");
cut("S1","spra");
cut("S1b","sprb");
cut("S1c","sprc");
cut("S2","sprd");
cut("S2b","spre");
cut("S2c","sprf");
cut("S3","sprg");
cut("S3b","sprh");
cut("S4a","spri");
cut("S4b","sprj");
cut("S4c","sprk");
cut("S4d","sprl");
cut("S5","sprm");
cut("S5b","sprn");
cut("S6","spro");
cut("S6b","sprp");
cut("S7","sprq");
cut("S7b","sprr");
cut("S8a","sprs");


fclose($ofi);

//packing - all sprite data needed all the time (so maybe no need to pack)
exec(getcwd() . "\\..\\tools\\zopfli --deflate --i350 $name");
echo $name, ".deflate - ",filesize($name), " => ",filesize($name . ".deflate"), "\n";


function cut($input, $output)
{
	$name = getcwd() . "\\" . $input . ".fnt";
	$fi=fopen($name,"rb");
	if (!$fi) { echo "Can't open file $name.\n"; exit(); }
	$data=@fread($fi,16*2);
	fclose($fi);

	for ($i = 0; $i < 14; $i++)
		fwrite($GLOBALS['ofi'], $data[$i]);
	for ($i = 0; $i < 14; $i++)
		fwrite($GLOBALS['ofi'], $data[$i+16]);
		
	echo "$output\tequ sprite_base+" . $GLOBALS['shift']*2*14 . "\n";
	$GLOBALS['shift']++;
}


?>
