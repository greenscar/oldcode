<?php
    include("ensure_root.inc");
?>
<?php
if(isset($_POST["title"]))
{
   // PROCESS THE FORM
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Department.inc");
   $dbmgr = new DB_Mgr("dbates");
   $dept = new Department();
   
   
   $dept->name = $_POST["title"];
   $dept->insurance = $_POST["insurance"];
   $dept->active = $_POST["active"];
   if(!($dept->dbInsert($dbmgr)))
   {
      die("<h1 class=\"error\">CANNOT CREATE dept</h1>");
   }
   header("Location: dept_menu.php");
}
else
{
   // DISPLAY THE FORM.
   $title = "Enter your Department Information";
	include("html_header.inc");
?>
<body>
	<form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateDeptForm(this)";>
		<table class="mod_screen">
			<tr>
				<th colspan="2" class="menu">Create Department</th>
			</tr>
			<tr>
				<td>Department Name</td>
				<td><input class="linkEdit" type="text" name="title"></input></td>
			</tr>
			<tr>
				<td>Is this a type of insurance?</td>
				<td>
               <input class="radio" type="radio" name="insurance" value="1">&nbsp; Yes
               <input class="radio" type="radio" name="insurance" value="0">&nbsp; No
				</td>
			</tr>
			<tr>
				<td>Active:</td>
				<td>
               <input class="radio" type="radio" name="active" value="1">&nbsp; Active
               <input class="radio" type="radio" name="active" value="0">&nbsp; Inactive
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="Submit" class="submitButton" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
					<input type="Button" class="submitButton" name="Cancle" value="Cancel" onClick="location.href='dept_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
				</td>
			</tr>
		</table>
   </form>
</body>
</html>
<?php
}
?>