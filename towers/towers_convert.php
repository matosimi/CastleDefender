<?php
//castle defender tower sprite converter
//converts bbc micro videodata mode 1 to mode 4 same as atari mode $0f (gr.8)

convert_and_shift("towers");
convert_and_shift("notower");

function convert_and_shift($srcfile)
{
	convert($srcfile);
	shift($srcfile);
}

function convert($srcfile)
{
$name = getcwd() . "\..\srcdata\\" . $srcfile . ".bin";
$fi=fopen($name,"rb");
if (!$fi) { echo "Can't open file $name.\n"; exit(); }
$gfxsize=filesize($name);
$mode1=@fread($fi,$gfxsize);
fclose($fi);

$name = getcwd() . "\\" . $srcfile . ".fnt";
$fi=fopen($name,"wb");
if (!$fi) { echo "Can't open file $name.\n"; exit(); }

for ($i = 0; $i < $gfxsize; $i+=16)
{
	for ($j = 0; $j < 8; $j++)
	{	
	$b00 = ord($mode1[$i+$j]) & bindec('11110000');
	//$b01 = (ord($mode1[$i]) & bindec('00001111')) << 4;
	$b10 = (ord($mode1[$i+8+$j]) & bindec('11110000')) >> 4;
	//$b11 = ord($mode1[$i+1]) & bindec('00001111');
	
	fwrite($fi, pack("C*",$b00 | $b01 | $b10 | $b11));
	}
}

fclose($fi);
}

function shift($srcfile)
{
$name = getcwd() . "\..\srcdata\\" . $srcfile . ".bin";
$fi=fopen($name,"rb");
if (!$fi) { echo "Can't open file $name.\n"; exit(); }
$gfxsize=filesize($name);
$mode1=@fread($fi,$gfxsize);
fclose($fi);

$name = getcwd() . "\\" . $srcfile . "_shifted.fnt";
$fi=fopen($name,"wb");
if (!$fi) { echo "Can't open file $name.\n"; exit(); }

$sw = 32; //sprite final width

for ($i = 0; $i < $gfxsize; $i+=48)
{
	for ($k = -8; $k <= $sw+8; $k+=16)
	{
		for ($j = 0; $j < 8; $j++)
		{	
			if ($k+$j < 8) 
				$b00 = 0;
			else
				$b00 = ord($mode1[$k+$i+$j]) & bindec('11110000');
		//$b01 = (ord($mode1[$i]) & bindec('00001111')) << 4;
		
		  if ($k+$j > $sw-1)
				$b10 = 0;
			else
				$b10 = (ord($mode1[$k+$i+$j+8]) & bindec('11110000')) >> 4;
		//$b11 = ord($mode1[$i+1]) & bindec('00001111');
		
		fwrite($fi, pack("C*",$b00 | $b01 | $b10 | $b11));
		}
	}
}
}


?>
