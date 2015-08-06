<?php
    include("ensure_root.inc");
?>
<?php
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Department.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $admin = new Admin();
	$title = "Select a department or create new.";
	include("html_header.inc");
?>
<body>
   <table class="mod_screen">
   <tr>
      <th class="menu" colspan=3>Department Index</th>
   </tr>
   <tr>
      <th>Name</th>
      <th>Insurance</th>
      <th>Active</th>
   </tr>
   <?
      $deptArray = $admin->dbLoadDepts($dbmgr);
      for($l=0; $l<sizeof($deptArray);$l++)
      {
         echo("\t<tr>\n");
         echo("\t\t<td>\n");
         echo("<a class=\"menu\" href=\"dept_edit.php?did=" . $deptArray[$l]->id . "\">");
         echo(htmlentities($deptArray[$l]->name));
         echo("</a>");
         echo("\t\t</td>\n");
         echo("\t\t<td>\n");
         echo("<a class=\"menu\" href=\"dept_edit.php?did=" . $deptArray[$l]->id . "\">");
         echo(htmlentities($deptArray[$l]->isInsurance()));
         echo("</a>");
         echo("\t\t</td>\n");
         echo("\t\t<td>\n");
         echo("<a class=\"menu\" href=\"dept_edit.php?did=" . $deptArray[$l]->id . "\">");
         echo(htmlentities($deptArray[$l]->isActive()));
         echo("</a>");
         echo("\t\t</td>\n");
         echo("\t</tr>\n");
      }
   ?>
   <tr>
      <td colspan="3" align="center">
         <input class="submitButton" type="submit" value="Create New" onclick="location.href='dept_create.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
         <input class="submitButton" type="submit" value="Main Menu" onclick="location.href='index.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
      </td>
   </tr>
   </table>
</body>
</html>
   