<?php
   //require_once($_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
    include("ensure_admin.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Custom_Page.inc");
   $title = "Select a Custom Page or Create New";
   include("html_header.inc"); ?>
<body>
   <table class="mod_screen">
   <tr align="center">
      <th class="menu" colspan="3">Custom Pages</th>
   </tr>
<?php
      $cpArray = $admin->dbLoadCustomPageList($dbmgr);
      if(!empty($cpArray))
      {
         foreach($cpArray as $id=>$custPage)
         {
            if(is_object($custPage))
            {
               //$custPage = $cpArray[$l];
               echo("\t<tr>\n");
               echo("\t\t<td width=200px>\n");
               echo("\t\t\t<a class=\"list\" href=\"cp_edit.php?cid=" . $custPage->client->id . "\">\n");
               echo("\t\t\t\t<img class=\"logo\" src=\"https://" . $_SERVER["SERVER_NAME"] . "/upload_dir/" . $custPage->logo . "\">\n");
               echo("\t\t\t</a>\n");
               echo("\t\t</td>\n");
               echo("\t\t<td valign=\"top\">\n");
               echo("\t\t\t<a class=\"list\" href=\"cp_edit.php?cid=" . $custPage->client->id . "\">\n");
               echo("\t\t\t\t" . $custPage->client->name . "\n");
               echo("\t\t\t</a>\n");
               echo("\t\t</td>\n");
               echo("\t\t<td valign=\"top\">\n");
               echo("\t\t\t<a class=\"list\" href=\"cp_edit.php?cid=" . $custPage->client->id . "\">\n");
               echo("\t\t\t\t" . $custPage->isActive() . "\n");
               echo("\t\t\t</a>\n");
               echo("\t\t</td>\n");
               echo("\t</tr>\n");
            }
         }
      }
?>
   <tr>
      <td colspan="3" align="center">
         <input type="button" class="submitButton" value="Create New" onclick="location.href='cp_create.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
         <input type="button" class="submitButton" value="Main Menu" onclick="location.href='index.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
      </td>
   </tr>
   </table>
</body>
</html>
   