<?php
//level generator
//strips binary level data to Lxdata.bin and
//converts bbc micro videodata mode 1 to atari mode $0f (gr.8)

convert("1",0,1,0,1,0);
convert("2",0,1,0,1,0);
convert("3",0,1,0,1,0);
convert("4",0,1,1,1,256); //convert for g2f editor (add 256 bytes)
shorten("l4\\L4_final_edit","41",256+1024); //shorten after g2f edit by (256+1024 bytes)


function shorten($src,$target,$cutBytes)
{
	$name = getcwd() . "\\" . $src . ".fnt";
	$fi=fopen($name,"rb");
	if (!$fi) { echo "Can't open file $name.\n"; exit(); }
	$gfxsize=filesize($name);
	$data=@fread($fi,$gfxsize-$cutBytes);
	fclose($fi);

	$name = getcwd() . "\\L" . $target . ".fnt";
	$fi=fopen($name,"wb");
	if (!$fi) { echo "Can't open file $name.\n"; exit(); }
	
	for ($i = 0; $i < $gfxsize-$cutBytes; $i++)
		fwrite($fi, $data[$i]);
	fclose($fi);
	echo "$name\n";		
}

function convert($number,$c0,$c1,$c2,$c3,$emptyBytes)
{
	$levelheader = 1824;	//size of the header in bytes
	
	$name = getcwd() . "\..\srcdata\\L." . $number;
	$fi=fopen($name,"rb");
	if (!$fi) { echo "Can't open file $name.\n"; exit(); }
	$gfxsize=filesize($name);
	$data=@fread($fi,$gfxsize);
	fclose($fi);
	
	//header => bin file
	$name = getcwd() . "\\L" . $number . "data.bin";
	$fi=fopen($name,"wb");
	if (!$fi) { echo "Can't open file $name.\n"; exit(); }
	
	for ($i = 0; $i < $levelheader; $i++)
		fwrite($fi, $data[$i]);
	
	fclose($fi);
	echo "$name\n";
	//gfx => fnt file	
	$name = getcwd() . "\\L" . $number . ".fnt";
	$fi=fopen($name,"wb");
	if (!$fi) { echo "Can't open file $name.\n"; exit(); }
	
	
	for ($i = 0; $i < $gfxsize - $levelheader; $i+=16)
	{
		for ($j = 0; $j < 8; $j++)
		{	
		$b00 = ord($data[$levelheader + $i + $j]) & bindec('11110000');
		$b10 = (ord($data[$levelheader + $i + 8 + $j]) & bindec('11110000')) >> 4;
		$b01 = (ord($data[$levelheader + $i + $j]) & bindec('00001111')) << 4;
		$b11 = ord($data[$levelheader + $i + 8 + $j]) & bindec('00001111');
		
		$myByte = mapcolors($b00 | $b10, $b01 | $b11, $c0, $c1, $c2, $c3);
		fwrite($fi, pack("C*",$myByte));
	  }
	}
	
	for ($i = 0; $i < $emptyBytes; $i++)
		fwrite($fi, pack("C*",0));
	
	fclose($fi);
	echo "$name\n";
}

//map color combinations of $b1, $b2 according to settings of $c0..$c3
function mapcolors($b1, $b2, $c0, $c1, $c2, $c3)
{
	$outByte = 0;
	for ($i = 7; $i >= 0; $i--)
	{
		$bit1 = ($b1 >> $i) & bindec('00000001');
		$bit2 = ($b2 >> $i) & bindec('00000001');
		$outbit = 0;
		if ($bit1 == 0)
		{
			if ($bit2 == 0)
			{
				if ($c0 == 1) $outbit = 1;
			}
			else
			{
				if ($c2 == 1) $outbit = 1;
			}
		}
		else
		{
			if ($bit2 == 0)
			{
				if ($c1 == 1) $outbit = 1;
			}
			else
			{
				if ($c3 == 1) $outbit = 1;
			}
		}
		$outByte <<= 1;
		$outByte += $outbit;
	}
	return $outByte;
}

?>
