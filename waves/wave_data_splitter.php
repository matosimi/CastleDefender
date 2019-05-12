<?php
//castle defender wave data splitter
//deletes header from wave object file and splits it into 20 pieces

$headersize = 6; //bytes
$levels = 4;
$waves = 5; 

$name = getcwd() . "\\wave_data.obx";

$fi=fopen($name,"rb");
if (!$fi) { echo "Can't open file $name.\n"; exit(); }
$xexsize=filesize($name);
$wavedata=@fread($fi,$xexsize);
fclose($fi);

$wavesize = ($xexsize - $headersize) / ($levels * $waves);
echo "wavesize:$wavesize\n";
if (is_float($wavesize))
    { echo "object file does not contain same wavesizes... possibly cause by a typo in wave_data.asm (source) file"; exit(); }

for ($i = 0; $i < $levels; $i++)
    for ($j = 0; $j < $waves; $j++)
    {
        $name = getcwd() . "\\L" . ($i+1) . "W" . ($j+1) . ".bin";
        $fi=fopen($name,"wb");
        if (!$fi) { echo "Can't open file $name.\n"; exit(); }
        for ($k = 0; $k < $wavesize; $k++)
        	{
					fwrite($fi, $wavedata[$headersize + $k + $j*$wavesize + $i*$waves*$wavesize]);
					//echo $headersize + $k + $j*$wavesize + $i*$waves*$wavesize," ";
					}
        echo "$name\n";
        fclose($fi);
    }

?>
