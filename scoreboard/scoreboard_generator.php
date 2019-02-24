<?php
//score board generator
//converts bbc micro videodata mode 1 to atari mode $0f (gr.8)

convert("$.ScoreB", "scoreboard.fnt");


function convert($source,$target)
{
	$name = getcwd() . "\..\srcdata\\" . $source;
	$fi=fopen($name,"rb");
	if (!$fi) { echo "Can't open file $name.\n"; exit(); }
	$gfxsize=filesize($name);
	$data=@fread($fi,$gfxsize);
	fclose($fi);
	
	echo "$name\n";
	//gfx => fnt file	
	$name = getcwd() . "\\" . $target;
	$fi=fopen($name,"wb");
	if (!$fi) { echo "Can't open file $name.\n"; exit(); }
	
	
	for ($i = 0; $i < $gfxsize; $i+=16)
	{
		for ($j = 0; $j < 8; $j++)
		{	
		$b00 = ord($data[$i + $j]) & bindec('11110000');
		$b01 = (ord($data[$i + $j]) & bindec('00001111')) << 4;
		$b10 = (ord($data[$i + 8 + $j]) & bindec('11110000')) >> 4;
		$b11 = ord($data[$i + 8 + $j]) & bindec('00001111');
		
		fwrite($fi, pack("C*",$b00 | $b01 | $b10 | $b11));
		}
	}
	
	fclose($fi);
	echo "$name\n";
}

?>
