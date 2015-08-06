<?php
require_once("ensure_client.inc");
//require_once("../classes/Batch_File_Custom_Page.inc");
require_once("../classes/BFCP.inc");

$bfcp = new BFCP();
$bfcp->client = $client;
$bfcp->dbLoad($dbmgr);
?>
<html>
<head>
   <title><?php echo($client->name); ?></title>
   <style type="text/css">@import "../template_client.css";</style>
   <script language="Javascript" type="text/javascript">
      function showHideAnswer(id)  
      {
      var elem = eval(document.getElementById(id));
       var elm = document.getElementById(id)
       elm.style.display == "inline"? elm.style.display = "none" : elm.style.display = "inline";
      }
   </script>
</head>
<body>
<form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>">
<input type="hidden" name="cid" value="<?php echo($bfcp->client->id); ?>">
<table class="mod_screen">
   <tr>
      <th colspan="2" class="menu">
         Download Page for <?php echo(htmlspecialchars($bfcp->client->name)); ?>
      </th>
   </tr>
   <?php
      $rowNum = 0;
      foreach($bfcp->files AS $key=>$the_file)
      {
         $rowNum++;
         if($rowNum % 2 == 1){ echo("<tr>\n\t\t");}
         ?>
         <td align="center">
            <?php
               echo("<img src=\"../" . $bfcp->getImageDir() . "/" . $the_file->file_name . "\">");
            ?>
            <br>
            <h3><?php echo(htmlspecialchars($the_file->title)); ?></h3>
         </td>
         <?
         if($rowNum % 2 == 0){ echo("</tr>\n\t\t");}
      }
   ?>
   <tr>
      <td colspan="2">&nbsp</td>
   </tr>
   <tr>
      <td colspan="2" align="center">
      <?php if($client->hasCPage($dbmgr)){ ?>
         <input type="button" class="submitButton" name="Menu"   value="Menu"   onClick="location.href='index.php'"  onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
      <?php } ?>
         <input type="button" class="submitButton" name="logout" value="Logout" onclick="location.href='logout.php'" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
      </td>
   </tr>
   </table>
   </form>
</body>
</html>
