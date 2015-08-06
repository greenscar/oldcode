<?
/*
 * JUpload php PUT handler example
 * see http://jupload.biz/
 * info@jupload.biz
 * 
 * Author: $Author: mhaller $
 * Date: $Date: 2003/10/04 15:39:48 $
 * Version: $Revision: 1.6 $
 * Id: $Id: JUpload.php,v 1.6 2003/10/04 15:39:48 mhaller Exp $
 */
 

$upload_path = '/www/jupload/temp/';

ignore_user_abort(true);

// if it does not work, try "php://stdin" instead

$putdata = fopen("php://input","r");
$i=0;

// if it does not work, try "$_ENV['PATH_TRANSLATED']" instead

$outfile = $_SERVER['PATH_TRANSLATED'];

/*
 * YOU MUST EDIT THIS FOR YOUR NEEDS ! MANDATORY !
 */
if (substr($outfile,0,strlen($upload_path)) != $upload_path)
 die('WRONG UPLOAD DIRECTORY:' . $outfile);


echo "opening $outfile ...\n";
if (!file_exists($outfile))
 $outpoint=fopen($outfile,'w');
else
 $outpoint=fopen($outfile,'r+');
 $cr = $_SERVER['HTTP_CONTENT_RANGE'];
 if (substr($cr,0,6)=='bytes ')
 {
  $pos1 = strpos($cr,'-');
  $pos2 = strpos($cr,'/');
  $offset = substr($cr,6,$pos1-6);
  $length = substr($cr,$pos1+1,$pos2-$pos1-1);
  $total = substr($cr,$pos2+1);
 }
 fseek($outpoint,$offset);
}
while ($data = fread($putdata,1024))
{
 $i+=strlen($data);
 fwrite($outpoint,$data,strlen($data));
}
fclose($putdata);
fclose($outpoint);
echo $i . " bytes received for " . $_SERVER['PATH_INFO'] . "\n";
?>
