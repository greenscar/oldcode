<?php
      //require_once($_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
      require_once($_SERVER["DOCUMENT_ROOT"]."/admin/ensure_admin.inc");
      require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
      require_once($_SERVER["DOCUMENT_ROOT"]."/classes/News.inc");
      require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
      $dbmgr = new DB_Mgr("dbates");
      $admin = new Admin();
      $title = "Select an Article or Create New";
      include("html_header.inc");
?>
<body>
   <table class="mod_screen">
   <tr>
      <th class="menu">News Index</th>
   </tr>
   <?
      $newsArray = $admin->dbLoadNewsList($dbmgr);
      for($l=0; $l<sizeof($newsArray);$l++)
      {
         echo("\t<tr>\n");
         echo("\t\t<td>\n");
         echo("<a class=\"menu\" href=\"news_edit.php?nNum=" . $newsArray[$l]->id . "\">");
         echo(htmlentities($newsArray[$l]->name));
         echo("</a>");
         echo("\t\t</td>\n");
         echo("\t</tr>\n");
      }
   ?>
   <tr>
      <td align="center">
         <input type="button" class="submitButton" value="Create New" onclick="location.href='news_create.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
         <input type="button" class="submitButton" value="Main Menu" onclick="location.href='index.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
      </td>
   </tr>
   </table>
</body>
</html>
   