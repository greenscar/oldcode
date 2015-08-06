<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/inc_files/php_fxns.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/client/ensure_client.inc");
if(!empty($_POST["ClientName"]))
{
    //HANDLE FORM
   //$receiver = "info@dbates.com";
	$toName = "Information";
	$toAddress = "james@caffeinewebdesign.com";
	$recipient = $toName." <".$toAddress.">";   
	$subject = $_SESSION["user"]->name . " => " . $_POST["formName"];
	$body="
	<table id=\"PageTable\">
                     <tr> 
                        <td colspan=\"5\" style=\"text-align: left\"><h3>Contact Information</h3></td>
                     </tr>
                     <tr> 
                        <td width=\"150pt\">Your Business</td>
                        <td colspan=\"4\">
                           <input type=\"text\" name=\"ClientName\" required=\"1\" value=\"" . $_POST["ClientName"] . "\"></input> 
                        </td>
                     </tr>
                     <tr> 
                        <td style=\"text-align: left\" >Your Name</td>
                        <td align=\"left\" colspan=\"4\">
                           <input type=\"text\" name=\"ContactName\" required=\"1\" value=\"" . $_POST["ContactName"] . "\"></input> 
                        </td>
                     </tr>
                     <tr> 
                        <td style=\"text-align: left\">Your E-mail Address</td>
                        <td align=\"left\" colspan=\"4\">
                           <input type=\"text\" name=\"ClientEmail\" required=\"1\" value=\"" . $_POST["ClientEmail"] . "\"></input> 
                        </td>
                     </tr>
                     <tr> 
                        <td style=\"text-align: left\">Your Phone Number</td>
                        <td align=\"left\" colspan=\"4\">
                           <input type=\"text\" name=\"ContactPhone\" required=\"1\" value=\"" . $_POST["ContactPhone"] . "\"></input> 
                        </td>
                     </tr>
                     <tr id=\"section\"> 
                        <td style=\"text-align: left\" colspan=\"3\">
                           <h3>Handling Instructions</h3>
                        </td>
                     </tr>
                     <tr> 
                        <td style=\"text-align: left\" >Urgency</td>
                        <td colspan=\"2\" style=\"text-align: left\" >
                           <input type=\"radio\" class=\"radio\"  name=\"CertSendUrgency\" value=\"Mail\"";
                           if(strcmp($_POST["CertSendUrgency"], "Mail") == 0)
                              $body .= " checked";
                           $body .= "></input> 
                           Mail
                           <input type=\"radio\" class=\"radio\"  name=\"CertSendUrgency\" value=\"Fax\"";
                           if(strcmp($_POST["CertSendUrgency"], "Fax") == 0)
                              $body .= " checked";
                           $body .= "></input> 
                           Fax: <input type=\"text\" name=\"CertFaxNumber\" size=\"15\"";
			   if(isset($_POST["CertFaxNumber"]))
				$body.= " value=\"" . $_POST["CertFaxNumber"] . "\"";
			   $body .= "/> 
                        </td>
                     </tr>
                     <tr> 
                        <td style=\"text-align: left\"  valign=\"top\">Mail Original to</td>
                        <td colspan=\"2\" style=\"text-align: left\" >
                           <input type=\"radio\" class=\"radio\" name=\"CertOriginalTo\" value=\"Insured\"";
			   if(strcmp($_POST["CertOriginalTo"], "Insured") == 0)
			   {
				$body .= " checked";
			   }
			   $body .= "></input>
                           Your business<br/>
                           <input type=\"radio\" class=\"radio\"  name=\"CertOriginalTo\" value=\"CertificateHolder\"";
			   if(strcmp($_POST["CertOriginalTo"], "CertificateHolder") == 0)
			   {
				$body .= " checked";
			   }
			   $body .= "></input>
                           Certificate Holder<br/>
                           <input type=\"radio\" class=\"radio\"  name=\"CertOriginalTo\" value=\"Other\"";
			   if(strcmp($_POST["CertOriginalTo"], "Other") == 0)
			   {
				$body .= " checked";
			   }
			   $body .= "></input>
                           Other:<br/>
                           <input type=\"text\" name=\"CertOriginalToOther1\" size=\"40\"";
			   if(isset($_POST["CertOriginalToOther1"]))
			   {
				$body.= " value=\"" . $_POST["CertOriginalToOther1"] . "\"";
			   }
			   $body .= "/><br/> 
                           <input type=\"text\" name=\"CertOriginalToOther2\" size=\"40\"";
			   if(isset($_POST["CertOriginalToOther2"]))
			   {
				$body.= " value=\"" . $_POST["CertOriginalToOther2"] . "\"";
			   }
			   $body .= "/><br/> 
                           <input type=\"text\" name=\"CertOriginalToOther3\" size=\"40\"";
			   if(isset($_POST["CertOriginalToOther3"]))
			   {
				$body.= " value=\"" . $_POST["CertOriginalToOther3"] . "\"";
			   }
			   $body .= "/><br/> 
                           <input type=\"text\" name=\"CertOriginalToOther4\" size=\"40\"";
			   if(isset($_POST["CertOriginalToOther4"]))
			   {
				$body.= " value=\"" . $_POST["CertOriginalToOther4"] . "\"";
			   }
			   $body .= "/>
                        </td>
                        </td>
                     </tr>
                     <tr id=\"section\"> 
                        <td colspan=\"3\" style=\"text-align: left\" >
                           <b>For what types of coverage do you need to provide proof?</b>
                        </td>
                     </tr>
                     <tr> 
                        <td valign=\"top\" width=\"50%\" style=\"text-align: left\" >
                           <input type=\"checkbox\" class=\"radio\" name=\"CertTypeLiability\" value=\"Liability\"" ;
                           if(isset($_POST["CertTypeLiability"]))
                              $body .= " checked";
                           $body .= "/>
                           Liability<br/>
                           <input type=\"checkbox\" class=\"radio\" name=\"CertTypeProperty\" value=\"Property\"" ;
                           if(isset($_POST["CertTypeProperty"]))
                              $body .= " checked";
                           $body .= "/>
                           Property:<br/>
                           <input type=\"checkbox\" class=\"radio\" name=\"CertTypePropertyBuilding\" value=\"PropertyBuilding\"" ;
                           if(isset($_POST["CertTypePropertyBuilding"]))
                              $body .= " checked";
                           $body .= "/>
                           Building<br/>
                           <input type=\"checkbox\" class=\"radio\" name=\"CertTypePropertyInventory\" value=\"PropertyInventory\"" ;
                           if(isset($_POST["CertTypePropertyInventory"]))
                              $body .= " checked";
                          $body .= "/>
                           Inventory<br/>
                           <input type=\"checkbox\" class=\"radio\" name=\"CertTypeAuto\" value=\"Auto\"" ;
                           if(isset($_POST["CertTypeAuto"]))
                              $body .= " checked";
                           $body .= "/>
                           Auto<br/>
                           <input type=\"checkbox\" class=\"radio\" name=\"CertTypeAutoLeased\" value=\"AutoLeased\"" ;
                           if(isset($_POST["CertTypeAutoLeased"]))
                              $body .= " checked";
                           $body .= "/>
                           Leased/Rented<br/>
                        </td>
                        <td colspan=\"2\" valign=\"top\" style=\"text-align: left\" >
                           <input type=\"checkbox\" class=\"radio\" name=\"CertTypeMortgageeLossPayee\" value=\"MortgageeLossPayee\"" ;
                           if(isset($_POST["CertTypeMortgageeLossPayee"]))
                              $body .= " checked";
                           $body .= "/>
                           Mortgagee / Loss Payee<br/>
                           <input type=\"checkbox\" class=\"radio\" name=\"CertTypeEquipment\" value=\"Equipment\"" ;
                           if(isset($_POST["CertTypeEquipment"]))
                              $body .= " checked";
                           $body .= "/>
                           Equipment<br/>
                           <input type=\"checkbox\" class=\"radio\" name=\"CertTypeEquipmentLeased\" value=\"EquipmentLeased\"" ;
                           if(isset($_POST["CertTypeEquipmentLeased"]))
                              $body .= " checked";
                           $body .= "/>
                           Leased/Rented<br/>
                           <input type=\"checkbox\" class=\"radio\" name=\"CertTypeUmbrella\" value=\"Umbrella\"" ;
                           if(isset($_POST["CertTypeUmbrella"]))
                              $body .= " checked";
                           $body .= "/>
                           Umbrella<br/>
                           <input type=\"checkbox\" class=\"radio\" name=\"CertTypeUSLH\" value=\"USLH\"" ;
                           if(isset($_POST["CertTypeUSLH"]))
                              $body .= " checked";
                           $body .= "/>
                           USL&amp;H<br/>
                           <input type=\"checkbox\" class=\"radio\" name=\"CertTypeWorkersComp\" value=\"WorkersComp\"" ;
                           if(isset($_POST["CertTypeWorkersComp"]))
                              $body .= " checked";
                           $body .= "/>
                           Workers' Compensation<br/>
                        </td>
                     </tr>
                     <tr id=\"section\"> 
                        <td colspan=\"3\" style=\"text-align: left\" >
                           <b>Who is the Certificate Holder for this coverage?</b>
                        </td>
                     </tr>
                     <tr> 
                        <td colspan=\"1\" style=\"text-align: left\" >
                           <input type=\"text\" name=\"CertHolder1\" size=\"40\" required=\"1\"" ;
                           if(isset($_POST["CertHolder1"]))
                              $body .= "value=\"" . $_POST["CertHolder1"] . "\"";
                           $body .= "/>
                           <br/> <input type=\"text\" name=\"CertHolder2\" size=\"40\"" ;
                           if(isset($_POST["CertHolder2"]))
                              $body .= "value=\"" . $_POST["CertHolder2"] . "\"";
                           $body .= "/>
                           <br/> <input type=\"text\" name=\"CertHolder3\" size=\"40\"" ;
                           if(isset($_POST["CertHolder3"]))
                              $body .= "value=\"" . $_POST["CertHolder3"] . "\"";
                           $body .= "/>
                           <br/> <input type=\"text\" name=\"CertHolder4\" size=\"40\"" ;
                           if(isset($_POST["CertHolder4"]))
                              $body .= "value=\"" . $_POST["CertHolder4"] . "\"";
                           $body .= "/>
                           <br/> <input type=\"text\" name=\"CertHolder5\" size=\"40\"" ;
                           if(isset($_POST["CertHolder5"]))
                              $body .= "value=\"" . $_POST["CertHolder5"] . "\"";
                           $body .= "/>
                        </td>
                        <td valign=\"top\" colspan=\"2\" style=\"text-align: left\" >
                           <input type=\"checkbox\" class=\"radio\" name=\"CertAddlInsured\" value=\"Yes\"";
                           if(isset($_POST["CertAddlInsured"]))
                              $body .= " checked";
                           $body .= "/>
                           Additional Insured?<br/>
                           <input type=\"checkbox\" class=\"radio\" name=\"CertLandlord\" value=\"Yes\"";
                           if(isset($_POST["CertLandlord"]))
                              $body .= " checked";
                           $body .= "/>
                           Landlord?
                        </td>
                     </tr>
                     <tr id=\"section\"> 
                        <td style=\"text-align: left\"  colspan=\"3\">
                           <b>Information about the covered items</b>
                        </td>
                     </tr>
                     <tr> 
                        <td style=\"text-align: left\" >Location or description of covered items</td>
                        <td colspan=\"2\" style=\"text-align: left\" >
                           <textarea name=\"CertLocation\" cols=\"40\" rows=\"2\" wrap=\"virtual\" required=\"1\">";
                           if(!empty($_POST["CertLocation"]))
                              $body .= $_POST["CertLocation"];
                           $body .= "</textarea> 
                        </td>
                     </tr>
                     <tr> 
                        <td style=\"text-align: left\" >Job Name or Loan Number</td>
                        <td colspan=\"2\" style=\"text-align: left\" >
                           <input type=\"text\" name=\"CertID\" size=\"40\"";
                           if(!empty($_POST["CertID"]))
                              $body .= "value=\"" . $_POST["CertID"] . "\""; 
                           $body .= "/>
                        </td>
                     </tr>
                     <tr> 
                        <td style=\"text-align: left\" >Include Following Certificate Requirements</td>
                        <td colspan=\"2\" style=\"text-align: left\" >
                           <textarea name=\"CertWording\" cols=\"40\" rows=\"2\" wrap=\"virtual\">";
                           if(!empty($_POST["CertWording"]))
                              $body .= $_POST["CertWording"];
                           $body .= "</textarea> 
                        </td>
                     </tr>
                  </table>
	";
   echo("<html><header>");
   if(email($_POST["ClientEmail"], $subject, $body)){
      echo("<script language = \"javascript\" type=\"text/javascript\">");
      echo("alert(\"Thank you. Your " . $_POST["formName"] . " has been sent to $recipient\\nYou may now be asked if you would like this window closed. SELECT YES\");");
      //echo("window.close();");
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
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Custom_Page.inc");
   
   $cp = new Custom_Page();
   $cp->client = $client;
   $cp->dbLoad($dbmgr);
   header("Cache-control: private");//IE 6 Fix
   ?>
   <html>
   <head>
      <title><?php echo($client->name); ?></title>
      <script language="JavaScript" type="text/javascript" src="../form_check.js"></script>
      <script language="JavaScript" type="text/javascript">
      </script>
      <style type="text/css">@import "../template_client.css";</style>
   </head>
      <body>
         <h1 align="center"><?php echo($cp->client->name); ?></h1>
         <h2 align="center">REQUEST A CERTIFICATE OF INSURANCE</h2>
         <form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" >
         <!--<table class="body" border="1">-->
         <table class="form" style="height: 600px">
            <tr>
               <td>
                  <!---------------------------------
                   THIS INFORMATION IS THE BODY FORM
                  ---------------------------------->
                  <input type="hidden" name="formName" value="REQUEST A CERTIFICATE OF INSURANCE">
                  <table id="PageTable">
                     <tr> 
                        <td colspan="5" style="text-align: left"><h3>Contact Information</h3></td>
                     </tr>
                     <tr> 
                        <td width="150pt">Your Business</td>
                        <td colspan="4">
                           <input type="text" name="ClientName" required="1" value="<?php echo($_SESSION["user"]->name); ?>"></input> 
                        </td>
                     </tr>
                     <tr> 
                        <td style="text-align: left" >Your Name</td>
                        <td align="left" colspan="4">
                           <input type="text" name="ContactName" required="1" value="<?php echo($_SESSION["user"]->contact); ?>"></input> 
                        </td>
                     </tr>
                     <tr> 
                        <td style="text-align: left">Your E-mail Address</td>
                        <td align="left" colspan="4">
                           <input type="text" name="ClientEmail" required="1" value="<?php echo($_SESSION["user"]->email); ?>"></input> 
                        </td>
                     </tr>
                     <tr> 
                        <td style="text-align: left">Your Phone Number</td>
                        <td align="left" colspan="4">
                           <input type="text" name="ContactPhone" required="1" value="<?php echo($_SESSION["user"]->phone); ?>"></input> 
                        </td>
                     </tr>
                     <tr id="section"> 
                        <td style="text-align: left" colspan="3">
                           <h3>Handling Instructions</h3>
                        </td>
                     </tr>
                     <tr> 
                        <td style="text-align: left" >Urgency</td>
                        <td colspan="2" style="text-align: left" >
                           <input type="radio" class="radio"  name="CertSendUrgency" value="Mail" checked="1"></input> 
                           Mail <input type="radio" class="radio"  name="CertSendUrgency" value="Fax"></input> 
                           Fax: <input type="text" name="CertFaxNumber" size="15" checked="1"/> 
                        </td>
                     </tr>
                     <tr> 
                        <td style="text-align: left"  valign="top">Mail Original to</td>
                        <td colspan="2" style="text-align: left" >
                           <input type="radio" class="radio" name="CertOriginalTo" value="Insured" checked="1"></input>
                           Your business<br/>
                           <input type="radio" class="radio"  name="CertOriginalTo" value="CertificateHolder"></input>
                           Certificate Holder<br/>
                           <input type="radio" class="radio"  name="CertOriginalTo" value="Other"></input>
                           Other:<br/>
                           <input type="text" name="CertOriginalToOther1" size="40" checked="1"/><br/> 
                           <input type="text" name="CertOriginalToOther2" size="40" checked="1"/><br/> 
                           <input type="text" name="CertOriginalToOther3" size="40" checked="1"/><br/> 
                           <input type="text" name="CertOriginalToOther4" size="40" checked="1"/>
                        </td>
                     </tr>
                     <tr id="section"> 
                        <td colspan="3" style="text-align: left" >
                           <b>For what types of coverage do you need to provide proof?</b>
                        </td>
                     </tr>
                     <tr> 
                        <td valign="top" width="50%" style="text-align: left" >
                           <input type="checkbox" class="radio" name="CertTypeLiability" value="Liability"/>
                           Liability<br/>
                           <input type="checkbox" class="radio" name="CertTypeProperty" value="Property"/>
                           Property:<br/>
                           <input type="checkbox" class="radio" name="CertTypePropertyBuilding" value="PropertyBuilding"/>
                           Building<br/>
                           <input type="checkbox" class="radio" name="CertTypePropertyInventory" value="PropertyInventory"/>
                           Inventory<br/>
                           <input type="checkbox" class="radio" name="CertTypeAuto" value="Auto"/>
                           Auto<br/>
                           <input type="checkbox" class="radio" name="CertTypeAutoLeased" value="AutoLeased"/>
                           Leased/Rented<br/>
                        </td>
                        <td colspan="2" valign="top" style="text-align: left" >
                           <input type="checkbox" class="radio" name="CertTypeMortgageeLossPayee" value="MortgageeLossPayee"/>
                           Mortgagee / Loss Payee<br/>
                           <input type="checkbox" class="radio" name="CertTypeEquipment" value="Equipment"/>
                           Equipment<br/>
                           <input type="checkbox" class="radio" name="CertTypeEquipmentLeased" value="EquipmentLeased"/>
                           Leased/Rented<br/>
                           <input type="checkbox" class="radio" name="CertTypeUmbrella" value="Umbrella"/>
                           Umbrella<br/>
                           <input type="checkbox" class="radio" name="CertTypeUSLH" value="USLH"/>
                           USL&amp;H<br/>
                           <input type="checkbox" class="radio" name="CertTypeWorkersComp" value="WorkersComp"/>
                           Workers' Compensation<br/>
                        </td>
                     </tr>
                     <tr id="section"> 
                        <td colspan="3" style="text-align: left" >
                           <b>Who is the Certificate Holder for this coverage?</b>
                        </td>
                     </tr>
                     <tr> 
                        <td colspan="1" style="text-align: left" >
                           <input type="text" name="CertHolder1" size="40" required="1" checked="1"/>
                           <br/> <input type="text" name="CertHolder2" size="40" checked="1"/>
                           <br/> <input type="text" name="CertHolder3" size="40" checked="1"/>
                           <br/> <input type="text" name="CertHolder4" size="40" checked="1"/>
                           <br/> <input type="text" name="CertHolder5" size="40" checked="1"/>
                        </td>
                        <td valign="top" colspan="2" style="text-align: left" >
                           <input type="checkbox" class="radio" name="CertAddlInsured" value="Yes"/>
                           Additional Insured?<br/>
                           <input type="checkbox" class="radio" name="CertLandlord" value="Yes"/>
                           Landlord?
                        </td>
                     </tr>
                     <tr id="section"> 
                        <td style="text-align: left"  colspan="3">
                           <b>Information about the covered items</b>
                        </td>
                     </tr>
                     <tr> 
                        <td style="text-align: left" >Location or description of covered items</td>
                        <td colspan="2" style="text-align: left" >
                           <textarea name="CertLocation" cols="20" rows="2" wrap="virtual" required="1"></textarea> 
                        </td>
                     </tr>
                     <tr> 
                        <td style="text-align: left" >Job Name or Loan Number</td>
                        <td colspan="2" style="text-align: left" >
                           <input type="text" name="CertID" size="10" checked="1"/>
                        </td>
                     </tr>
                     <tr> 
                        <td style="text-align: left" >Include Following Certificate Requirements</td>
                        <td colspan="2" style="text-align: left" >
                           <textarea name="CertWording" cols="10" rows="2" wrap="virtual"></textarea> 
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