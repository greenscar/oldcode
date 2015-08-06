<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/File.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Batch_File.inc");
class Uploader
{
	var $log;
   var $the_path;
   var $max_file_size;
   var $max_image_width;
   var $max_image_height;
   var $registered_types;
   var $allowed_types;
	
   function Uploader()
   {
		$this->log = new Secretary();
		$meg = 1.5; // MAX file size in megs
		$kb = $meg * 1024;
		$bytes = $kb * 1024;
      $this->max_file_size = $bytes; # in bytes
      $this->max_image_width = "1200";
      $this->max_image_height = "1200";
      $this->the_path = $_SERVER["DOCUMENT_ROOT"] ."/upload_dir";
      $this->registered_types = Array(
					"application/x-gzip-compressed" 	=> ".tar.gz, .tgz",
					"application/x-zip-compressed" 		=> ".zip",
					"application/x-tar"					=> ".tar",
					"application/octet-stream"     => ".php",
					"text/html"							=> ".html, .htm", 
					"text/plain"						=> ".txt, .inc (etc)",
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
      $this->allowed_types = Array("image/pjpeg", "image/jpeg","application/pdf", "image/gif");
   }
      
   function list_files()
   {
		$this->log->write("Uploader->list_files()");
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
	// Upload the file and return a File Object to insert into the DB or whatever
   function upload($the_file)
   {
//.*write(.*$.*);
      $error = $this->validate_upload($the_file);
		if ($error)
		{
//.*write(.*$.*);
			return($error);
		}
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
			$ext = strtolower($ext);
			$file = new File();
			$file->post_date = time();
			$file->size = $the_file["size"];
			$file->file_name = $file->post_date . "." . $ext;
			$dest = $this->the_path . "/" . $file->file_name;
         if (!copy($the_file["tmp_name"], $dest))
         {
            $this->log->write("\n<b>Something barfed, check the path to and the permissions for the upload directory</b>");
            return(false);
         }
         else
			{
//.*write(.*$.*);
				return($file);
			}
      }
   }
	
	// Upload the form and return a Form Object to insert into the DB or whatever
   
	function uploadForm($the_file)
   {
//.*write(.*$.*);
		$this->allowed_types = Array("text/plain", "text/html", "application/octet-stream", "application/pdf");
      $error = $this->validate_upload($the_file);
		if ($error)
		{
//.*write(.*$.*);
			return($error);
		}
		else
      {
         
			$name = $the_file["name"];
			$extLoc = strrpos($name, ".") + 1;
			$ext = substr($name, $extLoc, ($extLoc + 3));
			$file = new Form();
			$file->post_date = time();
			$file->size = $the_file["size"];
			$file->file_name = $file->post_date . "." . $ext;
			$dest = $this->the_path . "/" . $file->file_name;
         if (!copy($the_file["tmp_name"], $dest))
         {
            $this->log->write("\n<b>Something barfed, check the path to and the permissions for the upload directory</b>");
            return(false);
         }
         else
			{
//.*write(.*$.*);
				return($file);
			}
      }
   } 
	
   function uploadBatch($dbmgr, $_FILES, $client_id)
	{
		/*
		 * Upload the batch of files to /batch_files/$client_id
		 * If $client_id dir doesn't exist, create it first.
		 *
		 */
//.*write(.*$.*);
		//$dest_dir = "batch_pages";
//.*write(.*$.*);
		$fileList[] = Array();
		$fileNum = 1;
//.*write(.*$.*);
		foreach($_FILES as $tagname=>$the_file)
		{
			$error = $this->validate_upload($the_file);
//.*write(.*$.*);
			if(!empty($error))
//.*write(.*$.*);
			if ($error)
			{
//.*write(.*$.*);
//.*write(.*$.*);
				return($error);
			}
			else
			{
				/*
				 * Name the file after the current timestamp, therefore we KNOW there will not be 2 files
				 *       named the same.
				 * This can be modified to be a database key as a unique filename.
				 */
				$name = $the_file["name"];
//.*write(.*$.*);
				$extLoc = strrpos($name, ".") + 1;
				$ext = substr($name, $extLoc, ($extLoc + 3));
//.*write(.*$.*);
				$b_file = new Batch_File();
				$fileNum = $fileNum + 1;
//.*write(.*$.*);
				$b_file->file_name =  $client_id . "_" . time() . $fileNum . "." . $ext;
//.*write(.*$.*);
				$dest = $this->the_path . "/batch_pages/" . $b_file->file_name;
//.*write(.*$.*);
				if (!copy($the_file["tmp_name"], $dest))
				{
					$this->log->write("ERROR UPLOADING");
//.*write(.*$.*);
					return(false);
				}
				else
				{
//.*write(.*$.*);
					// INSERT INTO DB
					$b_file->client_id = $client_id;
					if(!($b_file->dbInsert($dbmgr)))
					{
//.*write(.*$.*);
						return("<h1 class=\"error\">ERROR - CANNOT INSERT</h1>" . $b_file->dbInsert($dbmgr, $client_id));
						exit();
					}
					else array_push($fileList, $b_file);
					//return($file);
				}
			}
		}
//.*write(.*$.*);
		return($fileList);
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
				
            $error .= "\n<li>You attempted to upload a file type of: <b>" . $the_file["type"] . "</b>"
						 ."<br>You are only allowed to upload files of the type:\n<ul>";
            while ($type = current($this->allowed_types))
            {
               $error .= "\n<li>" . $this->registered_types[$type] . " (" . $type . ")</li>";
               next($this->allowed_types);
            }
            $error .= "\n</ul>";
         }
         if (ereg("image",$the_file["type"]) && (in_array($the_file["type"],$this->allowed_types)))
         {
            $size = GetImageSize($the_file["tmp_name"]);
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