<?php
    include("ensure_root.inc");
?>
<?php
if(isset($_POST["title"]))
{
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Specialty.inc");
   //require_once("../php/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $spec = new Specialty();
   $spec->name = $_POST["title"];
   $spec->active = $_POST["active"];
   //echo($spec->dbInsert($dbmgr));
   if(!($spec->dbInsert($dbmgr)))
   {
      die("<h1 class=\"error\">CANNOT CREATE SPECIALTY DB ERROR</h1>");
   }
   header("Location: specialty_menu.php");
}
else
{
   $title = "Enter the information for your specialty.";
	include("html_header.inc");
?>
<body>
	<form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateSpecialtyForm(this)";>
		<table class="mod_screen">
			<tr>
				<th colspan="2" class="menu">Create Specialty</th>
			</tr>
			<tr>
				<td>Title</td>
				<td>
					<input type="text" name="title"></input>
				</td>
			</tr>
			<tr>
				<td>STATUS:</td>
				<td>
               <input type="radio" name="active" class="radio" value="1">&nbsp; Active
               <input type="radio" name="active" class="radio" value="0">&nbsp; InActive
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="Submit" class="submitButton" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
					<input type="Button" class="submitButton" name="Cancle" value="Cancel" onClick="location.href='specialty_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
				</td>
			</tr>
		</table>
   </form>
</body>
</html>
<?php
}
?>