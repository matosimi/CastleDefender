<?php
//level generator
//strips binary level data to Lxdata.bin and
//converts bbc micro videodata mode 1 to atari mode $0f (gr.8)

convert("1");
convert("2");
convert("3");
convert("4");



function convert($number)
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
		//$b01 = (ord($mode1[$i]) & bindec('00001111')) << 4;
		$b10 = (ord($data[$levelheader + $i + 8 + $j]) & bindec('11110000')) >> 4;
		//$b11 = ord($mode1[$i+1]) & bindec('00001111');
		
		fwrite($fi, pack("C*",$b00 | $b01 | $b10 | $b11));
		}
	}
	
	fclose($fi);
	echo "$name\n";
}

?>
