<?php
   if(isset($_GET["group"]))
   {
      $group = $_GET["group"];
      $dir = "images/$group";
      $photos = array();
      if (is_dir($dir))
      {
         if ($dh = opendir($dir)) {
            while (($file = readdir($dh)) !== false) {
               if(strpos($file, ".jpg"))
               {
                  $filename = $dir . "/" . $file;
                  array_push($photos, $filename); 
               }
            }
            closedir($dh);
         }  
      }
   }
?>
<html>
<head>
   <title>Photography by Design - Houston, TX Wedding Photography & Portrait Studio</title>
   <meta name="description" content="Professional wedding photographer, Houston wedding photographer, Houston Portrait Photography, Photography, 35 years wedding and portrait photography, Houston wedding photography, Houston Portait Photography">
   <meta name="SUMMARY" content="Houston wedding photography, Houston wedding photographer">
   <meta name="keywords" content="Houston wedding photographer, Houston wedding photography, Houston portraits, Special Event, portraits, weddings, photography, photographers, photographer, photos, studio, graduation portraits, professional, Houston, Texas, TX">
   <meta name="NAME" content="Photography by Design - Houston Wedding Photography - Professional wedding and portrait photography">
   <Meta Name="revisit-after" Content="30 days">
   <META NAME="ROBOTS" CONTENT="INDEX,FOLLOW">
   <META NAME="Author" CONTENT="Caffeine Web Design">
   <meta http-equiv="Content-Language" content="en-us">
   <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
   <script language="JavaScript" type="text/javascript" src="script.js"></script>
   <link href="styles.css" rel="stylesheet" type="text/css"/>
</head>
<body bgcolor="#555555" onLoad="preloadImages(<?php
   foreach($photos as $value)
   {
      echo("'" . $value . "', ");
   }
