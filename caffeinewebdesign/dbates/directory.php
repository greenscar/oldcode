<?php
    $title = "Associate Directory";
    $image = "map.jpg";
    $bgcolor = "00A9DE";
    include("./page_header_dont_index.inc");
?>          
            <table class="body">
               <tr>
                  <td colspan="2" style="font-size: 8pt;text-align:justify;">
                  <hr>
                     <p style="padding: 0px 15px 0px 15px;margin:0px; border: 0px;">
                        To save an Associate's contact information, click on the vCard link by the name and choose <b>Open</b>. Click the <b>Save and Close</b> button on the vCard form to add the information to your contact book.
                     </p>
                  <hr>
                  </td>
               </tr>
               <tr>
                  <td>
                     <p>
                     <?php
                        require_once($_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
                        require_once($_SERVER["DOCUMENT_ROOT"]."/classes/User_Public.inc");
						require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
                        $user = new User_Public();
                        $user->dbLoadRepList();
						$log = new Secretary();
						$log->write("rep_list size = " . sizeof($user->rep_list));
                        foreach($user->rep_list AS $id=>$rep)
                        {
                           $log->write("------------------" . $rep->first_name);
                        ?>
                              <table border=0 width=100% class="directory" >
                                 <tr>
                                    <th colspan=2>
                                       <?php
                                          echo("\t\t\t\t\t"
                                              . $rep->first_name . " " . $rep->last_name);
                                          if($rep->dept->name != null)
                                             echo(" &middot; " . $rep->dept->name);
                                       ?>
                                    </th>
                                 </tr>
                                 <tr>
                                    <td width=50% style="vertical-align:top;">
                                       <?php
                                       /*
                                        if(strcmp($rep->specialty->name, "None") != 0)
                                          echo("\t\t\t\t\t" . $rep->specialty->name);
                                          echo("\t\t\t\t\t<ul>\n");
                                          if(!empty($rep->role_1))
                                            echo("\t\t\t\t\t<li>" . $rep->role_1 . "</li>\n");
                                          if(!empty($rep->role_2))
                                            echo("\t\t\t\t\t<li>" . $rep->role_2 . "</li>\n");
                                          if(!empty($rep->role_3))
                                            echo("\t\t\t\t\t<li>" . $rep->role_3 . "</li>\n");
                                          echo("\t\t\t\t\t</ul>\n");
                                       */
                                       if(!empty($rep->role_1))
                                       {
                                          echo("\t\t\t\t\t" . $rep->role_1);
                                          if(!empty($rep->role_2))
                                          {
                                             echo(", " . $rep->role_2);
                                             if(!empty($rep->role_3))
                                             {
                                                echo(", " . $rep->role_3);
                                             }
                                          }
                                       }
                                       //if(strcmp($rep->specialty->name, "None") != 0)
                                       //echo("<BR>" . $rep->specialty->name);
                                       if(isset($rep->specialties))
                                       {
                                          echo("\t\t\t\t\t<ul>\n");
					  //echo("<li>" . sizeof($rep->specialties) . "</li>");
                                          foreach($rep->specialties as $id=>$spec)
                                          {
                                            if(strcmp($spec->name, "None") != 0)
                                            echo("\t\t\t\t\t<li>" . $spec->name . "</li>\n");
                                          }
                                          echo("\t\t\t\t\t</ul>\n");
                                       }
                                       ?>
                                    </td>
                                    <td width=50% style="vertical-align:top;">
                                       <?php
                                         if($rep->vCardExists())
                                         {
                                            echo("<a href=\"./vcard.php?fn=" . $rep->first_name . "&ln=" . $rep->last_name . "\" target=\"_blank\"><b><img src=\"./public_images/vcard.gif\" />vCard</b></a><br>");
                                         }
                                          echo("\t\t\t\t\t"
                                          . "<a href=mailto:" . $rep->email . ">"
                                          . $rep->email . "</a>\n<br>");
                                          echo("\t\t\t\t\tPhone: " . $rep->phone . "\n<br>");
                                          echo("\t\t\t\t\tFax: " . $rep->fax . "\n");
                                          
                                       ?>
                                    </td>
                                 </tr>
                              </table>
                        <?
                        }
                     ?>
                     </p>
                  </td>
               </tr>
            </table>   
<?php 
    include("./page_footer.inc");
?>