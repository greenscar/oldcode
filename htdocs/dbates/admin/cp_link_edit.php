<?php
    include("ensure_admin.inc");
?>
<?php
   require_once("../classes/Link.inc");
   require_once("../classes/Custom_Page.inc");
   require_once("../classes/DB_Mgr.inc");
   $dbmgr = new DB_Mgr("dbates");
   $link = new Link();
   $cp = new Custom_Page();
      
   if(!empty($_POST["new_link_id"]))
   {
      // PROCESS NEW LINK CREATION
      $link->id = $_POST["new_link_id"];
      $cp->setClient($dbmgr, $_POST["cid"]);
      $final = $cp->dbAddLink($dbmgr, $link);
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
      $link->id = $_GET["lid"];
      $link->dbLoad($dbmgr);
      $cp->setClient($dbmgr, $_GET["cid"]);
      if(isset($_GET["ver"]))
      {
         if(strcmp($_GET["ver"], "YES") == 0)
         {
            // PROCESS DELETE
            $res = $cp->dbRemoveLink($dbmgr, $link);
            if($res)
               header("Location: cp_edit.php?cid=" . $cp->client->id);
            else
               echo("ERROR IN DELETING LINK");
         }
         else // $_GET["ver"] == NO
            header("Location: cp_edit.php?cid=" . $cp->client->id);
      }
      else
      {
         // DISPLAY SELECTED LINK TO VERIFY DELETE.
         $title = "Are you sure you wish to remove this link?";
         include("html_header.inc");
         ?>
         <body>
         <table class="mod_screen">
            <tr>
               <th colspan="2" class="menu">
                  Are you sure you want to remove this client link?
               </th>
            </tr>
            <tr>
               <td>
                  Link Title:
               </td>
               <td>
                  <?php echo($link->title); ?>
               </td>
            </tr>
            <tr>
               <td>
                  Link Address:
               </td>
               <td>
                  <?php echo($link->address); ?>
               </td>
            </tr>
            <tr>
               <td colspan="2" align="center">
                  <a class="addNew" href="cp_link_edit.php?cid=<?php echo($cp->client->id); ?>&lid=<?php echo($link->id); ?>&ver=YES">YES</a>
                  <a class="addNew" href="cp_link_edit.php?cid=<?php echo($cp->client->id); ?>&lid=<?php echo($link->id); ?>&ver=NO">NO</a>
               </td>
            </tr>
         </table>
         </body>
         <?php
      }
   }
?>