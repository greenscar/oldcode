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
<script language="JavaScript">
<!--
function findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}
function nbGroup(event, grpName) { //v6.0
var i,img,nbArr,args=nbGroup.arguments;
  if (event == "init" && args.length > 2) {
    if ((img = findObj(args[2])) != null && !img.init) {
      img.init = true; img.up = args[3]; img.dn = img.src;
      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      nbArr[nbArr.length] = img;
      for (i=4; i < args.length-1; i+=2) if ((img = findObj(args[i])) != null) {
        if (!img.up) img.up = img.src;
        img.src = img.dn = args[i+1];
        nbArr[nbArr.length] = img;
    } }
  } else if (event == "over") {
    document.nbOver = nbArr = new Array();
    for (i=1; i < args.length-1; i+=3) if ((img = findObj(args[i])) != null) {
      if (!img.up) img.up = img.src;
      img.src = (img.dn && args[i+2]) ? args[i+2] : ((args[i+1])?args[i+1] : img.up);
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    for (i=0; i < document.nbOver.length; i++) { img = document.nbOver[i]; img.src = (img.dn) ? img.dn : img.up; }
  } else if (event == "down") {
    nbArr = document[grpName];
    if (nbArr) for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.up; img.dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = findObj(args[i])) != null) {
      if (!img.up) img.up = img.src;
      img.src = img.dn = (args[i+1])? args[i+1] : img.up;
      nbArr[nbArr.length] = img;
  } }
}

function preloadImages() { //v3.0
 var d=document; if(d.images){ if(!d.p) d.p=new Array();
   var i,j=d.p.length,a=preloadImages.arguments; for(i=0; i<a.length; i++)
   if (a[i].indexOf("#")!=0){ d.p[j]=new Image; d.p[j++].src=a[i];}}
}

//-->
</script>
<?php include("style.inc");?>
</head>
<body bgcolor="#ffffff" onLoad="preloadImages(<?php
   foreach($photos as $value)
   {
      echo("'" . $value . "', ");
   }
