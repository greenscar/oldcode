<?php
    include("ensure_admin.inc");
?>
<?php
if(isset($_POST["nNum"]) || (isset($_GET["nNum"]) && isset($_GET["do"])))
{
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/News.inc");
   //require_once("../php/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $news = new News();
	if(isset($_GET["do"]))
   {
	   if(strcmp($_GET["do"], "DEL") == 0)
      {
         $news->id = $_GET["nNum"];
         $news->dbDelete($dbmgr);
      }
   }
   else
   {
      $news->id = $_POST["nNum"];
		$news->dbLoad($dbmgr);
		$news->post_date = $_POST["post_date"];
      $news->title = $_POST["title"];
      $news->description = nl2br($_POST["description"]);
      if(isset($_POST["never_expire"]))
         $news->never_expire = true;
      else
      {
         $news->never_expire = false;
         $news->expire_date = strtotime($_POST["expire_date"]);
      }
      //echo($news->dbUpdate($dbmgr));
      if(!($news->dbUpdate($dbmgr)))
      {
         die("<h1 class=\"error\">CANNOT UPDATE DB</h1>");
      }
   }
   header("Location: news_menu.php");
}
else
{
	// DISPLAY NEWS FORM TO MODIFY NEWS.
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/News.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
	$dbmgr = new DB_Mgr("dbates");
	$admin = new Admin();
	if(!empty($_GET["nNum"]))
	{
		$news = new News();
		$news->id = $_GET["nNum"];
		$nNum = $news->dbLoad($dbmgr);
		if($nNum != $_GET["nNum"])
		{
			echo("<h1>ERROR. Please select news from the News List</h1>");
			exit();
		}
		// A LINK HAS BEEN SELECTED FOR EDITING
		$title = "Do your modification then press submit.";
		include("html_header.inc");
		?>
	<body>
		<form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateNewsForm(this)";>
		<input type="hidden" name="nNum" value="<?php echo($news->id);?>">
			<table class="mod_screen">
				<tr>
					<th colspan="2" class="menu">Edit News</th>
				</tr>
				<tr>
					<td>Title</td>
					<td>
						<input class="newsEdit" type="text" name="title" value="<?php echo(htmlentities($news->title)); ?>"></input>
					</td>
				</tr>
				<tr>
					<td>Description</td>
					<td>
						<textarea class="newsEdit" style="height: 300px;" name="description"><?php echo(htmlentities($admin->br2nl($news->description))); ?></textarea>
					</td>
				</tr>
				<tr>
					<td class="repEdit">Expire Date: (MM/DD/YYYY)</td>
					<td class="repEdit">
						<input type="text" class="newsEdit" name="expire_date" value="<?php echo($news->expire_date);?>"></input>
					</td>
				</tr>
				<tr>
					<td class="repEdit">Never Expire:</td>
					<td class="repEdit">
					<?php
						echo("<input type=\"checkbox\" class=\"newsEdit\" style=\"padding: 0px; width: 20px\" name=\"never_expire\"");
						if($news->never_expire) echo(" checked");
						echo(">");
						?>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="hidden" name="post_date" value="<?php echo($news->post_date); ?>">
						<input type="Submit" class="submitButton" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input type="Button" class="submitButton" name="Cancel" value="Cancel" onClick="location.href='news_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input type="Button" class="submitButton" name="Delete" value="Delete" onClick="if(confirm('Are you sure you want to delete this news')){location.href='news_edit.php?nNum=<?php echo($news->id);?>&do=DEL'}" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
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