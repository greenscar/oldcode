<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/inc_files/php_fxns.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/client/ensure_client.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
$log = new Secretary();
if(!empty($_POST["ClientName"]))
{
     //HANDLE FORM
   //$receiver = "info@dbates.com";
	$toName = "Information";
	$toAddress = "james@caffeinewebdesign.com";
	$recipient = $toName." <".$toAddress.">";   
	$subject = $_SESSION["user"]->name . " => " . $_POST["formName"];
   echo("<html><header>");
   if(email($recipient, $_POST["ClientEmail"], $subject, view_array($_POST))){
      echo("<script language = \"javascript\" type=\"text/javascript\">");
      echo("alert(\"Thank you. Your " . $_POST["formName"] . " has been sent to $recipient\\nYou may now be asked if you would like this window closed. SELECT YES\");");
      echo("window.close();");
      echo("</script>");
      echo("</header><body></body></html>");
   }
   else{
      echo("</header><body>");
      echo("<h3 color=red>There was an error in your transmission. Please click your back arrow and try again.</h3>");
      echo("</body></html>");
   }
}
else
{
   require_once("../classes/Custom_Page.inc");
   
   $cp = new Custom_Page();
   $cp->client = $client;
   $cp->dbLoad($dbmgr);
   header("Cache-control: private");//IE 6 Fix
   ?>
   <html>
   <head>
      <title><?php echo($cp->client->name); ?></title>
      <script language="JavaScript" type="text/javascript" src="../form_check.js"></script>
      <script language="JavaScript" type="text/javascript">
      </script>
      <style type="text/css">@import "../template_client.css";</style>
   </head>
      <body>
         <h1 align="center"><?php echo($cp->client->name); ?></h1>
         <h2 align="center">REQUEST A MOTOR VEHICLE REPORT</h2>
         <form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" >
         <input type="hidden" name="formName" value="REQUEST A MOTOR VEHICLE REPORT">
         <!--<table class="body" border="1">-->
         <table class="mod_screen" style="height: 600px">
            <tr>
               <td>
                  <!---------------------------------
                   THIS INFORMATION IS THE BODY FORM
                  ---------------------------------->
                  <table id="PageTable">
                     <tr> 
                        <td colspan="5" class="darkBlackSmall" style="text-align: left"><h3>Contact Information</h3></td>
                     </tr>
                     <tr> 
                        <td width="150pt" class="darkBlackSmall">Your Business</td>
                        <td colspan="4">
                           <input type="text" name="ClientName" required="1" value="<?php echo($_SESSION["user"]->name); ?>"></input> 
                        </td>
                     </tr>
                     <tr> 
                        <td class="darkBlackSmall" style="text-align: left" >Your Name</td>
                        <td align="left" colspan="4">
                           <input type="text" name="ContactName" required="1" value="<?php echo($_SESSION["user"]->contact); ?>"></input> 
                        </td>
                     </tr>
                     <tr> 
                        <td class="darkBlackSmall" style="text-align: left">Your E-mail Address</td>
                        <td align="left" colspan="4">
                           <input type="text" name="ClientEmail" required="1" value="<?php echo($_SESSION["user"]->email); ?>"></input> 
                        </td>
                     </tr>
                     <tr> 
                        <td class="darkBlackSmall" style="text-align: left">Your Phone Number</td>
                        <td align="left" colspan="4">
                           <input type="text" name="ContactPhone" required="1" value="<?php echo($_SESSION["user"]->phone); ?>"></input> 
                        </td>
                     </tr>
                     <tr id="section"> 
                        <td class="darkBlackSmall" style="text-align: left" colspan="3">
                           <h3>Handling Instructions</h3>
                        </td>
                     </tr>
                     <tr> 
                        <td class="darkBlackSmall" style="text-align: left"><h3>Urgency</h3></td>
                        <td colspan="2" class="darkBlackSmall" style="text-align: left" >
                           Urgent: <input type="radio" class="radio"  name="CertSendUrgency" value="Urgent" checked="1"></input> 
                           Not Urgent: <input type="radio" class="radio"  name="CertSendUrgency" value="Not Urgent"></input> 
                        </td>
                     </tr>
                     <tr>
                        <td class="darkBlackSmall"><h3>Drivers</h3></td>
                        <td>
                        <table id="PageTable" cellspacing="0" cellpadding="0" border="0">
                           <tr>
                              <td colspan="5" id="section">Drivers</td>
                           </tr>
                           <tr>
                              <th width=100px;>Driver Name</th>
                              <th width=100px;>Date of Birth<br/>mm-dd-yyyy</th>
                              <th width=50px;>License<br/>Number</th>
                              <th width=50px;>Issuing<br/>State</th>
                              <th width=50px><small>Currently<br/>Employed?</small></th>
                           </tr>
                           <?php
                           for($i=0; $i<5; $i++)
                           {
                              ?>
                           <tr>
                              <td align="center">
                                 <input type="text" style="width:200px;" name="MVRDriver<? echo($i);?>"/>
                              </td>
                              <td align="center">
                                 <input type="text" style="width:20px;" name="MVRDOBMonth<? echo($i);?>"></input>
                                 -<input type="text" style="width:20px;" name="MVRDOBDay1" size="2" maxlength="2" required="1" checked="1"></input>
                                 -<input type="text" style="width:20px;" name="MVRDOBYear1" size="4" maxlength="4" required="1" onBlur="Y2K(this.value)" checked="1"></input>
                              </td>
                              <td align="center">
                                 <input type="text" style="width:100px;" name="MVRLicense<? echo($i);?>"></input>
                              </td>
                              <td align="center">
                                 <input type="text" style="width:30px;" name="MVRState<? echo($i);?>"></input>
                              </td>
                              <td align="center">
                                 <input type="checkbox" style="width:20px;" value="1" name="MVREmployed<? echo($i);?>"/>
                              </td>
                           </tr>
                           <?php
                           }
                           ?>
                        </table>
                        </td>
                     </tr>
                  </table>
                  <!---------------------------------
                   END THIS INFORMATION IS THE BODY FORM
                  ---------------------------------->
                  
               </td>
            </tr>
            <tr>
               <td colspan="3" align="center">
                  <input onclick="location.href='../client/custom_page.php'" class="submitButton" type="button" name="cancel" value="Cancel" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                  <input type="submit" class="submitButton" name="update" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               </td>
            </tr>
         </table>
         </form>
      </body>
<?php
}
?>