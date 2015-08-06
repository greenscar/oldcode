<html>
<head>
   <title>Durham and Bates - Portland, OR - <?php echo($title);?></title>
   <meta name="robots" content="noindex">
   <META NAME="classification" CONTENT="insurance">
   <meta http-equiv="Content-Language" content="en-us">
   <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
   <style type="text/css">@import "template_public.css";</style>
   <script language="JavaScript" type="text/javascript" src="script.js"></script>
</head>
<body>
   <table align="center" width=750px height=552px style="border: 1px solid #000000; border-spacing: 0px;border-collapse: collapse; padding: 0px;margin:0px auto;">
      <tr>
         <td colspan="2" align="right" valign="middle" height="30px">
            <div class="topBar" style="background-color: #<?php echo($bgcolor); ?>;">            
               <form method="GET" action="http://www.dbates.com/cgi-bin/htsearch">
                  <input type="text" name="words" class="searchText"></input>
                  <input type="submit" name="Search" value="Search Site" class="searchButton" onMouseOver="this.style.backgroundColor='#003366'"; onMouseOut="this.style.backgroundColor='#006390'">
                  <input type="hidden" name="config" value="htdig">
                  <input type="hidden" name="restrict" value="">
                  <input type="hidden" name="exclude" value="">
               </form>
            </div>
         </td>
      </tr>
      <tr>
         <?php include("menu_left.inc");?>
         <td width="500px" style="background-color:#FFF9EC;padding: 0px; vertical-align: top;">
            <table class="title">
               <tr>
                  <td>
                     <img class="title" src="./public_images/<?php echo($image); ?>" alt="<?php echo($title);?>" >
                  </td>
                  <td style="padding: 0 0 2px 10px;" align="center">
                     <?php
                     if(strcmp("Marine Insurance", $title) == 0)
                     {
                        echo("<img style=\"margin-top: -5px;\" src=\"./public_images/marine_logo.gif\"><br>");
                     }
                     ?>
                     <font class="pageTitle"><?php echo(strtoupper($title));?></font>
                  </td>
               </tr>
            </table>
            <br><br>