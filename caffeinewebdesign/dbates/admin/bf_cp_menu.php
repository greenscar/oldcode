<?php
   //echo($_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
   //echo("<br>".$_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/BFCP.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $admin = new Admin();
   $title = "Select a Batch File Custom Page or Create New";
   include("html_header.inc");
?>
<body>
   <table class="mod_screen">
   <tr align="center">
      <th class="menu" colspan="2">Batch File Custom Pages</th>
   </tr>
<?php
      $cpArray = $admin->dbLoadBFCPList($dbmgr);
      for($l=0; $l<sizeof($cpArray);$l++)
      {
         $custPage = $cpArray[$l];
         echo("\t<tr>\n");
         echo("\t\t<td valign=\"top\">\n");
         echo("\t\t\t<a class=\"menu\" href=\"bf_cp_edit.php?cid=" . $custPage->client->id . "&do=disp\">\n");
         echo("\t\t\t\t" . $custPage->client->name . "\n");
         echo("\t\t\t</a>\n");
         echo("\t\t</td>\n");
         echo("\t\t<td>\n");
         echo("<a class=\"menu\" href=\"bf_cp_edit.php?cid=" . $custPage->client->id . "&do=disp\">");
         echo(htmlentities($custPage->isActive()));
         echo("</a>");
         echo("\t\t</td>\n");
         echo("\t</tr>\n");
      }
?>
   <tr>
      <td colspan="2" align="center">
         <input type="button" class="submitButton" value="Create New" onclick="location.href='bf_cp_create.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
         <input type="button" class="submitButton" value="Main Menu" onclick="location.href='index.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
      </td>
   </tr>
   </table>
</body>
</html>
   