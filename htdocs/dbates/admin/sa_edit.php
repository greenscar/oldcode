<?php
/*
 * ON THIS PAGE, THERE ARE ONLINE FORMS AND PRINTABLE FORMS.
 * ALL FORMS WITH EXTENSION 'php' ARE ONLINE.
 * ALL OTHER FORMS ARE PRINTABLE.
 */
require_once("../classes/DB_Mgr.inc");
require_once("../classes/Admin.inc");
require_once("../classes/Custom_Page_Sel_Accts.inc");
$dbmgr = new DB_Mgr("dbates");
$admin = new Admin();
$sap = new Custom_Page_Sel_Accts($dbmgr);
$sap->dbLoad($dbmgr);
$title = "Modify Your Select Accounts Page";
include("html_header.inc");
?>
<body>
   <!--<table class="body" border="1">-->
   <table class="mod_screen" style="height: 600px">
      <tr>
         <td width="30%">
            <table border="0" width="100%">
               <tr>
                  <td align="center">
                     <img class="logo" src="https://<?php echo($_SERVER["SERVER_NAME"]); ?>/upload_dir/select_accts_logo.gif">
                  </td>
               </tr>
               <tr>
                  <td>
                     <table class="sub">
                        <tr>
                           <th>SPECIALTIES</th>
                        </tr>
                        <?php
                        foreach($sap->coverage_list AS $key=>$cov)
                        //for($i=0; $i < sizeof($sap->coverage_list); $i++)
                        {
                           echo("\t<tr>\n");
                           echo("\t\t<td>\n");
                           echo("<a class=\"list\" href=\"cp_coverage_edit.php?cid=" . $sap->client->id . "&cov_id=" . $cov->cov_id . "\">> ");
                           echo(htmlentities($cov->title));
                           echo("</a>");
                           echo("\t\t</td>\n");
                           echo("\t</tr>\n");
                        }
                        ?>
                        <tr>
                           <td align="center" style="padding-top:10px;">
                              <a class="addNew" href="cp_coverage_edit.php?cid=<?php echo($sap->client->id); ?>&cov_id=0">ADD NEW</a>
                           </td>
                        </tr>
                        <tr>
                           <th>SERVICE TEAM</th>
                        </tr>
                        <tr>
                           <td>
                           <?php
                              for($i=0; $i < $sap->service_team->get_size(); $i++)
                              {
                                 $sm = $sap->service_team->get_member($i);
                                 echo("\t<tr>\n");
                                 echo("\t\t<td class=\"service_team\">\n");
                                 echo("<a class=\"list\" href=\"cp_service_team_edit.php?cid=" . $sap->client->id . "&rep_id=" . $sm->rep->id . "\">> ");
                                 echo($sm->rep->first_name . " " . $sm->rep->last_name . "<br>\n");
                                 echo("<i>" . $sm->title . "</i><br>\n");
                                 echo($sm->rep->phone);
                                 echo("</a>");
                                 echo("\t\t</td>\n");
                                 echo("\t</tr>\n");
                              }
                           ?>
                           </td>
                        </tr>
                        <tr>
                           <td align="center" style="padding-top:10px;"><a class="addNew" href="cp_service_team_edit.php?cid=<?php echo($sap->client->id); ?>&rep_id=0">ADD NEW</td>
                        </tr>
                        <tr>
                           <th>LINKS</th>
                        </tr>
                        <?php
                           foreach($sap->link_list AS $id=>$link)
                           //for($i=0; $i < sizeof($sap->link_list); $i++)
                           {
                              echo("\t<tr>\n");
                              echo("\t\t<td>\n");
                              echo("<a class=\"list\" href=\"cp_link_edit.php?cid=" . $sap->client->id . "&lid=" . $link->id . "\">> ");
                              echo(htmlentities($link->title));
                              echo("</a>");
                              echo("\t\t</td>\n");
                              echo("\t</tr>\n");
                           }
                        ?>
                        <tr>
                           <td align="center" style="padding-top:10px;">
                              <form name="addNewLink" method="post" action="cp_link_edit.php" onsubmit="return checkSelection(this, 'new_link_id', 'Link');">
                                 <select name="new_link_id">
                                    <option selected value="0">Select a Link</option>
                                    <?php
                                    $allLinks = $admin->dbLoadLinkList($dbmgr);
                                    foreach($allLinks AS $key=>$link)
                                    {
                                       if(!$sap->linkIsInList($link->id))
                                       {
                                          echo("<option value=\"" . $link->id . "\">" . $link->title . "</option>");
                                       }
                                    }
                                    ?>
                                 </select><br>
                                 <input class="submitButton" type="submit" value="ADD NEW" name="submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                                 <input type="hidden" name="cid" value="<?php echo($sap->client->id); ?>">
                              </form>
                           </td>
                        </tr>
                     </table>
                  </td>
               </tr>
            </table>
         </td>
         <td width="70%">
            <table width="100%" border="0">
               <tr style="height: 50px">
                  <td class="darkBlackSmall"><img style="height: 50px"src="https://<?php echo($_SERVER["SERVER_NAME"]); ?>/public_images/client_access_logo.gif"></td>
               </tr>
               
               <tr>
                  <th>FORMS & APPLICATIONS</th>
               </tr>
               <tr>
                  <th>ONLINE FORMS</th>
               </tr>
               <?php
                  foreach($sap->form_list AS $id=>$aForm)
                  {
                     if(strcmp($aForm->getFileType(), "php") == 0)
                     {
                        echo("\t<tr>\n");
                        echo("\t\t<td>\n");
                        echo("<a class=\"list\" href=\"cp_form_edit.php?cid=" . $sap->client->id . "&fid=" . $aForm->id . "\">> ");
                        echo(htmlentities($aForm->title));
                        echo("</a>");
                        echo("\t\t</td>\n");
                        echo("\t</tr>\n");
                     }
                  }
               ?>
               <tr>
                  <td align="center" style="padding-top:10px;">
                     <form name="addNewLink" method="post" action="cp_form_edit.php" onsubmit="return checkSelection(this, 'new_form_id', 'Form');">
                        <select name="new_form_id">
                           <option selected value="0">Select a New Form</option>
                           <?php
                           $allForms = $admin->dbLoadFormList($dbmgr);
                           foreach($allForms AS $id=>$aForm)
                           {
                              if((!$sap->formIsInList($aForm->id)) && (strcmp($aForm->getFileType(), "php") == 0))
                              {
                                 echo("<option value=\"" . $aForm->id . "\">" . $aForm->title . "</option>");
                              }
                           }
                           ?>
                        </select><br>
                        <input class="submitButton" type="submit" value="ADD NEW" name="submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                        <input type="hidden" name="cid" value="<?php echo($sap->client->id); ?>" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                     </form>
                  </td>
               </tr>
               <tr>
                  <th>PRINTABLE FORMS</th>
               </tr>
               <?php
                  //for($i=0; $i < sizeof($sap->form_list); $i++)
                  foreach($sap->form_list AS $id=>$aForm)
                  {
                     if(strcmp($aForm->getFileType(), "php") != 0)
                     {
                        echo("\t<tr>\n");
                        echo("\t\t<td>\n");
                        echo("<a class=\"list\" href=\"cp_form_edit.php?cid=" . $sap->client->id . "&fid=" . $aForm->id . "\">> ");
                        echo(htmlentities($aForm->title));
                        echo("</a>");
                        echo("\t\t</td>\n");
                        echo("\t</tr>\n");
                     }
                  }
               ?>
               <tr>
                  <td align="center" style="padding-top:10px;">
                     <form name="addNewLink" method="post" action="cp_form_edit.php" onsubmit="return checkSelection(this, 'new_form_id', 'Form');">
                        <select name="new_form_id">
                           <option selected value="0">Select a New Form</option>
                           <?php
                           $allForms = $admin->dbLoadFormList($dbmgr);
                           foreach($allForms AS $id=>$aForm)
                           {
                              if((!$sap->formIsInList($aForm->id)) && (strcmp($aForm->getFileType(), "php") != 0))
                              {
                                 echo("<option value=\"" . $aForm->id . "\">" . $aForm->title . "</option>");
                              }
                           }
                           ?>
                        </select><br>
                        <input class="submitButton" type="submit" value="ADD NEW" name="submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                        <input type="hidden" name="cid" value="<?php echo($sap->client->id); ?>" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                     </form>
                  </td>
               </tr>
            </table>
         </td>
      </tr>
      <tr>
         <td colspan="3" align="center">
            <input class="submitButton" type="button" name="MENU" value="MENU" onclick="location.href='index.php'"  onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
         </td>
      </tr>
   </table>
</body>