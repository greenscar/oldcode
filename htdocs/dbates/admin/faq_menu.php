<?php
    include("ensure_admin.inc");
?>
<?php
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/FAQ.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $admin = new Admin();
   $title = "Select a Link or Create New";
   include("html_header.inc");
   ?>
<body>
   <table class="mod_screen">
   <tr>
      <th class="menu">FAQ Administration</th>
   </tr>
   <?
      $faqArray = $admin->dbLoadFAQList($dbmgr);
      for($l=0; $l<sizeof($faqArray);$l++)
      {
         echo("\t<tr>\n");
         echo("\t\t<td>\n");
         echo("<a class=\"menu\" href=\"faq_edit.php?fid=" . $faqArray[$l]->id . "\">");
         echo(htmlentities($faqArray[$l]->question));
         echo("</a>");
         echo("\t\t</td>\n");
         echo("\t</tr>\n");
      }
   ?>
   <tr>
      <td align="center">
         <input class="submitButton" type="button" value="Create New" onclick="location.href='faq_create.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
         <input class="submitButton" type="button" value="Main Menu" onclick="location.href='index.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
      </td>
   </tr>
   </table>
</body>
</html>
   