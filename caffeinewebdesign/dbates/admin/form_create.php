<?php
    include("ensure_admin.inc");
?>
<?php
if(isset($_POST["title"]))
{
   require_once("../classes/Uploader.inc");
   require_once("../classes/Form.inc");
   require_once("../classes/DB_Mgr.inc");
   $dbmgr = new DB_Mgr("dbates");
   
   $uploader = new Uploader();
   $form = $uploader->uploadForm($_FILES["the_file"]);
   if(is_object($form))
   {
      $form->title = $_POST["title"];
      $form->description = nl2br($_POST["description"]);
      if(!($form->dbInsert($dbmgr)))
      {
         echo("<h1 class=\"error\">ERROR - CANNOT INSERT</h1>" . $form->dbInsert($dbmgr));
         exit();
      }
      header("Location: form_menu.php");
   }
   else
   {
      echo("ERROR : $form");
      exit();
   }
   header("Location: form_menu.php");
}
else
{
   //DISPLAY NEWS FORM
   $title = "Enter your form.";
   include("html_header.inc");
   ?>
   </head>
   <body>
      <form ENCTYPE="multipart/form-data" name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>"onsubmit="return validateFormForm(this)";>
         <table class="mod_screen">
            <tr>
               <th colspan="2" class="menu">Create a Form</th>
            </tr>
            <tr>
               <td>Title</td>
               <td>
                  <input class="newsEdit" type="text" name="title"></input>
               </td>
            </tr>
            <tr>
               <td>Description</td>
               <td>
                  <textarea class="newsEdit" style="height: 100px;" name="description"></textarea>
               </td>
            </tr>
            <tr>
               <td>File</td>
               <td>
                  <INPUT class="file" NAME="the_file" TYPE="file" SIZE="35">
               </td>
            </tr>
            <tr>
               <td colspan="2" align="center">
                  <input type="Submit" class="submitButton" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                  <input type="Button" class="submitButton" name="Cancel" value="Cancel" onClick="location.href='form_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               </td>
            </tr>
         </table>
      </form>
   </body>
   </html>
<?php
}
?>