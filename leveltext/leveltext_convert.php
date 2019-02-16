<?php
//castle defender wavetext converter
//converts bbc micro videodata mode 1 to mode 4 same as atari mode $0f (gr.8)

convert("leveltext.bin",0,"leveltext",true);

function convert($number, $seek = 0, $targetfile = null, $usecolor = false)
{
if (strlen($number) == 1)
	$name = getcwd() . "\..\srcdata\\S." . $number;
	else
	$name = getcwd() . "\..\srcdata\\" . $number;

$fi=fopen($name,"rb");
if (!$fi) { echo "Can't open file $name.\n"; exit(); }
$gfxsize=filesize($name);
$mode1=@fread($fi,$gfxsize);
fclose($fi);

if ($targetfile == null)
	$name = getcwd() . "\\S" . $number . ".fnt";
	else
	$name = getcwd() . "\\" . $targetfile . ".fnt";
	
$fi=fopen($name,"wb");
if (!$fi) { echo "Can't open file $name.\n"; exit(); }

for ($i = 0; $i < $gfxsize; $i+=16)
{
	for ($j = 0; $j < 8; $j++)
	{	
	$b00 = ord($mode1[$i+$j]) & bindec('11110000');
	$b10 = (ord($mode1[$i+8+$j]) & bindec('11110000')) >> 4;
	
	if ($usecolor)
	{
		$b01 = (ord($mode1[$i+$j]) & bindec('00001111')) << 4;
		$b11 = ord($mode1[$i+8+$j]) & bindec('00001111');
	}
	
	fwrite($fi, pack("C*",$b00 | $b01 | $b10 | $b11));
	}
}

echo $name,"\n";	
fclose($fi);
}

?>
