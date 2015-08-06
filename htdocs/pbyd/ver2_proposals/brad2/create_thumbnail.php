<?
/*
 * Use this file as an img src.
 * EX: <img src="create_thumbnail.php?pict=army.jpg">
 */
Header("Content-type: image/jpg");
$dir = $_GET["group"];
//$dir = "portrait";
if(file_exists("./images/$dir/mini_" . $_GET["pict"]))
   imagejpeg(imagecreatefromjpeg("./mini_" . $_GET["pict"]));
else
{
   $pict = "./images/" . $dir . "/" . $_GET["pict"];
   $dest = "./images/" . $dir;
   miniature($pict, $dest);
}
function miniature($pict, $dest_dir)
{  
   $handle = @imagecreatefromjpeg($pict);
   $x=imagesx($handle);
   $y=imagesy($handle);
   if($x > $y)
   { 
      $max = $x;                         
      $min = $y;                         
   }                                         
   if($x <= $y)
   {
      $max = $y;                         
      $min = $x;                         
   }                                       
   //$size_in_pixel : Size max of the label in pixel.  The size of the picture being
   //proportional to the original, this value define maximum size
   //of largest side with dimensions of the picture. Sorry for my english !
   //Here $size_in_pixel = 100 for a thumbnail.
   $size_in_pixel = '75';
   $rate = $max/$size_in_pixel;
   $final_x = $x/$rate;
   $final_y = $y/$rate;
   if($final_x > $x)
   {
      $final_x = $x;
      $final_y = $y;
   }
   $final_x = ceil($final_x);
   $final_y = ceil($final_y);
   $black_picture = imageCreatetruecolor($final_x,$final_y);
   imagefill($black_picture,0,0,imagecolorallocate($black_picture, 255, 255, 255));
   imagecopyresampled($black_picture, $handle, 0, 0, 0, 0,$final_x, $final_y, $x, $y);
   if(!@imagejpeg($black_picture,$dest_dir.'/mini_'.$pict, $size_in_pixel))
   imagestring($black_picture, 1, $final_x-4, $final_y-8, ".", imagecolorallocate($black_picture,0,0,0));
   //The number is the quality of the result picture
   imagejpeg($black_picture,'', '100');
   imagedestroy($handle);
   imagedestroy($black_picture);
}
?>