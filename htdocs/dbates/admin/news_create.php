<?php
    include("ensure_admin.inc");
?>
<?php
if(isset($_POST["title"]))
{
   //PROCESS NEW NEWS
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/News.inc");
   $dbmgr = new DB_Mgr("dbates");
   $news = new News();
   
   $news->title = $_POST["title"];
   $news->description = nl2br($_POST["description"]);
   if(isset($_POST["never_expire"]) && $_POST["never_expire"])
      $news->never_expire = true;
   else
   {
      $news->never_expire = false;
      $news->expire_date = strtotime($_POST["expire_date"]);
   }
   if(!($news->dbInsert($dbmgr)))
   {
      die("<h1 class=\"error\">CANNOT CREATE NEWS</h1>");
   }
   header("Location: news_menu.php");
}
else
{
   //DISPLAY NEWS FORM
   $title = "Enter your news.";
   include("html_header.inc");
   ?>
   </head>
   <body>
      <form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateNewsForm(this);">
         <table class="mod_screen">
            <tr>
               <th colspan="2" class="menu">Create News</th>
            </tr>
            <tr>
               <td>Title</td>
               <td>
                  <input class="newsEdit" type="text" name="title"></input>
               </td>
            </tr>
            <tr>
               <td>Description</td>
               <td>
                  <textarea class="newsEdit" style="height: 300px;" name="description"></textarea>
               </td>
            </tr>
            <tr>
               <td class="repEdit">Expire Date: (MM/DD/YYYY)</td>
               <td class="repEdit">
                  <input type="text" class="newsEdit" name="expire_date"></input>
               </td>
            </tr>
            <tr>
               <td class="repEdit">Never Expire:</td>
               <td class="repEdit">
                  <input type="checkbox" class="newsEdit" style="padding: 0px; width: 20px" name="never_expire">
               </td>
            </tr>
            <tr>
               <td colspan="2" align="center">
                  <input type="Submit" class="submitButton" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                  <input type="Button" class="submitButton" name="Cancel" value="Cancel" onClick="location.href='news_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               </td>
            </tr>
         </table>
      </form>
   </body>
   </html>
<?php
}
?>