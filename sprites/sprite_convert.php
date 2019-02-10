<?php
//castle defender sprite converter
//converts bbc micro videodata mode 1 to mode 4 same as atari mode $0f (gr.8)
//it just converts 1st sprite position from original sprite file and saves it to new file
//sprite pre-shifting has been moved to 6502 code

convert("1");
convert("2");
convert("3");
convert("4",0,null,true);
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
fwrite($fi, pack("C*",0,0));

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
}
fwrite($fi, pack("C*",0,0));
echo $name,"\n";	
fclose($fi);
}

?>
