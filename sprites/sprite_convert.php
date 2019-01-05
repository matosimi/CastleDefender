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
convert("$.Explode",0,"E1",true);
convert("$.Explode",224,"E2",true);
convert("$.Explode",224*2,"E3",true);
convert("$.Explode",224*3,"E4",true);

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

for ($j = 0; $j < 14; $j++)
{	
	$hi = ord($mode1[$seek+$j+0*14]) & bindec('11110000');
	$lo = (ord($mode1[$seek+$j+1*14]) & bindec('11110000')) >> 4;
	if ($usecolor)
	{
	  $hi2 = (ord($mode1[$seek+$j+0*14]) & bindec('00001111')) << 4;
		$lo2 = ord($mode1[$seek+$j+1*14]) & bindec('00001111');
	}
	$origin1[$j] = $hi | $lo | $hi2 | $lo2;
	fwrite($fi, pack("C*",$origin1[$j]));
}

for ($j = 0; $j < 14; $j++)
{	
	$hi = ord($mode1[$seek+$j+2*14]) & bindec('11110000');
	$lo = (ord($mode1[$seek+$j+3*14]) & bindec('11110000')) >> 4;
  if ($usecolor)
	{
	  $hi2 = (ord($mode1[$seek+$j+2*14]) & bindec('00001111')) << 4;
		$lo2 = ord($mode1[$seek+$j+3*14]) & bindec('00001111');
	}
	$origin2[$j] = $hi | $lo | $hi2 | $lo2;
	fwrite($fi, pack("C*",$origin2[$j]));
	$remainder[$j] = $origin2[$j] << 1;
}


for ($i = 0; $i < 7; $i++)
{
	for ($j = 0; $j < 14; $j++)
	{
		$sh1[$j] = $origin1[$j] >> 1;
		$sh2[$j] = $origin2[$j] >> 1 | $origin1[$j] << 7;
	}
	for ($j = 0; $j < 14; $j++)
		fwrite($fi, pack("C*", $sh1[$j]));
	for ($j = 0; $j < 14; $j++)
		fwrite($fi, pack("C*", $sh2[$j]));
	
	$origin1 = $sh1;
	$origin2 = $sh2;
}

for ($j = 0; $j < 14; $j++)
	fwrite($fi, pack("C*", $remainder[$j]));

for ($j = 0; $j < 14; $j++)
{
	
	fwrite($fi, pack("C*", $remainder[$j] << 1));
}
/*
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
*/

fclose($fi);
}

?>
