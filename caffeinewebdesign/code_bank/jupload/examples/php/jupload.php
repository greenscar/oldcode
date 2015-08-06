<?php
/*
 * JUpload php example
 * saves all uploaded files to the temp/ directory
 * see http://jupload.biz/
 * info@jupload.biz
 * 
 * Author: $Author: mhaller $
 * Date: $Date: 2003/10/04 15:39:48 $
 * Version: $Revision: 1.6 $
 * Id: $Id: JUpload.php,v 1.6 2003/10/04 15:39:48 mhaller Exp $
 */

/*
 * Iterate over all received files.
 * PHP > 4.2 / 4.3 ? will save the file information into the
 * array $_FILES[]. Before these versions, the data was saved into
 * $HTTP_POST_FILES[]
 */
foreach($_FILES as $tagname=>$objekt)
{
 // get the temporary name (e.g. /tmp/php34634.tmp)
 $tempName = $objekt['tmp_name'];
 
 // get the real filename
 $realName = $objekt['name'];
 
 // where to save the file?
 $target = './temp/' . $realName;
 
 // print something to the user
 echo "<br>Processing file $realName...\n";
 flush();
 
 // move the file to the target directory
 move_uploaded_file($tempName,$target);

	/* This is a sample from Wilson
	 * which will generate thumbnails from
	 * the uploaded files. Use it, if you like.
	 */
	/*
	 $src_img = imagecreatefromjpeg($target);
	 $origw=imagesx($src_img); 
	 $origh=imagesy($src_img); 
	 $new_w = '150';
	 $ratio=$origh*$new_w; 
	 $new_h=$ratio/$origw; 
	 $dst_img = imagecreatetruecolor($new_w,$new_h); 
	 imagecopyresized($dst_img,$src_img,0,0,0,0,$new_w,$new_h,imagesx
	($src_img),imagesy($src_img)); 
	 imagejpeg($dst_img, $thumb_target); 
	*/

 // end of iteration
 echo "next file...\n";
 flush();
}


/*
 * This is optional.
 * send error response to jupload
 * format depends on API version of PHP
 */
 /*
switch(php_sapi_name())
{
 case 'cgi':
 case 'cgi-fcgi':
  $sz_htstatus = 'Status: ';
  break;
 default:
  $sz_htstatus = 'HTTP/1.0: ';
  break;
}
*/

/*
 * Let's generate an error message for JUpload
 */
 
// everything is okay - default message
//$sz_message='200 JUpload works great';

// if we got no files, show error message to user
//if (count($_FILES) == 0) 
// $sz_message='406 No files uploaded';

// now, send the header to JUpload applet
//header($sz_htstatus.$sz_message);

// print debug code
//echo "<br><pre>_FILES:\n";
//print_r($_FILES);
//echo "</pre>\n";

flush();

?>