<?php
//converts bbc micro videodata mode 1 to atari mode $0f (gr.8)

$name = getcwd() . "\..\srcdata\\loseb";
$fi=fopen($name,"rb");
if (!$fi) { echo "Can't open file $name.\n"; exit(); }
$gfxsize=filesize($name);
$mode1=@fread($fi,$gfxsize);
fclose($fi);

$name = getcwd() . "\\loseb.fnt";
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

?>
