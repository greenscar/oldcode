<?php
set_time_limit(0);

$filename="./images/wedding/wedding1.jpg";
$filename2="./images/home.jpg";

$sourceid=imagecreatefromjpeg($filename);
$watermarkid=imagecreatefromjpeg($filename2);

$white=imagecolorallocate($watermarkid, 255,0,255);
ImageColorTransparent($watermarkid,$white);

$meret=getimagesize($filename);
$width=$meret[0];
$height=$meret[1];
$meret2=getimagesize($filename2);
$watermark_width=$meret2[0];
$watermark_height=$meret2[1];

imagecopymerge($sourceid, $watermarkid, $width-$watermark_width, $height-$watermark_width, 0, 0, $watermark_width, $watermark_height, 100);
//imagepng($sourceid,"uj" . $filename);
imagedestroy($sourceid);
imagedestroy($watermarkid);
echo '<img src="' . $filename . '">';
?>
