<?php
   require_once("../classes/Secretary.inc");
   require_once("../classes/Form.inc");
   require_once("../classes/Custom_Page.inc");
   require_once("../classes/DB_Mgr.inc");
   require_once("../classes/Security.inc");
   $security = new Security();
   $dbmgr = new DB_Mgr("dbates");
   $form = new Form();
   $cp = new Custom_Page();
   $log = new Secretary();      
   if(!empty($_POST["new_form_id"]))
   {
      $log->write("POST[new_form_id] = " . $_POST["new_form_id"]);
      $log->write("POST[client_id] = " . $_POST["cid"]);
      // PROCESS NEW LINK CREATION
      $form->id = $_POST["new_form_id"];
      $cp->setClient($dbmgr, $_POST["cid"]);
      $final = $cp->dbAddForm($dbmgr, $form);
      $log->write("final = " . $final);
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
      $log->write("GET[fid] = " . $_GET["fid"]);
      $log->write("GET[cid] = " . $_GET["cid"]);
      $form->id = $_GET["fid"];
      $form->dbLoad($dbmgr);
      $cp->setClient($dbmgr, $_GET["cid"]);
      if(isset($_GET["ver"]))
      {
         $log->write("GET[ver] = " . $_GET["ver"]);
         if(strcmp($_GET["ver"], "YES") == 0)
         {
            // PROCESS DELETE
            $res = $cp->dbRemoveForm($dbmgr, $form);
            if($res)
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
               echo("ERROR IN DELETING LINK");
         }
         else // $_GET["ver"] == NO
            header("Location: cp_edit.php?cid=" . $cp->client->id);
      }
      else
      {
         // DISPLAY SELECTED LINK TO VERIFY DELETE.
         $title = "Are you sure you wish to remove this form?";
         include("html_header.inc");
         ?>
         <body>
         <table class="mod_screen">
            <tr>
               <th colspan="2" class="menu">
                  Are you sure you want to remove this client form?
               </th>
            </tr>
            <tr>
               <td>
                  Form Title:
               </td>
               <td>
                  <?php echo($form->title); ?>
               </td>
            </tr>
            <tr>
               <td colspan="2" align="center">
                  <a class="addNew" href="cp_form_edit.php?cid=<?php echo($cp->client->id); ?>&fid=<?php echo($form->id); ?>&ver=YES">YES</a>
                  <a class="addNew" href="cp_form_edit.php?cid=<?php echo($cp->client->id); ?>&fid=<?php echo($form->id); ?>&ver=NO">NO</a>
               </td>
            </tr>
         </table>
         </body>
         <?php
      }
   }
?>