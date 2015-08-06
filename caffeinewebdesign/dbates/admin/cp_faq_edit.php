<?php
   include("../error_reporting.inc");
   require_once("../classes/FAQ.inc");
   require_once("../classes/Custom_Page.inc");
   require_once("../classes/DB_Mgr.inc");
   require_once("../classes/Security.inc");
   $security = new Security();
   $dbmgr = new DB_Mgr("dbates");
   $faq = new FAQ();
   $cp = new Custom_Page();
      
   if(!empty($_POST["new_faq_id"]))
   {
      // PROCESS NEW LINK CREATION
      $faq->id = $_POST["new_faq_id"];
      $cp->setClient($dbmgr, $_POST["cid"]);
      $final = $cp->dbAddFAQ($dbmgr, $faq);
      if($final > 0)
      {
         if($security->user_is_sa_user($cp->client))
         {
            header("Location: sa_edit.php");
         }
         else
         {
            header("Location: cp_edit.php?cid=" . $cp->client->id);
         }
      }
      else
         echo($final);
   }
   else
   {
      $faq->id = $_GET["fid"];
      $faq->dbLoad($dbmgr);
      $cp->setClient($dbmgr, $_GET["cid"]);
      if(isset($_GET["ver"]))
      {
         if(strcmp($_GET["ver"], "YES") == 0)
         {
            // PROCESS DELETE
            $res = $cp->dbRemoveFAQ($dbmgr, $faq);
            if($res)
               header("Location: cp_edit.php?cid=" . $cp->client->id);
            else
               echo("ERROR IN DELETING FAQ");
         }
         else // $_GET["ver"] == NO
            header("Location: cp_edit.php?cid=" . $cp->client->id);
      }
      else
      {
         // DISPLAY SELECTED LINK TO VERIFY DELETE.
         $title = "Are you sure you wish to remove this FAQ?";
         include("html_header.inc");
         ?>
         <body>
         <table class="mod_screen">
            <tr>
               <th colspan="2" class="menu">
                  Are you sure you want to remove this client FAQ?
               </th>
            </tr>
            <tr>
               <td>
                  Question:
               </td>
               <td>
                  <?php echo($faq->question); ?>
               </td>
            </tr>
            <tr>
               <td>
                  Solution:
               </td>
               <td>
                  <?php echo($faq->solution); ?>
               </td>
            </tr>
            <tr>
               <td colspan="2" align="center">
                  <a class="addNew" href="cp_faq_edit.php?cid=<?php echo($cp->client->id); ?>&fid=<?php echo($faq->id); ?>&ver=YES">YES</a>
                  <a class="addNew" href="cp_faq_edit.php?cid=<?php echo($cp->client->id); ?>&fid=<?php echo($faq->id); ?>&ver=NO">NO</a>
               </td>
            </tr>
         </table>
         </body>
         <?php
      }
   }
?>