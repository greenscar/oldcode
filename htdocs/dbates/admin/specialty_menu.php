<?php
    include("ensure_root.inc");
?>
<?php
   //require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Specialty.inc");
   //require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $admin = new Admin();
	$title = "Select a Specialty or Create New";
	include("html_header.inc");
?>
<body>
   <table class="mod_screen">
   <tr>
      <th colspan="2" class="menu">Specialty Index</th>
   </tr>
   <tr>
      <th width="90%">Title</th>
      <th>Active</th>
   </tr>
   <?
      $specialtyArray = $admin->dbLoadSpecialties($dbmgr);
		foreach($specialtyArray AS $id=>$spec)
		{
      //for($l=0; $l<sizeof($specialtyArray);$l++)
      //{
			if(strcmp($spec->name, "None") != 0)
			{
				echo("\t<tr>\n");
				echo("\t\t<td>\n");
				echo("<a href=\"specialty_edit.php?sNum=" . $spec->id . "\" class=\"menu\">");
				echo(htmlentities($spec->name));
				echo("</a>");
				echo("\t\t</td>\n");
				echo("\t\t<td>\n");
				echo("<a href=\"specialty_edit.php?sNum=" . $spec->id . "\" class=\"menu\">");
				echo($spec->isActive());
				echo("</a>");
				echo("\t\t</td>\n");
				echo("\t</tr>\n");
			}
      }
   ?>
   <tr>
      <td align="center" colspan="2">
         <input class="submitButton" type="button" value="Create New" onclick="location.href='specialty_create.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
         <input class="submitButton" type="button" value="Main Menu" onclick="location.href='index.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
      </td>
   </tr>
   </table>
</body>
</html>
   