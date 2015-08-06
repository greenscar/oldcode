<?php
if(isset($_POST["cid"]))
{
   // PROCESS CLIENT CREATE.
   require_once("../classes/DB_Mgr.inc");
   require_once("../classes/Custom_Page.inc");
   require_once("../classes/Uploader.inc");
   require_once("../classes/File.inc");
   $dbmgr = new DB_Mgr("dbates");
   /*
    * 1) Create Client Custom Page in DB
    * 2) Upload Client Logo
    * 3) Forward User to custom_page_modify.php
    */
   
   // CREATE THE CUSTOM PAGE WITH THE CORRECT CLIENT
   $cp = new Custom_Page();
   $cp->setClient($dbmgr, $_POST["cid"]);
   
   $uploader = new Uploader();
   $file = $uploader->upload($_FILES["logo"]);
   if(is_object($file))
   {
      $cp->logo = $file->file_name;
   }
   $cp->dbInsertMain($dbmgr);
   header("Location: cp_edit.php?cid=" . $_POST["cid"]);
}
else
{
   // DISPLAY FORM FOR CREATING CLIENT
   require_once("../classes/DB_Mgr.inc");
   require_once("../classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $admin = new Admin();
   $title = "Select your client";
   include("html_header.inc");
   $clientList = $admin->dbLoadClientListActiveWithoutPages($dbmgr);
   if($clientList == null)
   {
      echo("<h2>Every client in the system has a page. Please goto <a href=\"cp_menu.php\">EDIT</a></h2>");
   }
   else
   {
      ?>
      <body>
      <form ENCTYPE="multipart/form-data" name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateCpCreate(this)";>
         <table class="mod_screen">
            <tr>
               <th colspan="2" class="menu">Create a Custom Client Page</th>
            </tr>
            <tr>
               <td>Client</td>
               <td>
                  <?php
                     echo("\t\t<select class=\"associate\" name=\"cid\">\n");
                     echo("\t\t\t<option value=\"0\">NONE</option>\n");
                     foreach($clientList AS $id=>$cl)
                     //for($i=0; $i<sizeof($clientList); $i++)
                     {
                        //$cl = $clientList[$i];
                        echo("\t\t\t<option value=\"" . $cl->id . "\">" . $cl->name . "</option>\n");
                     }
                     echo("\t\t</select>\n");
                  ?>
               </td>
            </tr>
            <tr>
               <td>Logo</td>
               <td>
                  <INPUT class="file" NAME="logo" TYPE="file" SIZE="35">
               </td>
            </tr>
            <tr>
               <td colspan="2" align="center">
                  <input class="submitButton" type="submit" name="submit" value="NEXT" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                  <input class="submitButton" type="button" name="MAIN MENU" value="MAIN MENU" onclick="location.href='index.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               </td>
            </tr>
         </table>
      </form>
<?php
   }
}
?>