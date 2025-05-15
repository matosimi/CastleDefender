
#deflate g2f scr,font,pmg 

$basename = "cd_title";
#exec(getcwd() . "\\..\\tools\\zopfli --deflate --i350 -v $basename.pmg");
.\..\..\tools\\zopfli --deflate --i350 -v $basename".fnt"
.\..\..\tools\\zopfli --deflate --i350 -v $basename".scr"

