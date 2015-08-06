<?php
   include("ensure_admin.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Rep.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
$log = new Secretary();
$log->write("rep_menu.php START");
$dbmgr = new DB_Mgr("dbates");
$admin = new Admin();
$title = "Select a Representative or Create New";
include("html_header.inc");
?>
<body>
   <table class="mod_screen">
   <tr><th class="menu">Associate Index</th></tr>
   <tr><td></td></tr>
   <tr><td align="center"><h4>Click on Associate Name to View / Edit</h4></td></tr>
   <tr>
      <td>
         <table class="mod_screen">
            <?
               $repArray = $admin->dbLoadEmpListBrief($dbmgr);
               $empNum = 0;
					foreach($repArray as $id=>$rep)
               {
                  if($empNum % 2 == 0)
                     echo("\t<tr>\n");
                  echo("\t\t<td>\n");
                  echo("<a href=\"rep_edit.php?rNum=" . $rep->id . "\" class=\"menu\">");
                  echo($rep->get_full_name());
                  echo("</a>");
                  echo("\t\t</td>\n");
                  if($empNum % 2 == 1)
                     echo("\t</tr>\n");
                  $empNum++;      
               }
               if($empNum % 2 == 0) echo("\t</tr>\n");
            ?>
         </table>
      </td>
   </tr>
   <tr>
			<td colspan="2" align="center">
				<input type="Button" class="submitButton" name="Create New" value="Create New" onClick="location.href=('rep_create.php');" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
				<input type="Button" class="submitButton" name="Main Menu"  value="Main Menu"  onClick="location.href=('index.php');" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
			</td>
   </tr>
   </table>
</body>
</html>