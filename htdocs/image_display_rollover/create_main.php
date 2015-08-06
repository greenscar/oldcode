<?php

function create_main($pict, $size, $dest_dir="./images/big/")
{  
   $handle = imagecreatefromjpeg("images/" . $pict);
   //imagejpeg($handle);
   //exit();
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
   //$size_in_pixel = '50';
   $size_in_pixel = $size;
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
   if(!imagejpeg($black_picture,$dest_dir. $pict, $size_in_pixel))
   imagestring($black_picture, 1, $final_x-4, $final_y-8, ".", imagecolorallocate($black_picture,0,0,0));
   //The number is the quality of the result picture
   //imagejpeg($black_picture,'', '100');
   imagedestroy($handle);
   imagedestroy($black_picture);
}
?>