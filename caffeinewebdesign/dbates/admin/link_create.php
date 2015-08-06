<?php
    include("ensure_admin.inc");
?>
<?
if(isset($_POST["title"]))
{
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Link.inc");
   $dbmgr = new DB_Mgr("dbates");
   $link = new Link();
   
   $link->title = $_POST["title"];
   $link->address = $_POST["address"];
   $link->public = $_POST["public"];
   $link->description = nl2br($_POST["description"]);
   if(!($link->dbInsert($dbmgr)))
   {
      die("<h1 class=\"error\">CANNOT CREATE LINK</h1>");
   }
   header("Location: link_menu.php");
}
else
{
	$title = "Enter your Link Information";
   include("html_header.inc");
   ?>
<body>
	<form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateLinkForm(this)";>
		<table class="mod_screen">
			<tr>
				<th class="menu" colspan="2">Create Link</th>
			</tr>
			<tr>
				<td>Title</td>
				<td>
					<input class="linkEdit" type="text" name="title"></input>
				</td>
			</tr>
			<tr>
				<td>Address</td>
				<td>
					<input class="linkEdit" type="text" name="address" value="http://"></input>
				</td>
			</tr>
			<tr>
				<td class="repEdit">STATUS:</td>
				<td class="repEdit">
               <input type="radio" class="radio" name="public" value="1">&nbsp; Public
               <input type="radio" class="radio" name="public" value="0">&nbsp; Private
				</td>
			</tr>
			<tr>
				<td>Description</td>
				<td>
					<textarea class="linkEdit" name="description"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input class="submitButton" type="Submit" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
					<input class="submitButton" type="Button" name="Cancle" value="Cancel" onClick="location.href='link_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
				</td>
			</tr>
		</table>
   </form>
</body>
</html>
<?
}
?>