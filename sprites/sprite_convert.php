<?php
//castle defender sprite converter
//converts bbc micro videodata mode 1 to mode 4 same as atari mode $0f (gr.8)

convert("1");
convert("2");
convert("3");
convert("4");
convert("5");
convert("6");
convert("7");
convert("8");


function convert($number)
{
$name = getcwd() . "\..\srcdata\\S." . $number;
$fi=fopen($name,"rb");
if (!$fi) { echo "Can't open file $name.\n"; exit(); }
$gfxsize=filesize($name);
$mode1=@fread($fi,$gfxsize);
fclose($fi);

$name = getcwd() . "\\S" . $number . ".fnt";
$fi=fopen($name,"wb");
if (!$fi) { echo "Can't open file $name.\n"; exit(); }

for ($i = 0; $i < $gfxsize; $i+=14)
{
	for ($j = 0; $j < 14; $j++)
	{	
	$b00 = ord($mode1[$i+$j]) & bindec('11110000');
	//$b01 = (ord($mode1[$i]) & bindec('00001111')) << 4;
	$b10 = (ord($mode1[$i+14+$j]) & bindec('11110000')) >> 4;
	//$b11 = ord($mode1[$i+1]) & bindec('00001111');
	
	fwrite($fi, pack("C*",$b00 | $b01 | $b10 | $b11));
	}
}

fclose($fi);
}

?>
