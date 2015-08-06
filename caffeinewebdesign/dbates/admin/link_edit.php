<?php
    include("ensure_admin.inc");
?>
<?php
if(isset($_POST["lid"]) || (isset($_GET["lid"]) && isset($_GET["do"])))
{
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Link.inc");
   //require_once("../php/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $link = new Link();
   if(isset($_GET["do"]))
   {
      if(strcmp($_GET["do"], "DELETE") == 0)
      {
         $link->id = $_GET["lid"];
         $link->dbDelete($dbmgr);
      }
   }
   else
   {
      $link->id = $_POST["lid"];
      $link->title = $_POST["title"];
      $link->address = $_POST["address"];
      $link->public = $_POST["public"];
      $link->description = nl2br($_POST["description"]);
      //echo($link->dbUpdate($dbmgr));
      if(!($link->dbUpdate($dbmgr)))
      {
         die("<h1 class=\"error\">CANNOT UPDATE DB</h1>");
      }
   }
   header("Location: link_menu.php");
}
else
{
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Link.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
	$dbmgr = new DB_Mgr("dbates");
	$admin = new Admin();
	if(!empty($_GET["lid"]))
	{
		$link = new Link();
		$link->id = $_GET["lid"];
		$lid = $link->dbLoad($dbmgr);
		if($lid != $_GET["lid"])
		{
			echo("<h1>ERROR. Please select a link from the Link List</h1>");
			exit();
		}
		// A LINK HAS BEEN SELECTED FOR EDITING
		$title = "Modify your Link then press submit.";
		include("html_header.inc");
	?>
	<body>
		<form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateLinkForm(this)";>
		<input type="hidden" name="lid" value="<?php echo($link->id);?>">
			<table class="mod_screen">
				<tr>
					<th class="menu" colspan="2">Edit Link</th>
				</tr>
				<tr>
					<td>Title</td>
					<td>
						<input class="linkEdit" type="text" name="title" value="<?php echo(htmlentities($link->title)); ?>"></input>
					</td>
				</tr>
				<tr>
					<td>Address</td>
					<td>
						<input class="linkEdit" type="text" name="address" value="<?php echo(htmlentities($link->address)); ?>"></input>
					</td>
				</tr>
				<tr>
					<td class="repEdit">STATUS:</td>
					<td class="repEdit"><?php
							 echo("<input type=\"radio\" class=\"radio\" name=\"public\" value=\"1\"");
							 if($link->public)
								  echo(" checked");
							 echo(">&nbsp; Public\n");
							 echo("<input type=\"radio\" class=\"radio\" name=\"public\" value=\"0\"");
							 if(!($link->public))
								  echo(" checked");
							 echo(">&nbsp; Private\n");
					?></td>
				</tr>
				<tr>
					<td>Description</td>
					<td>
						<textarea name="description"><?php echo(htmlentities($admin->br2nl($link->description))); ?></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input class="submitButton" type="Submit" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input class="submitButton" type="Button" name="Cancle" value="Cancel" onClick="location.href='link_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input class="submitButton" type="Button" name="Delete" value="Delete" onClick="if(confirm('Are you sure you want to delete this link')){location.href='link_edit.php?do=DELETE&lid=<?php echo($link->id);?>'}" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
					</td>
				</tr>
			</table>
		</form>
	</body>
	</html>
		<?
	}
	else
	{
		header("Location: menu.php");
	}
}
?>