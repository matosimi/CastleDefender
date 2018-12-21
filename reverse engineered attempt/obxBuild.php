<?php

//builds obx file by adding separate acorn data blocks (exported from .ssd) together

  $outfname="cd.obx";

  $targetfi = @fopen($outfname, "wb");
  if (!$targetfi) { echo "Can't open file $targetfi.\n"; exit(); }
  
  echo "Working directory: ",  getcwd(), "\n";
//  addBlock("\srcdata\L.1",$targetfi);  
  addBlock("\srcdata\\$.LowCode",$targetfi);
  addBlock("\srcdata\\$.LowCodM",$targetfi);
  addBlock("\srcdata\\$.CDCode",$targetfi);
  addBlock("\srcdata\\$.Explode",$targetfi);
  addBlock("\srcdata\\$.ScoreB",$targetfi);
  
  //addBlock("srcdata\$.CDCodeM");
  fclose($targetfi);
  
  function addBlock($fname,$targetfi)
  { // BEGIN function addBlock
    //load header (info) file
    $name = getcwd() . $fname . ".INF";
    echo "poop:",$name,"\n";
    $fi=fopen($name,"rb");
    if (!$fi) { echo "Can't open file $name.\n"; exit(); }
    $headsize=filesize($name);
    $head=@fread($fi,$headsize);
    fclose($fi);
    echo $head;
    
    //load data file
    $fname = getcwd() . $fname;
    $fi=@fopen($fname,"rb");
    if (!$fi) { echo "Can't open file2 $fname.\n"; exit(); }
    $fsize=filesize($fname);
    $bindata=@fread($fi,$fsize);
    fclose($fi);    
  	
    //extract header info
    $from = hexdec(substr($head, 12, 4));
    $size = hexdec(substr($head, 26, 4));
    $to = $from + $size - 1;
            
    //save header info
    
    //$data = pack("C*",$i);
    fwrite($targetfi,pack("C*",$from % 256));
    fwrite($targetfi,pack("C*",intdiv($from,256)));
    fwrite($targetfi,pack("C*",$to % 256));
    fwrite($targetfi,pack("C*",intdiv($to,256)));
    
    //save binary data content
    fwrite($targetfi,$bindata);
    
  } // END function addBlock
  
  
  
?>