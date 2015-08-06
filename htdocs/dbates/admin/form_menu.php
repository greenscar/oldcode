<?php
    include("ensure_admin.inc");
?>
<?php
   require_once("../classes/DB_Mgr.inc");
   require_once("../classes/Form.inc");
   require_once("../classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $admin = new Admin();
	$title = "Select an Article or Create New";
	include("html_header.inc");
?>
<body>
   <table class="mod_screen">
   <tr>
      <th class="menu" colspan="2">Form Index</th>
   </tr>
   <?
      $formArray = $admin->dbLoadFormList($dbmgr);
		foreach($formArray AS $id=>$form)
      {
         echo("\t<tr>\n");
         echo("\t\t<td>\n");
         echo("<a class=\"menu\" href=\"form_edit.php?fid=" . $form->id . "\">");
         echo(htmlentities($form->title));
         echo("</a>");
         echo("\t\t</td>\n");
			echo("\t\t<td>\n");
         echo("<a class=\"menu\" href=\"form_edit.php?fid=" . $form->id . "\">");
         echo(htmlspecialchars(nl2br($form->description)));
         echo("</a>");
         echo("\t</tr>\n");
      }
   ?>
   <tr>
      <td align="center" colspan="2">
         <input type="button" class="submitButton" value="Create New" onclick="location.href='form_create.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
         <input type="button" class="submitButton" value="Main Menu" onclick="location.href='index.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
      </td>
   </tr>
   </table>
</body>
</html>
   