?>'images/pbyd_f2.png','images/pbyd_f3.png','images/home_f2.png','images/home_f3.png','images/about_us_f2.png','images/about_us_f3.png','images/head_r5_c10_f2.png','images/head_r5_c10_f3.png','images/events_f2.png','images/events_f3.png','images/head_r7_c2_f2.png','images/head_r7_c2_f3.png','images/portfolio_f2.png','images/portfolio_f3.png','images/head_r7_c13_f2.png','images/head_r7_c13_f3.png','images/links_f2.png','images/links_f3.png','images/contact_f2.png','images/contact_f3.png');">
   <div class="body">
      <table>
        <tr>
         <td><img src="images/spacer.gif" width="55" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="74" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="7" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="72" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="40" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="145" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="157" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="2" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="73" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="6" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="74" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="50" height="1" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
        </tr>
        <tr>
         <td colspan="14"><img name="head_r1_c1" src="images/head_r1_c1.png" width="757" height="23" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="1" height="23" border="0" alt=""></td>
        </tr>
        <tr>
         <td colspan="7"><img name="head_r2_c1" src="images/head_r2_c1.png" width="250" height="12" border="0" alt=""></td>
         <td rowspan="7"><a href="index.php" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','pbyd','images/pbyd_f2.png','images/pbyd_f3.png',1);" onClick="nbGroup('down','navbar1','pbyd','images/pbyd_f3.png',1);"><img name="pbyd" src="images/pbyd.png" width="145" height="100" border="0" alt=""></a></td>
         <td rowspan="2" colspan="6"><img name="head_r2_c9" src="images/head_r2_c9.png" width="362" height="13" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="1" height="12" border="0" alt=""></td>
        </tr>
        <tr>
         <td rowspan="2" colspan="2"><img name="head_r3_c1" src="images/head_r3_c1.png" width="129" height="31" border="0" alt=""></td>
         <td rowspan="2" colspan="3"><a href="index.php" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','home','images/home_f2.png','images/home_f3.png',1);" onClick="nbGroup('down','navbar1','home','images/home_f3.png',1);"><img name="home" src="images/home.png" width="80" height="31" border="0" alt="home"></a></td>
         <td rowspan="4" colspan="2"><img name="head_r3_c6" src="images/head_r3_c6.png" width="41" height="61" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
        </tr>
        <tr>
         <td rowspan="8"><img name="head_r4_c9" src="images/head_r4_c9.png" width="157" height="105" border="0" alt=""></td>
         <td colspan="3"><a href="about.php" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','about_us','images/about_us_f2.png','images/about_us_f3.png','head_r5_c10','images/head_r5_c10_f2.png','images/head_r5_c10_f3.png',1);" onClick="nbGroup('down','navbar1','about_us','images/about_us_f3.png','head_r5_c10','images/head_r5_c10_f3.png',1);"><img name="about_us" src="images/about_us.png" width="81" height="30" border="0" alt="about us"></a></td>
         <td colspan="2"><img name="head_r4_c13" src="images/head_r4_c13.png" width="124" height="30" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="1" height="30" border="0" alt=""></td>
        </tr>
        <tr>
         <td rowspan="7"><img name="head_r5_c1" src="images/head_r5_c1.png" width="55" height="75" border="0" alt=""></td>
         <td rowspan="2" colspan="3"><a href="http://www.studiologin.com/pbyd" target="_blank" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','events','images/events_f2.png','images/events_f3.png','head_r7_c2','images/head_r7_c2_f2.png','images/head_r7_c2_f3.png',1);" onClick="nbGroup('down','navbar1','events','images/events_f3.png','head_r7_c2','images/head_r7_c2_f3.png',1);"><img name="events" src="images/events.png" width="82" height="30" border="0" alt="events"></a></td>
         <td rowspan="2"><img name="head_r5_c5" src="images/head_r5_c5.png" width="72" height="30" border="0" alt=""></td>
         <td colspan="2"><a href="about.php" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','images/about_us','images/about_us_f2.png','images/about_us_f3.png','head_r5_c10','images/head_r5_c10_f2.png','images/head_r5_c10_f3.png',1);" onClick="nbGroup('down','navbar1','about_us','images/about_us_f3.png','head_r5_c10','images/head_r5_c10_f3.png',1);"><img name="head_r5_c10" src="images/head_r5_c10.png" width="75" height="1" border="0" alt="about us"></a></td>
         <td rowspan="2" colspan="2"><a href="portfolio.php" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','portfolio','images/portfolio_f2.png','images/portfolio_f3.png','head_r7_c13','images/head_r7_c13_f2.png','images/head_r7_c13_f3.png',1);" onClick="nbGroup('down','navbar1','portfolio','images/portfolio_f3.png','head_r7_c13','images/head_r7_c13_f3.png',1);"><img name="portfolio" src="images/portfolio.png" width="80" height="30" border="0" alt="portfolio"></a></td>
         <td rowspan="7"><img name="head_r5_c14" src="images/head_r5_c14.png" width="50" height="75" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
        </tr>
        <tr>
         <td colspan="2"><img name="head_r6_c10" src="images/head_r6_c10.png" width="75" height="29" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="1" height="29" border="0" alt=""></td>
        </tr>
        <tr>
         <td colspan="2"><a href="http://www.studiologin.com/pbyd" target="_blank" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','events','images/events_f2.png','images/events_f3.png','images/head_r7_c2','images/head_r7_c2_f2.png','images/head_r7_c2_f3.png',1);" onClick="nbGroup('down','navbar1','events','events_f3.png','images/head_r7_c2','images/head_r7_c2_f3.png',1);"><img name="head_r7_c2" src="images/head_r7_c2.png" width="75" height="1" border="0" alt="events"></a></td>
         <td rowspan="3" colspan="3"><a href="links.php" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','links','images/links_f2.png','images/links_f3.png',1);" onClick="nbGroup('down','navbar1','links','links_f3.png',1);"><img name="links" src="images/links.png" width="80" height="31" border="0" alt="links"></a></td>
         <td rowspan="5"><img name="head_r7_c7" src="images/head_r7_c7.png" width="40" height="45" border="0" alt=""></td>
         <td rowspan="5"><img name="head_r7_c10" src="images/head_r7_c10.png" width="2" height="45" border="0" alt=""></td>
         <td rowspan="4" colspan="2"><a href="contact.php" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','contact','images/contact_f2.png','images/contact_f3.png',1);" onClick="nbGroup('down','navbar1','contact','images/contact_f3.png',1);"><img name="contact" src="images/contact.png" width="79" height="32" border="0" alt="contact us"></a></td>
         <td><a href="portfolio.php" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','images/portfolio','images/portfolio_f2.png','images/portfolio_f3.png','images/head_r7_c13','images/head_r7_c13_f2.png','images/head_r7_c13_f3.png',1);" onClick="nbGroup('down','navbar1','images/portfolio','images/portfolio_f3.png','images/head_r7_c13','images/head_r7_c13_f3.png',1);"><img name="head_r7_c13" src="images/head_r7_c13.png" width="74" height="1" border="0" alt="portfolio"></a></td>
         <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
        </tr>
        <tr>
         <td rowspan="4" colspan="2"><img name="head_r8_c2" src="images/head_r8_c2.png" width="75" height="44" border="0" alt=""></td>
         <td rowspan="4"><img name="head_r8_c13" src="images/head_r8_c13.png" width="74" height="44" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="1" height="26" border="0" alt=""></td>
        </tr>
        <tr>
         <td rowspan="3"><img name="head_r9_c8" src="images/head_r9_c8.png" width="145" height="18" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="1" height="4" border="0" alt=""></td>
        </tr>
        <tr>
         <td rowspan="2" colspan="3"><img name="head_r10_c4" src="images/head_r10_c4.png" width="80" height="14" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
        </tr>
        <tr>
         <td colspan="2"><img name="head_r11_c11" src="images/head_r11_c11.png" width="79" height="13" border="0" alt=""></td>
         <td><img src="images/spacer.gif" width="1" height="13" border="0" alt=""></td>
        </tr>
        <tr>
         <td colspan="14" style="height: 363px; width: 100%; border: 0px solid orange;">
            <!--
               THE BODY OF THE PAGE GOES HERE.
            <div class="body">
            -->
            
      <?php
      if(empty($_GET["group"]))
      {
         ?>
         <div class="photo_collage">
            <img src="images/collage.gif">
         </div>
         <?php
      }
      else
      {
         $group = $_GET["group"];
         $dir = "images/$group/";
         if (is_dir($dir)) {
            echo("<div class=\"photo_main\"><img name=\"bigpic\" style=\"big\" src=\"" . $photos[0] . "\"></div>\n");
            echo("<div class=\"photo_album\">\n");
            if ($dh = opendir($dir)) {
                while (($file = readdir($dh)) !== false) {
                  if(strpos($file, ".jpg"))
                     echo("<img class=\"mini\" src=\"create_thumbnail.php?group=$group&pict=$file\" onmouseover=\"document.bigpic.src='" . $dir . "/" . $file . "'\">\n");
                }
                closedir($dh);
            }
            echo("</div>");
         }
         else
         {
            ?>
            <div class="photo_collage">
               <img src="images/collage.gif">
            </div>
            <?php
         }
      }
      ?>
            <!--
            </div>
               END THE BODY OF THE PAGE GOES HERE.
            -->
         </td>
        </tr>
      </table>
   </div>
</body>
</html>
