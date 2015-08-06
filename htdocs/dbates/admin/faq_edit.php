<?php
    include("ensure_admin.inc");
?>
<?php
if(isset($_POST["fid"]) || (isset($_GET["fid"]) && isset($_GET["do"])))
{
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/FAQ.inc");
   //require_once("../php/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $faq = new FAQ();
   if(isset($_GET["do"]))
   {
      if(strcmp($_GET["do"], "DELETE") == 0)
      {
         $faq->id = $_GET["fid"];
         $faq->dbDelete($dbmgr);
      }
   }
   else
   {
      $faq->id = $_POST["fid"];
      $faq->question = $_POST["question"];
      //$faq->solution = nl2br($_POST["solution"]);
      $faq->solution = $_POST["solution"];
      if(!($faq->dbUpdate($dbmgr)))
      {
         die("<h1 class=\"error\">CANNOT UPDATE DB</h1>");
      }
   }
   header("Location: faq_menu.php");
}
else
{
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/FAQ.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
	$dbmgr = new DB_Mgr("dbates");
	$admin = new Admin();
	if(!empty($_GET["fid"]))
	{
		$faq = new FAQ();
		$faq->id = $_GET["fid"];
		$fNum = $faq->dbLoad($dbmgr);
		if($fNum != $_GET["fid"])
		{
			echo("<h1>ERROR. Please select a FAQ from the FAQ List</h1>");
			exit();
		}
		// A FAQ HAS BEEN SELECTED FOR EDITING
		$title = "Modify your FAQ then press submit.";
		include("html_header.inc");
	?>
	<body>
		<form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateFAQForm(this)";>
		<input type="hidden" name="fid" value="<?php echo($faq->id);?>">
			<table class="mod_screen">
				<tr>
					<th class="menu" colspan="2">Edit FAQ</th>
				</tr>
				<tr>
					<td>Question</td>
					<td>
						<input class="linkEdit" type="text" name="question" value="<?php echo(htmlentities($faq->question)); ?>"></input>
					</td>
				</tr>
				<tr>
					<td>Solution</td>
					<td>
						<textarea class="linkEdit" name="solution"><?php echo(htmlentities($admin->br2nl($faq->solution))); ?></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input class="submitButton" type="Submit" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input class="submitButton" type="Button" name="Cancle" value="Cancel" onClick="location.href='faq_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input class="submitButton" type="Button" name="Delete" value="Delete" onClick="if(confirm('Are you sure you want to delete this FAQ?')){location.href='faq_edit.php?do=DELETE&fid=<?php echo($faq->id);?>'}" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
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
		header("Location: faq_menu.php");
	}
}
?>