?>'images/contact_r2_c6_f2.jpg','images/contact_r2_c6_f3.jpg','images/home_f2.jpg','images/home_f3.jpg','images/about_f2.jpg','images/about_f3.jpg','images/portfolio_f2.jpg','images/portfolio_f3.jpg','images/contact_f2.jpg','images/contact_f3.jpg');">
   <div class="body">
      <div name="subMenuGallery" id="subMenuGallery" class="mmSubMenu" style="" onMouseOver="showLayer('subMenuGallery'); ">
         <span class="mmSubMenuCell"><a href="portfolio.php?group=wedding" class="mmSubMenuCell">Weddings</a></span>
         <span class="mmSubMenuCell"><a href="portfolio.php?group=portrait" class="mmSubMenuCell">Portraits</a></span>
         <span class="mmSubMenuCell"><a href="portfolio.php?group=bride" class="mmSubMenuCell">Brides</a></span><br>
         <span class="mmSubMenuCell"><a href="portfolio.php?group=senior" class="mmSubMenuCell">Seniors</a></span>
         <span class="mmSubMenuCell"><a href="portfolio.php?group=children" class="mmSubMenuCell">Children</a></span>
         <span class="mmSubMenuCell"><a href="portfolio.php?group=military" class="mmSubMenuCell">Military</a></span>
      </div>
      <div class="body_main">
         <table border="0" cellpadding="0" cellspacing="0">
         <!-- fwtable fwsrc="photosimple.png" fwbase="contact.jpg" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
           <tr><td><img src="images/spacer.gif" width="36" height="1" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="78" height="1" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="23" height="1" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="77" height="1" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="40" height="1" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="144" height="1" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="147" height="1" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="77" height="1" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="24" height="1" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="77" height="1" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="34" height="1" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td></tr>
           <tr><td colspan="11"><img name="contact_r1_c1" src="images/contact_r1_c1.jpg" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="1" height="16" border="0" alt=""></td></tr>
           <tr>
            <td colspan="5"><img name="contact_r2_c1" src="images/contact_r2_c1.jpg" border="0" alt=""></td>
            <td rowspan="4"><a href="index.php" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','contact_r2_c6','images/contact_r2_c6_f2.jpg','images/contact_r2_c6_f3.jpg',1);" onClick="nbGroup('down','navbar1','contact_r2_c6','images/contact_r2_c6_f3.jpg',1);"><img name="contact_r2_c6" src="images/contact_r2_c6.jpg" border="0" alt="Portfollio Photography By Design"></a></td>
            <td colspan="5"><img name="contact_r2_c7" src="images/contact_r2_c7.jpg" width="359" height="39" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="1" height="39" border="0" alt=""></td></tr>
           <tr><td rowspan="4"><img name="contact_r3_c1" src="images/contact_r3_c1.jpg"  alt=""></td>
            <td rowspan="2"><a href="index.php" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','home','images/home_f2.jpg','images/home_f3.jpg',1);" onClick="nbGroup('down','navbar1','home','images/home_f3.jpg',1);"><img name="home" src="images/home.jpg" width="78" height="29" border="0" alt="Portfolio Photography By Design"></a></td>
            <td rowspan="4"><img name="contact_r3_c3" src="images/contact_r3_c3.jpg" border="0" alt=""></td>
            <td><a href="about.php" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','about','images/about_f2.jpg','images/about_f3.jpg',1);" onClick="nbGroup('down','navbar1','about','images/about_f3.jpg',1);"><img name="about" src="images/about.jpg" width="77" height="28" border="0" alt="About Photography By Design"></a></td>
            <td rowspan="4"><img name="contact_r3_c5" src="images/contact_r3_c5.jpg" border="0" alt=""></td>
            <td rowspan="4"><img name="contact_r3_c7" src="images/contact_r3_c7.jpg" border="0" alt=""></td>
            <td><a href="portfolio.php" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','portfolio','images/portfolio_f2.jpg','images/portfolio_f3.jpg',1);" onClick="nbGroup('down','navbar1','portfolio','images/portfolio_f3.jpg',1);">
            <img name="portfolio" src="images/portfolio.jpg" width="77" height="28" border="0" alt="Portfollio Photography By Design"></a></td>
            <td rowspan="4"><img name="contact_r3_c9" src="images/contact_r3_c9.jpg" border="0" alt=""></td><td>
            <a href="contact.php" onMouseOut="nbGroup('out');" onMouseOver="nbGroup('over','contact','images/contact_f2.jpg','images/contact_f3.jpg',1);" onClick="nbGroup('down','navbar1','contact','images/contact_f3.jpg',1);">
            <img name="contact" src="images/contact.jpg" width="77" height="28" border="0" alt="Contact Photography By Design"></a></td>
            <td rowspan="4"><img name="contact_r3_c11" src="images/contact_r3_c11.jpg" width="34" height="445" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="1" height="28" border="0" alt=""></td></tr>
           <tr><td rowspan="3"><img name="contact_r4_c4" src="images/contact_r4_c4.jpg" border="0" alt=""></td>
            <td rowspan="3"><img name="contact_r4_c8" src="images/contact_r4_c8.jpg" border="0" alt=""></td>
            <td rowspan="3"><img name="contact_r4_c10" src="images/contact_r4_c10.jpg" border="0" alt=""></td>
            <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td></tr>
           <tr><td rowspan="2"><img name="contact_r5_c2" src="images/contact_r5_c2.jpg" width="78" height="416" border="0" alt=""></td><td><img src="images/spacer.gif" width="1" height="31" border="0" alt=""></td></tr>
           <tr><td><img name="contact_r6_c6" src="images/contact_r6_c6.jpg" border="0" alt=""></td><td><img src="images/spacer.gif" width="1" height="385" border="0" alt=""></td></tr>
         </table>
      </div>
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
   </div>
</body>
</html>
