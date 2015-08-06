<?php
require_once("../classes/DB_Mgr.inc");
require_once("../classes/Admin.inc");
require_once("../classes/Custom_Page.inc");
require_once("../classes/Security.inc");
$security = new Security();
$dbmgr = new DB_Mgr("dbates");
$admin = new Admin();
$cp = new Custom_Page();
$cp->setClient($dbmgr, $_GET["cid"]);
if($security->user_is_sa_user($cp->client))
{
   header("Location: sa_edit.php");
}
if(isset($_GET["do"]) && (strcmp($_GET["do"],"DE") == 0))
{
   $rs = $cp->dbDeactivate($dbmgr);
   if($rs == true)
   {
      header("Location: cp_menu.php");
   }
   else
   {
      die("<h1 class=\"error\">$rs</h1>");
   }
}
else if(isset($_GET["do"]) && (strcmp($_GET["do"],"RE") == 0))
{
   $rs = $cp->dbActivate($dbmgr);
   if($rs == true)
   {
      header("Location: cp_menu.php");
   }
   else
   {
      die("<h1 class=\"error\">$rs</h1>");
   }
}
else
{
   $cp->dbLoad($dbmgr);
   $title = "Modify Your Custom Page";
   include("html_header.inc"); ?>
   <body>
      <!--<table class="body" border="1">-->
      <table class="mod_screen" style="height: 600px">
         <tr>
            <td width="20%">
               <table border="0" width="100%">
                  <tr>
                     <td align="center">
                        <a href="cp_logo_edit.php?cid=<?php echo($cp->client->id); ?>&fn=<?php echo($cp->logo); ?>">
                           <img class="logo" src="https://<?php echo($_SERVER["SERVER_NAME"]); ?>/upload_dir/<?php echo($cp->logo); ?>">
                        </a>
                     </td>
                  </tr>
                  <tr>
                     <td>
                        <table class="sub">
                           <tr>
                              <th>COVERAGE</th>
                           </tr>
                           <?php
                           for($i=0; $i < sizeof($cp->coverage_list); $i++)
                           {
                              echo("\t<tr>\n");
                              echo("\t\t<td>\n");
                              echo("<a class=\"list\" href=\"cp_coverage_edit.php?cid=" . $cp->client->id . "&cov_id=" . $cp->coverage_list[$i]->cov_id . "\">> ");
                              echo(htmlentities($cp->coverage_list[$i]->title));
                              echo("</a>");
                              echo("\t\t</td>\n");
                              echo("\t</tr>\n");
                           }
                           ?>
                           <tr>
                              <td align="center" style="padding-top:10px;">
                                 <a class="addNew" href="cp_coverage_edit.php?cid=<?php echo($cp->client->id); ?>&cov_id=0">ADD NEW</a>
                              </td>
                           </tr>
                        </table>
                     </td>
                  </tr>
               </table>
            </td>
            <td>
               <table width="100%" border="0">
                  <tr style="height: 50px">
                     <td class="darkBlackSmall"><img style="height: 50px"src="https://<?php echo($_SERVER["SERVER_NAME"]); ?>/public_images/client_access_logo.gif"></td>
                  </tr>
                  <tr>
                     <th>FREQUENT QUESTIONS</th>
                  </tr>
                  <?php
                     //for($i=0; $i < sizeof($cp->link_list); $i++)
                     foreach($cp->faq_list AS $id=>$faq)
                     {
                        echo("\t<tr>\n");
                        echo("\t\t<td>\n");
                        echo("<a class=\"list\" href=\"cp_faq_edit.php?cid=" . $cp->client->id . "&fid=" . $faq->id . "\">> ");
                        echo(htmlentities($faq->question));
                        echo("</a>");
                        echo("\t\t</td>\n");
                        echo("\t</tr>\n");
                     }
                  ?>
                  <tr>
                     <td align="center" style="padding-top:10px;">
                        <form name="addNewFaq" method="post" action="cp_faq_edit.php" onsubmit="return checkSelection(this, 'new_faq_id', 'FAQ');">
                           <select name="new_faq_id">
                              <option selected value="0">Select a New FAQ</option>
                              <?php
                              $allFAQs = $admin->dbLoadFAQList($dbmgr);
                              foreach($allFAQs AS $id=>$faq)
                              {
                                 if(!$cp->faqIsInList($faq->id))
                                 {
                                    echo("<option value=\"" . $faq->id . "\">" . $faq->question . "</option>");
                                 }
                              }
                              ?>
                           </select><br>
                           <input class="submitButton" type="submit" value="ADD NEW" name="submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                           <input type="hidden" name="cid" value="<?php echo($cp->client->id); ?>">
                        </form>
                     </td>
                  </tr>
                  <tr>
                     <th>LINKS</th>
                  </tr>
                  <?php
                     foreach($cp->link_list AS $id=>$link)
                     //for($i=0; $i < sizeof($cp->link_list); $i++)
                     {
                        echo("\t<tr>\n");
                        echo("\t\t<td>\n");
                        echo("<a class=\"list\" href=\"cp_link_edit.php?cid=" . $cp->client->id . "&lid=" . $link->id . "\">> ");
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
                                 if(!$cp->linkIsInList($link->id))
                                 {
                                    echo("<option value=\"" . $link->id . "\">" . $link->title . "</option>");
                                 }
                              }
                              ?>
                           </select><br>
                           <input class="submitButton" type="submit" value="ADD NEW" name="submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                           <input type="hidden" name="cid" value="<?php echo($cp->client->id); ?>">
                        </form>
                     </td>
                  </tr>
                  <tr>
                     <th>FORMS & APPLICATIONS</th>
                  </tr>
                  <?php
                     for($i=0; $i < sizeof($cp->form_list); $i++)
                     {
                        echo("\t<tr>\n");
                        echo("\t\t<td>\n");
                        echo("<a class=\"list\" href=\"cp_form_edit.php?cid=" . $cp->client->id . "&fid=" . $cp->form_list[$i]->id . "\">> ");
                        echo(htmlentities($cp->form_list[$i]->title));
                        echo("</a>");
                        echo("\t\t</td>\n");
                        echo("\t</tr>\n");
                     }
                  ?>
                  <tr>
                     <td align="center" style="padding-top:10px;">
                        <form name="addNewLink" method="post" action="cp_form_edit.php" onsubmit="return checkSelection(this, 'new_form_id', 'Form');">
                           <select name="new_form_id">
                              <option selected value="0">Select a New Form</option>
                              <?php
                              $allForms = $admin->dbLoadFormList($dbmgr);
                              for($x=0; $x < sizeof($allForms); $x++)
                              {
                                 $aForm = $allForms[$x];
                                 if(!$cp->formIsInList($aForm->id))
                                 {
                                    echo("<option value=\"" . $aForm->id . "\">" . $aForm->title . "</option>");
                                 }
                              }
                              ?>
                           </select><br>
                           <input class="submitButton" type="submit" value="ADD NEW" name="submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                           <input type="hidden" name="cid" value="<?php echo($cp->client->id); ?>" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                        </form>
                     </td>
                  </tr>
               </table>
            </td>
            <td width="20%">
               <table class="sub">
                  <tr>
                     <th>SERVICE TEAM</th>
                  </tr>
                  <tr>
                     <td style="text-align: center; font-size: small;font-weight: bold;font-family: 'Verdana', Verdana, sans-serif;">ACCOUNT LEADERS</td>
                  </tr>
                  <tr><td>
                  <?php
                  
                     for($i=0; $i < $cp->service_team->get_size(); $i++)
                     {
                        $sm = $cp->service_team->get_member($i);
                        if(strcmp($sm->type, "LEADER") == 0)
                        {
                           echo("\t<tr>\n");
                           echo("\t\t<td class=\"service_team\">\n");
                           echo("<a class=\"list\" href=\"cp_service_team_edit.php?cid=" . $cp->client->id . "&rep_id=" . $sm->rep->id . "\">> ");
                           echo($sm->rep->first_name . " " . $sm->rep->last_name . "<br>\n");
                           echo("<i>" . $sm->title . "</i><br>\n");
                           echo($sm->rep->phone);
                           echo("</a>");
                           echo("\t\t</td>\n");
                           echo("\t</tr>\n");
                        }
                     }
                  ?>
                  </td></tr>
                  <tr>
                     <td style="text-align: center; font-size: small;font-weight: bold;font-family: 'Verdana', Verdana, sans-serif;">ACCOUNT SERVICE</td>
                  </tr>
                  <?php
                     for($i=0; $i < $cp->service_team->get_size(); $i++)
                     {
                        $sm = $cp->service_team->get_member($i);
                        if(strcmp($sm->type, "SERVICE") == 0)
                        {
                           echo("\t<tr>\n");
                           echo("\t\t<td class=\"service_team\">\n");
                           echo("<a class=\"list\" href=\"cp_service_team_edit.php?cid=" . $cp->client->id . "&rep_id=" . $sm->rep->id . "\">> ");
                           echo($sm->rep->first_name . " " . $sm->rep->last_name . "<br>\n");
                           echo("<i>" . $sm->title . "</i><br>\n");
                           echo($sm->rep->phone);
                           echo("</a>");
                           echo("\t\t</td>\n");
                           echo("\t</tr>\n");
                        }
                     }
                  ?>
                  <tr>
                     <td align="center" style="padding-top:10px;"><a class="addNew" href="cp_service_team_edit.php?cid=<?php echo($cp->client->id); ?>&rep_id=0">ADD NEW</td>
                  </tr>
               </table>
            </td>
         </tr>
         <tr>
            <td colspan="3" align="center">
               <input class="submitButton" type="button" name="MENU" value="MENU" onclick="location.href='cp_menu.php'"  onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               <?php
                  if($cp->active)
                  {
                     ?><input class="submitButton" type="button" name="DEACTIVATE" value="DEACTIVATE" onclick="if(confirm('Are you sure you want to deactivate this page?')){location.href='cp_edit.php?cid=<?php echo($cp->client->id);?>&do=DE'}" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';"><?
                  }
                  else
                  {
                     ?><input class="submitButton" type="button" name="ACTIVATE" value="ACTIVATE" onclick="if(confirm('Are you sure you want to reactivate this page?')){location.href='cp_edit.php?cid=<?php echo($cp->client->id);?>&do=RE'}" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';"><?
                  }
               ?>
            </td>
         </tr>
      </table>
   </body>
<?php
}
?>