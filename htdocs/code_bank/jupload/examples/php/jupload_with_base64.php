<?php
/*
 * JUpload php example
 * demonstrates use of base64 encoded path information
 * see http://jupload.biz/
 * info@jupload.biz
 * 
 * Author: $Author: mhaller $
 * Date: $Date: 2003/10/04 15:39:48 $
 * Version: $Revision: 1.6 $
 * Id: $Id: JUpload.php,v 1.6 2003/10/04 15:39:48 mhaller Exp $
 */
 
foreach($_FILES as $tagname=>$objekt)
{
 $tempName = $objekt['tmp_name'];
 $realName = $objekt['name'];
 $target = '../uploaded/' . $realName;

 // look for special encoded jupload files
 $contentType = $objekt['type'];
 if (substr($contentType,0,7)=='jupload')
 {
  $base64_encoded_path = substr($contentType,8);
  $base64_decoded_path = base64_decode($base64_encoded_path);
  @$_FILES[$tagname]['absolute_directory'] = $base64_decoded_path;
 }

 // move them to the temp directory
 @$_FILES[$tagname]['return_code']=move_uploaded_file($tempName,$target);
}


// print debug code
echo "<strong>Files:</strong>\n<br>";
print_r($_FILES);

?>