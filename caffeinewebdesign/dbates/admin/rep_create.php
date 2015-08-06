<?php
    include("ensure_admin.inc");
?>
<?php
if(isset($_POST["last_name"]))
{
   // Process Rep Creation
	require_once("../inc_files/php_fxns.inc");
	//echo(view_array($_POST));
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Rep.inc");
   $dbmgr = new DB_Mgr("dbates");
   $rep = new Rep();
   $rep->first_name = $_POST["first_name"];
   $rep->last_name = trim($_POST["last_name"]);
   $rep->active = $_POST["active"];
   $rep->role_1 = $_POST["role_1"];
   $rep->role_2 = $_POST["role_2"];
   $rep->role_3 = $_POST["role_3"];
   $rep->setDeptViaId($dbmgr, $_POST["dept"]);
   $rep->phone = $_POST["phone"];
   $rep->fax = $_POST["fax"];
   $rep->email = $_POST["email"];
	//$rep->specialties = Array();
	foreach($_POST as $id=>$val)
	{
		$x = strncmp($id, "specialty_", 10);
		if($x == 0)
		{
			$rep->addSpecialty($val);
			//echo("adding $val<br>");
		}
	}
	//$rep->logValues();
   if(!($rep->dbInsert($dbmgr)))
   {
      die("<h1 class=\"error\">CANNOT INSERT</h1>");
   }
	/*
	 * Process VCard Upload
	 */
	if(!empty($_FILES["vcard"]))
	{
		// ONLY ALLOW .vcf FILES TO BE UPLOADED
		$filename = strtolower($_FILES['vcard']['name']);
		$extension = substr($filename, (strlen($filename) - 3));
		if(strcmp($extension, "vcf") == 0)
		{
			//$target_path = $_SERVER["DOCUMENT_ROOT"] . "/vcards/" . $rep->id . ".vcf"; 
			if(!(move_uploaded_file($_FILES['vcard']['tmp_name'], $rep->getVcardPath()))) 
			{
				die("<h1 class=\"error\">Error uploading vCard. Please Edit this employee to add a vCard.</h1>");
			}
		}
		else
		{
			die("<h1 class=\"error\">You can only upload *.vcf for vCards. Please Edit this employee to add a vCard.</H1>");
		}
	}
	/*
	 * END Process VCard Upload
	 */
   header("Location: rep_menu.php");
}
else
{
   // Display form to create a rep
   $title = "Create a new Associate";
   include("html_header.inc");
   ?>
   <body>
   <?php
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Rep.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $admin = new Admin();
   ?>
      <form name="form" enctype="multipart/form-data" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateEmpForm(this);">
      <table class="mod_screen">
         <tr>
            <th class="menu" colspan="2">Input Associate Profile</td>
         </tr>
         <tr>
            <td>NAME:</td>
            <td>
               <input type="text" name="first_name"></input>
               <input type="text" name="last_name"></input>
            </td>
         </tr>
         <tr>
            <td>STATUS:</td>
            <td>
               <input class="radio" type="radio" name="active" value="1">&nbsp; Active
               <input class="radio" type="radio" name="active" value="0">&nbsp; Inactive
            </td>
         </tr>
         <tr>
            <td>Title 1</td>
            <td><input type="text" name="role_1"></input></td>
         </tr>
         <tr>
            <td>Title 2</td>
            <td><input type="text" name="role_2"></input></td>
         </tr>
         <tr>
            <td>Title 3</td>
            <td><input type="text" name="role_3"></input></td>
         </tr>
         <tr>
            <td>Dept</td>
            <td>
               <?
               $deptArray = $admin->dbLoadDepts($dbmgr);
               for($i = 0; $i < sizeof($deptArray); $i++)
               {
                  if($deptArray[$i]->active)
                  {
                     ?><input class="radio" type="radio" name="dept" value="<?php echo($deptArray[$i]->id);?>">&nbsp;<?echo($deptArray[$i]->name);?><br><?
                  }
               }
               ?>
            </td>
         </tr>
         <tr>
            <?php
               $specialArray = $admin->dbLoadSpecialties($dbmgr);
            ?>
            <td>Specialty</td>
            <td>
               <?
               for($i = 0; $i < sizeof($specialArray); $i++)
               {
                  if($specialArray[$i]->active)
                  {
                     ?><input class="radio" type="checkbox" name="specialty_<?php echo($specialArray[$i]->id); ?>" value="<?php echo($specialArray[$i]->id);?>">&nbsp;<?php echo($specialArray[$i]->name);?><br><?
                  }
               }
               ?>
            </td>
         </tr>
         <tr>
            <td>Phone #</td>
            <td><input type="text" name="phone"></td>
         </tr>
         <tr>
            <td>Fax #</td>
            <td><input type="text" name="fax"></td>
         </tr>
         <tr>
            <td>Email</td>
            <td><input type="text" name="email"></td>
         </tr>
			<tr>
				<td>vCard</td>
				<td>
					<input type="file" name="vcard">
				</td>
			</tr>
         <tr>
            <td colspan="2" align="center">
               <input type="Submit" class="submitButton" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               <input type="Button" class="submitButton" name="Cancel" value="Cancel" onClick="location.href='rep_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
            </td>
         </tr>
      </table>
      </form>
   </body>
   </html>
<?php
}
?>