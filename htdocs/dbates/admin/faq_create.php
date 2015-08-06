<?php
    include("ensure_admin.inc");
?>
<?
if(isset($_POST["question"]))
{
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/FAQ.inc");
   $dbmgr = new DB_Mgr("dbates");
   $faq = new FAQ();
   
   $faq->question = $_POST["question"];
   //$faq->solution = nl2br($_POST["solution"]);
   $faq->solution = $_POST["solution"];
   if(!($faq->dbInsert($dbmgr)))
   {
      die("<h1 class=\"error\">CANNOT CREATE FAQ</h1>");
   }
   header("Location: faq_menu.php");
}
else
{
	$title = "Enter your FAQ";
   include("html_header.inc");
   ?>
<body>
	<form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateFAQForm(this)";>
		<table class="mod_screen">
			<tr>
				<th class="menu" colspan="2">Create FAQ</th>
			</tr>
			<tr>
				<td>Question</td>
				<td>
					<input class="linkEdit" type="text" name="question"></input>
				</td>
			</tr>
			<tr>
				<td>Solution</td>
				<td>
					<textarea class="linkEdit" name="solution"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input class="submitButton" type="Submit" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
					<input class="submitButton" type="Button" name="Cancle" value="Cancel" onClick="location.href='faq_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
				</td>
			</tr>
		</table>
   </form>
</body>
</html>
<?
}
?>
