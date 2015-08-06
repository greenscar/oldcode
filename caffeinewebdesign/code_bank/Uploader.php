<?php
/*
* 	TO UPLOAD A FILE, THE FORM MUST BE AS THE FOLLOWING
	
   form.html:
   <html><body>
   <form ENCTYPE="multipart/form-data"  action="file_upload_process.php" method="POST">
	<P>Upload a file
	<br><INPUT NAME="the_file" TYPE="file" SIZE="35"><br>
	<input type="submit" Value="Upload">
	</form>
   </body></html>
   
   file_upload_process.php:
   <?
		include("classes/Uploader.php");
		$uploader = new Uploader();
		$uploader->upload($_FILES["the_file"]);
   ?>
*/
class Uploader
{
   var $the_path;
   var $max_file_size;
   var $max_image_width;
   var $max_image_height;
   var $registered_types;
   var $allowed_types;
   
   function Uploader()
   {
      $this->max_file_size = "102400"; # in bytes
      $this->max_image_width = "500";
      $this->max_image_height = "500";
      $this->the_path = "C:\web_server\wwwroot\dbates\uploads";
      $this->registered_types = Array(
					"application/x-gzip-compressed" 	=> ".tar.gz, .tgz",
					"application/x-zip-compressed" 		=> ".zip",
					"application/x-tar"					=> ".tar",
					"text/plain"						=> ".html, .php, .txt, .inc (etc)",
					"image/bmp" 						=> ".bmp, .ico",
					"image/gif" 						=> ".gif",
					"image/pjpeg"						=> ".jpg, .jpeg",
					"image/jpeg"						=> ".jpg, .jpeg",
					"application/x-shockwave-flash" 	=> ".swf",
					"application/msword"				=> ".doc",
					"application/vnd.ms-excel"			=> ".xls",
					"application/octet-stream"			=> ".exe, .fla (etc)",
					"application/pdf"					=> ".pdf"
					); # these are only a few examples, you can find many more!
      $allowed_types = Array(	"image/bmp",
										"image/gif",
										"image/pjpeg",
										"image/jpeg",
										"application/msword",
										"application/vnd.ms-excel",
										"application/pdf"
									  );
   }
      
   function list_files()
   {
      $handle = dir($this->the_path);
      $list = "\n<b>Uploaded files:</b><br>";
      while ($file = $handle->read())
      {
         if (($file != ".") && ($file != ".."))
         {
            $list += "\n" . $file . "<br>";
         }
      }
      $list += "<hr>";
      return $list;
   }
   /*
	 * $the_file is an Array
	 * (
    * [name] => How to install and Configure MySQL.pdf
    * [type] => application/pdf
    * [tmp_name] => C:\web_server\php\uploadtemp\php79.tmp
    * [error] => 0
    * [size] => 22695
	 * )
	 */
   function upload($the_file)
   {
      $error = $this->validate_upload($the_file);
		if ($error) return($error);
		else
      {
         /*
          * Name the file after the current timestamp, therefore we KNOW there will not be 2 files
          *       named the same.
          * This can be modified to be a database key as a unique filename.
          */
			$name = $the_file["name"];
			$extLoc = strrpos($name, ".") + 1;
			$ext = substr($name, $extLoc, ($extLoc + 3));
         $file_name = time() . "." . $ext;
			$dest = $this->the_path . "/" . $file_name;
         if (!copy($the_file["tmp_name"], $dest))
         {
            //return("\n<b>Something barfed, check the path to and the permissions for the upload directory</b>");
            return(false);
         }
         else
				return($file_name);
      }
   } 
   
   /*
	 * $the_file is an Array
	 * (
    * [name] => How to install and Configure MySQL.pdf
    * [type] => application/pdf
    * [tmp_name] => C:\web_server\php\uploadtemp\php79.tmp
    * [error] => 0
    * [size] => 22695
	 * )
	 */
   function validate_upload($the_file)
   {
		$start_error = "\n<b>Error:</b>\n<ul>";
		$error = false;
		if (empty($the_file["name"]))
		{
         return ("\n<li>You did not specify a file to upload!</li>");
		}
      else
      {
         # check if we are allowed to upload this file_type
			if (!in_array($the_file["type"], $this->allowed_types))
         {
				
            $error .= "\n<li>The file that you uploaded was of a type that is not allowed, you are only allowed to upload files of the type:\n<ul>";
            while ($type = current($this->allowed_types))
            {
               $error .= "\n<li>" . $this->registered_types[$type] . " (" . $type . ")</li>";
               next($this->allowed_types);
            }
            $error .= "\n</ul>";
         }
         if (ereg("image",$the_file["type"]) && (in_array($the_file["type"],$this->allowed_types)))
         {
            $size = GetImageSize($the_file);
            list($foo,$width,$bar,$height) = explode("\"",$size[3]);
            if ($width > $this->max_image_width) {
               $error .= "\n<li>Your image should be no wider than " . $this->max_image_width . " Pixels</li>";
            }
            if ($height > $this->max_image_height) {
               $error .= "\n<li>Your image should be no higher than " . $this->max_image_height . " Pixels</li>";
            }
         }
         if ($error)
         {
            $error = $start_error . $error . "\n</ul>";
            return $error;
         }
         else {
            return false;
         }
      }
   } # END validate_upload
}
?>