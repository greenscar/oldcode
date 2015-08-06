<?php
    $title = "News";
    $image = "map.jpg";
    $bgcolor = "00A9DE";
    include("./page_header.inc");
?>
            <table class="body">
               <tr>
                  <td>
                     <p>
                     <?php
                        require_once($_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
                        require_once($_SERVER["DOCUMENT_ROOT"]."/classes/User_Public.inc");
                        $user = new User_Public();
                        $user->dbLoadNewsList();
                        //echo("amount news = " . sizeof($user->news_list));
                        if(!empty($user->news_list))
                        {
                            foreach($user->news_list AS $id=>$news)
                            {
                            ?>
                                  <table border=0 width=100% class="directory">
                                     <tr>
                                        <td style="border-bottom: 1px solid black; font-size: 1.0em;">
                                           <?php
                                              echo($news->getPostDate() . " <b>" . $news->title . "</b>");
                                           ?>
                                        </td>
                                     </tr>
                                     <tr>
                                        <td width=50% style="vertical-align:top;font-size: 1.0em;">
                                           <?php
                                              echo($news->description);
                                           ?>
                                        </td>
                                     </tr>
                                  </table>
                            <?
                            }
                        }
                        else
                        {
                            echo("<h3>There is currently no news. Please check back later.</h3>");
                        }
                     ?>
                     </p>
                  </td>
               </tr>
            </table>    

<?php 
    include("./page_footer.inc");
?>