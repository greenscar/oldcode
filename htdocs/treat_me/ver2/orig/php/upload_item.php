<?
include("header.inc");
$image = $_FILES["image"]["name"];
//echo("ID = " . $_POST["ID"]);
//exec("mv $image '$WebRoot/images/".$_POST["ID"].".jpg'");
//Header("Location: ./index.php");
	require("../sql_connect.inc");
	require("./file_upload_CLASS.php");

#--------------------------------#
# Variables
#--------------------------------#

// The path to the directory where you want the 
// uploaded files to be saved. This MUST end with a 
// trailing slash unless you use $path = ""; to 
// upload to the current directory. Whatever directory
// you choose, please chmod 777 that directory.

	$path = "../images/";

// The name of the file field in your form.

	$upload_file_name = "image";

// ACCEPT mode - if you only want to accept
// a certain type of file.
// possible file types that PHP recognizes includes:
//
// OPTIONS INCLUDE:
//  text/plain
//  image/gif
//  image/jpeg
//  image/png
	
	// Accept ONLY gifs's
	#$acceptable_file_types = "image/gifs";
	
	// Accept GIF and JPEG files
	$acceptable_file_types = "image/gif|image/jpeg|image/pjpeg";

	// Accept ALL files
	#$acceptable_file_types = "";

// If no extension is supplied, and the browser or PHP
// can not figure out what type of file it is, you can
// add a default extension - like ".jpg" or ".txt"

	$default_extension = "";

// MODE: if your are attempting to upload
// a file with the same name as another file in the
// $path directory
//
// OPTIONS:
//   1 = overwrite mode
//   2 = create new with incremental extention
//   3 = do nothing if exists, highest protection

	$mode = 1;


#--------------------------------#
# PHP
#--------------------------------#
	// Create a new instance of the class
	$my_uploader = new uploader;
	
	// OPTIONAL: set the max filesize of uploadable files in bytes
	$my_uploader->max_filesize(30000);
	
	// OPTIONAL: if you're uploading images, you can set the max pixel dimensions 
	$my_uploader->max_image_size(800, 800); // max_image_size($width, $height)
		
	// UPLOAD the file
	$new_file_name = $_POST["ID"]. ".jpg";
	if ($my_uploader->upload($upload_file_name, $acceptable_file_types, $default_extension)) {
		$success = $my_uploader->save_file($path, $mode, $new_file_name);
	}
	
	if (!$success) {
		// ERROR uploading...
		if($my_uploader->errors) {
			while(list($key, $var) = each($my_uploader->errors)) {
				echo $var . "<br>";
			}
		}
	} 		

Header("Location: ./index.php");
?>
