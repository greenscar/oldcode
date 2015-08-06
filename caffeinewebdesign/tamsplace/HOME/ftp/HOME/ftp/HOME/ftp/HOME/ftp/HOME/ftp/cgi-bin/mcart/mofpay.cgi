#!/usr/bin/perl
use CGI::Carp qw(fatalsToBrowser);
# MOFcart ver 2.4 : 6-30-01
# ======================================================================== #
#           MERCHANT ORDERFORMcart ver 2.4 (PKG: June 30, 2001)            #
#           All Rights Reserverd  © 2000-2001 rga@merchantpal.com          #
#           http://www.merchantorderform.com/copyright.html                #
# ======================================================================== #
#           Contact: Russell Alexander & Austin Contract Computing         #
#           Email:   rga@merchantpal.com, rga@merchantorderform.com        #
#           Phone:   512.447.1124                                          #
#           Web:     http://www.merchantpal.com                            #
#           Web:     http://www.merchantorderform.com                      #
# ======================================================================== #
# These programs are distributed as Trial Ware or Share Ware.              #
# You are Welcome to install and test all portions of the programs.        #
# The package is not limited in any way and code source is left readable.  #
# If you continue operating it on a web site then please make arrangements #
# for the fee at:                                                          #
#        PAYMENT: http://www.merchantorderform.com/payment.html            #
#                                                                          #
# ======================================================================== #
# COPYRIGHT NOTICE:                                                        #
# http://www.merchantorderform.com/copyright.html                          #
# The contents of this file is protected under the United States           #
# copyright laws as an unpublished work, and is confidential and           #
# proprietary to Austin Contract Computing, Inc. Its use or disclosure     #
# in whole or in part without the expressed written permission of Austin   #
# Contract Computing, Inc. is prohibited. Any distribution of this file    #
# whatsoever, without the appropriate registered license, or owner consent #
# is strictly prohibited.                                                  #
# ======================================================================== #
# SECURITY NOTICE:                                                         #
# By installing these programs on your server or computer you hereby agree #
# to read and understand the document: SecurityIssues.html in the MOFcart  #
# packaged documentation. A secure installation is the sole responsibility #
# of the installer. Russell Alexander or Austin Contract Computing are not #
# responsible for insuring that your installation is secure                #
# ======================================================================== #
# THIS SOFTWARE IS PROVIDED BY THE VENDOR `AS IS' AND ANY EXPRESSED OR     #
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED           #
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE   #
# DISCLAIMED. IN NO EVENT SHALL THE VENDOR OR ITS CONTRIBUTORS BE LIABLE   #
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR             #
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF     #
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS #
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN  #
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)  #
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF   #
# THE POSSIBILITY OF SUCH DAMAGE.                                          #
# ======================================================================== #

# THIS IS THE PAYMENT PROCESSING PROGRAM
# DO NOT CHANGE ANY OF THESE SETTINGS
# ===================================
require 5.001;
require 'mofpay.conf';
require 'mofpaylib.pl';
# Disabled any of these PlugIns in <mofpay.conf>
require $save_invoice_file if ($save_invoice_html);
require $mail_merchant_file if ($mail_merchant_invoice);
require $mail_customer_file if ($mail_customer_receipt);
require $save_ascii_file if ($save_ascii_data);
require $save_mysql_file if ($save_mysql_data);
# cookie names must be the same in both program files
$cookiename_OrderID = 'mof_v24_OrderID';
$cookiename_InfoID = 'mof_v24_InfoID';

# PROGRAM FLOW
# PaymentInformation
# PaymentAccepted

&SetDateVariable;
&RunTestMode if ($ERRORMODE==0 && $ENV{'QUERY_STRING'} =~ /^test/i);
&CheckAllowedDomains if (scalar(@ALLOWED_DOMAINS));
&ProcessPost;

if (scalar(keys(%MissingInfoFields))) {
	@header = ();
	@footer = ();
	@state_list = ();
	@country_list = ();
	@country_list_bill = (&GetDropBoxList($use_country_list,'Ecom_BillTo_Postal_CountryCode')) if ($use_country_list);
	@country_list_receipt = (&GetDropBoxList($use_country_list,'Ecom_ReceiptTo_Postal_CountryCode')) if ($use_country_list);
	@state_list_bill = (&GetDropBoxList($use_state_list,'Ecom_BillTo_Postal_StateProv')) if ($use_state_list);
	@state_list_receipt = (&GetDropBoxList($use_state_list,'Ecom_ReceiptTo_Postal_StateProv')) if ($use_state_list);
	&GetTemplateFile($payment_info_template,"Payment Information File","payment_info_template");
	&PaymentInformation;
} else {
	# cod flat charge adjustment
	if ($frm{'input_payment_options'} eq "COD") {
	$frm{'Final_Amount'} = ( $frm{'Final_Amount'} + $cod_charges );
	$frm{'Final_Amount'} = sprintf "%.2f", $frm{'Final_Amount'};
      	$cod_charges = sprintf "%.2f", $cod_charges;
	$cod_charges = CommifyMoney ($cod_charges);
	}

	# adjustment for deposit, and find Payment Amount to display/send
	if ($frm{'Deposit_Amount'} > 0 ) {
	$frm{'Format_Deposit_Amount'} = sprintf "%.2f", $frm{'Deposit_Amount'};
	$frm{'Format_Deposit_Amount'} = CommifyMoney($frm{'Format_Deposit_Amount'});
	$frm{'Remaining_Balance'} = ($frm{'Final_Amount'} - $frm{'Deposit_Amount'});
	$frm{'Overpaid_Surplus'}++ if ($frm{'Remaining_Balance'} < 0 );
	$frm{'Remaining_Balance'} = sprintf "%.2f", $frm{'Remaining_Balance'};
	$frm{'Remaining_Balance'} = CommifyMoney($frm{'Remaining_Balance'});
	$Display_Payment_Amount = $frm{'Format_Deposit_Amount'};
	$Send_API_Amount = sprintf "%.2f", $frm{'Deposit_Amount'};
	} else {
	$Display_Payment_Amount = CommifyMoney($frm{'Final_Amount'});
	$Send_API_Amount = $frm{'Final_Amount'};
	}

	# API here - sending $Send_API_Amount (formatted 000000.00)
	# Note: The $Send_API_Amount is always Final Amount for anything
	# Note: in <PaymentAccepted><mofinvoice.pl><customer.mail><merchant.mail>

	if ($delete_cart_final) {&DeleteCartFile($frm{'OrderID'})}
	else {&ExpireCookie($cookiename_OrderID)}	

	&GetInvoiceNumber;
	@header = ();
	@footer = ();
	if ($save_invoice_html) {
	&GetTemplateFile($save_invoice_template,"Save Invoice Template File","save_invoice_template");
	&SaveInvoiceFile;
	}
		
	# what customer mail to use
	$mail_customer_addr = "";
	if ($frm{'Ecom_ReceiptTo_Online_Email'}) {
	$mail_customer_addr = $frm{'Ecom_ReceiptTo_Online_Email'};
	} elsif ($frm{'Ecom_BillTo_Online_Email'}) {
	$mail_customer_addr = $frm{'Ecom_BillTo_Online_Email'};
	} elsif ($frm{'Ecom_ShipTo_Online_Email'}) {
	$mail_customer_addr = $frm{'Ecom_ShipTo_Online_Email'};
	}

	# Append to the affiliate tracking log
	# Enable this only if you are using the Referral system
	# or if you know what you are doing to set up custom logging
	# Set the condition for whatever you want logged	
	# Caution: do not set a condition like Customer Discount > 0
	# If you are using ARES and have Customer Discount set to zero
	# Because it will then not log the credit due to Affiliates / Reps
	# Note: the RepRate is not found until Final Logging
	# So you cannot set a condition involving RepRates		
	# VERY IMPORTANT: If you enable it this way you MUST have a valid
	# default Coupon Number Assigned in <mof.conf>
	# &LogAffiliateActivity($frm{'Compute_Coupons'}) if ($frm{'Compute_Coupons'});	
	
	@header = ();
	@footer = ();
	&GetTemplateFile($final_template,"Payment Final Template File","final_template");
	&SaveASCIIdB if ($save_ascii_data);
	&SaveSQLdB if ($save_mysql_data);
	&PaymentAccepted;
	&MailCustomerReceipt if ($mail_customer_receipt && $mail_customer_addr);

	if ($mail_merchant_invoice){
	if (scalar(@mail_merchant_addr)) {
	foreach(@mail_merchant_addr){&MailMerchantInvoice($_)}
	} else {
	# this is only for backward compatibility to configs
	&MailMerchantInvoice($mail_merchant_addr) if ($mail_merchant_addr);
	}}}
	# End Program Flow

# ======================================================================== #
#            HOW TO ADD NEW FIELDS TO THE BILLING INFO PAGE                #
# ======================================================================== #
# 1. ADD FIELD(S) (mofpay.cgi)                                             #
#    * Add the field to the printed HTML this section (PaymentInformation) #
# 2. ADD FIELD(S) TO MASTER FIELDS LIST (mofpaylib.pl)                     #
#    * Add Field(s) to [CheckFieldsNeeded] sub routine                     #
#    * push to UsingInfoFields array, a list of all possible field(s)      #
# 3. ADD ANY VALIDATION NEEDED  (mofpaylib.pl)                             #
#    * If required, validate new Field(s) in [CheckUsingInfoFields]        #
#    * which validates and flags in MissingInfoFields array if             #
#    * there is anything "Missing" or "Incomplete"                         #
# 4. ADD DISPLAY FLAGS (if desired)  (mofpaylib.pl)                        #
#    * Use a similar sub routine as [ValidateBillingInfo] to set up proper #
#    * display flag (Missing/Incomplete) on BillingInformation page        #
# NOTE: If BillingInformation page reloads, because validation failed      #
#    * we can only prefill a text box.  We cannot Find the already         #
#    * selected value of a drop box, list box, radio button, checkbox      #
#    * unless you write a routine for matching the returning input         #
# 5. ADJUST POST ARRAY FOR RELOAD (mofpay.cgi)                             #
#    * See the notes/area appx: LINE 1065                                  #
#    * Validation will not prefill unless you delete from reload array     #
# 6. SET NEW FIELD(S) TO PRINT WHERE NEEDED                                #
#    * To print at [PaymentAccepted] use $frm{'NewField'}                  #
#    * Use $frm{'NewField'} to print in <mofpay.cgi>                       #
#    * <invoice.pl><merchant.mail><customer.mail>                          #
# ======================================================================== #

# PAYMENT INFO
sub PaymentInformation {
	$msg_v;
	$itm_n = 0;
	$itm_m = 0;
	$allow_methods = 0;
	my ($new_value);
	my ($key, $val);
	my ($single_option);
	($depmin, $deppct, $display_deposit) = (0,0,0);
	$itm_m = scalar(keys(%MissingInfoFields));
	if ($itm_m == 1) {$fld = "Field"}
	else {$fld = "Fields"}
	$submit_total = CommifyMoney($frm{'Final_Amount'});
	$allow_methods++ if ($enable_paypal);
	$allow_methods++ if ($mail_or_fax_field);
	$allow_methods++ if ($enable_cod);
	$allow_methods++ if ($enable_onaccount);
	$allow_methods++ if ($call_for_cc_info);
	$allow_methods++ if ($use_gateway_forms);
	$allow_methods++ if (scalar(keys(%checking_account_fields)));
	$allow_methods++ if (scalar(keys(%credit_card_fields)));
	$depmin = $deposit_minimum if ($deposit_minimum > 0);
	$deppct = ($deposit_percent * $frm{'Final_Amount'}) if ($deposit_percent > 0);
 	$depmin = $deppct if ($deppct > $depmin);
	$depmin = sprintf "%.2f", $depmin if ($depmin > 0);
	$display_deposit++ if ($enable_deposit && $frm{'Final_Amount'} > $depmin);
	$tmpmin = CommifyMoney($depmin);

	print "Content-Type: text/html\n\n";
	print "@header \n\n";
	# Insert MOF navigation at TOP
	$nav_top++ if ($menu_home_top);
	$nav_top++ if ($menu_previous_top);
	$nav_top++ if ($menu_viewcart_top);
	$nav_top++ if ($menu_payment_top);
	$nav_top++ if ($menu_help_top);

	if ($nav_top && $includeBillingInfo) {
	print "<table border=0 cellpadding=0 cellspacing=0><tr>\n";
	if ($menu_home_top) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"$menu_home_top_url\">$menu_home_top</a></td>\n";}
	if ($menu_previous_top) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"$frm{'previouspage'}\">$menu_previous_top</a></td>\n";}
	if ($menu_viewcart_top) {
	print "<td nowrap>";
	print "<a Class=\"TopNavLink\" href=\"$programfile?viewcart&previouspage=$frm{'previouspage'}\">";
	print "$menu_viewcart_top</a></td>\n";}
	if ($menu_payment_top) {
	print "<td nowrap><a Class=\"TopNavNextLink\" href=\"javascript:document.formCheckout.submit()\;\">$menu_payment_top</a></td>\n";}
	if ($menu_help_top) {
	print "<td nowrap>\n";
	print "<a Class=\"TopNavLink\" href=\"$menu_help_top_url\" onclick=\"window.open(this.href,4,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">\n";
	print "$menu_help_top</a></td>\n";}
	print "</tr></table><br>\n";
	}

	# top message
	print "Enter billing information below, <br>then click the ";
	print "<strong>place order</strong> button to process payment";
	print "." if ($display_deposit);
	print " of <strong> $currency $submit_total</strong>." unless ($display_deposit);
	print "<p>";
	if ($frm{'resubmit_info'}) {
	if ($itm_m > 1) {
	print "<SPAN Class=\"ValidationMessageText\">";
	print "You have $itm_m $fld Missing or Incomplete. Check the prompts on this page ";
	print "for missing or incomplete information. ";
	if ($MissingInfoFields{'Ecom_BillTo_Online_Email'} eq "Incomplete" || $MissingInfoFields{'Ecom_ReceiptTo_Online_Email'} eq "Incomplete") {
	print "<font color=red>Check eMail for accuracy.";
	}
	print "<p></SPAN>\n";
	} elsif ($itm_m == 1) {
	print "<SPAN Class=\"ValidationMessageText\">";
		if (exists($MissingInfoFields{'input_cyber_permission'})) {
		print "Your Final Approval is needed to continue processing this order. \n";
		print "Check <strong>Yes</strong> at the bottom of this form to continue, or abort by ";
		print "leaving this form without checking Yes. \n";
		} else {
		print "You have $itm_m $fld Missing or Incomplete. Check the prompts on this page for ";
		print "missing or incomplete information. \n";
		if ($MissingInfoFields{'Ecom_BillTo_Online_Email'} eq "Incomplete" || $MissingInfoFields{'Ecom_ReceiptTo_Online_Email'} eq "Incomplete") {
		print "<font color=red>Check eMail for accuracy.";
		}
		}
		print "<p></SPAN>\n";
	}}
	
	# Re POST Hidden to payment file
	# All hidden INPUT occurs after populating form
	print "\n\n";
	print "<FORM name=\"formCheckout\" method=POST action=\"$paymentfile\">\n";

	# Enable deposit amount
	# this condition takes care of zero based invoices
	# as well as invoices under the minimum deposit amt
	if ($display_deposit) {
	$itm_n++;
	$box_heading = "Deposit or Layaway Options:";
	$box_message = "Enter deposit amount below. ";
	$box_message = $box_message . "Leave box blank to pay full amount of <strong> $currency $submit_total</strong>. ";
	if ($depmin > 0) {$box_message = $box_message . "Minimum deposit required is <b>$currency $tmpmin</b>"}
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5% nowrap><font size=3><strong>$itm_n.</strong></font></td> \n";
	print "<td  width=95%>$final_heading \n";
	print "<strong>$box_heading</strong>";
	print "</font></td></tr> \n";
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%>$final_text \n";
	print "$box_message ";
	if ($MissingInfoFields{'Deposit_Amount'} eq "MinimumNeeded") {
	print "<SPAN Class=\"ValidationMessageText\">";
	print "<p>Your deposit amount must be at least the minimum.</SPAN> ";
	} elsif ($MissingInfoFields{'Deposit_Amount'}) {
	print "<SPAN Class=\"ValidationMessageText\">";
	print "<p>Enter only numbers for deposit amount. Not allowed: <b>$MissingInfoFields{'Deposit_Amount'}</b></SPAN>";
	}
	print "</font></td></tr>\n";
	print "<tr><td colspan=2><font size=1><br></font></td></tr></table> \n";
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5%><br></td>  \n";
	print "<td> \n\n";

	print "<table border=0 cellpadding=2 cellspacing=0 bgcolor=$font_outside_line><tr><td> \n";
	print "<table border=0 cellpadding=2 cellspacing=0> \n";
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Deposit Amount:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Deposit_Amount\" value=\"$frm{'Deposit_Amount'}\" size=12></td>";

		if ($MissingInfoFields{'Deposit_Amount'}) {
		print "<td bgcolor=$info_message_bg nowrap>$info_incomplete </td></tr> \n";
		} else {
		print "<td bgcolor=$info_message_bg nowrap><br></td></tr> \n";
		}

	print "</table>";
	print "</td></tr></table> \n";
	print "</td></tr>";
	print "<tr><td colspan=2><font size=1><br></font></td></tr>";
	print "</table> \n";
	}

	# zero based invoive bypass
	if ($zb_no_method && $frm{'Final_Amount'} == 0) {
	$itm_n++;
	$box_heading = "No charges for this invoice";
	$box_message = "No charges are associated with this invoice.  No payment is needed. ";
	$box_message = $box_message . "Please proceed with Checkout to complete your request.";
	print "<input type=hidden name=\"input_payment_options\" value=\"ZEROPAY\"> \n\n";
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5% nowrap><font size=3><strong>$itm_n.</strong></font></td> \n";
	print "<td  width=95%>$final_heading \n";
	print "<strong>$box_heading</strong>";
	print "</font></td></tr> \n";
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%>$final_text \n";
	print "$box_message </font></td></tr>";
	print "<tr><td colspan=2><font size=1><br></font></td></tr>";
	print "</table>\n";

	# Method of Payment
	} elsif ($allow_methods) {
	$itm_n++;
	$box_heading = "Payment Options:";
	$box_message = "Select payment method and complete any corresponding information.";
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5% nowrap><font size=3><strong>$itm_n.</strong></font></td> \n";
	print "<td  width=95%>$final_heading \n";
	print "<strong>$box_heading</strong>";
	print "</font></td></tr> \n";
	unless (scalar(keys(%payment_options_list)) == 1 ) {
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%>$final_text \n";
	print "$box_message </font></td></tr>\n";
	}

	# Any CC verify message
	if ($frm{'Ecom_Payment_Card_Number'}) {	
		if ($msg_cc || $cc_type_error) {
		print "<tr><td colspan=2><font size=1><br></font></td></tr> \n";
		print "<tr><td width=5%><br></td> \n";
		print "<td width=95%>$final_text \n";
			print "<SPAN Class=\"ValidationMessageText\">";
			print "$msg_cc" if ($msg_cc);
			if ($cc_type_error) {
			print "Check the Card Type selected for accuracy. ";
			print "The card number is a $cc_type_error number. ";
			}
		print "</SPAN></font></td></tr> \n";
		}
	}

	# Any cc Date message
	if ($frm{'Ecom_Payment_Card_ExpDate_Month'} && $frm{'Ecom_Payment_Card_ExpDate_Year'}) {	
		if ($ccDateErr) {
		print "<tr><td colspan=2><font size=1><br></font></td></tr> \n";
		print "<tr><td width=5%><br></td> \n";
		print "<td width=95%>$final_text \n";
		print "<SPAN Class=\"ValidationMessageText\">$ccDateErr</SPAN></font></td></tr> \n";
		}
	}
	print "<tr><td colspan=2><font size=1><br></font></td></tr></table> \n";

	# Set up Payment Methods
	# There is only one single option
	if (scalar(keys(%payment_options_list)) == 1 ) {
	while (($key, $val) = each (%payment_options_list)) {$single_option = $key}
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5%><br></td><td> \n";
	print "$final_text $payment_options_desc{$single_option} </font>";
	print "<input type=hidden name=\"input_payment_options\" value=\"$single_option\"> \n\n";
	print "</td></tr>";
	print "<tr><td colspan=2><font size=1><br></font></td></tr>";
	print "</table> \n";
	} elsif (scalar(keys(%payment_options_list)) > 1 ) {

	# build the drop box
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5%><br></td>  \n";
	print "<td> \n\n";
	print "<table border=0 cellpadding=2 cellspacing=0 bgcolor=$font_outside_line><tr><td> \n";
	print "<table border=0 cellpadding=2 cellspacing=0> \n";
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Payment Method:</font></td> \n";
	print "<td bgcolor=$font_right_column>$font_final_titles \n\n";

	# Populate a Drop Box
	print "<select Class=\"BillingBoxFormat\" name=\"input_payment_options\"> \n";
	if ($frm{'input_payment_options'}) {
		print "<option value=\"\">Please Select Here \n";
		print "<option value=\"\"> ------------------------------ \n";
		foreach $_ (@payment_options_order) {
		if ($_ eq $frm{'input_payment_options'}) {
		print "<option selected value=\"$_\">$payment_options_list{$_} \n";
		} else {
		print "<option value=\"$_\">$payment_options_list{$_} \n" if ($payment_options_list{$_});
		}}
	} else {
		print "<option selected value=\"\">Please Select Here \n";
		print "<option value=\"\"> ------------------------------ \n";
		foreach $_ (@payment_options_order) {
		print "<option value=\"$_\">$payment_options_list{$_} \n" if ($payment_options_list{$_});
		}
	}
	print "</select></td> \n\n";
	$msg_v = (&ValidateInputOptions('input_payment_options'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	print "</table>";
	print "</td></tr></table> \n";
	print "</td></tr>";
	print "<tr><td colspan=2><font size=1><br></font></td></tr>";
	print "</table> \n";
	}
	# End Payment Options Branch

	# Enable Credit Card Payment
	if (scalar(keys(%credit_card_fields))) {
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5%><br></td>  \n";
	print "<td> \n\n";
	print "<table border=0 cellpadding=2 cellspacing=0 bgcolor=$font_outside_line><tr><td> \n";
	print "<table border=0 cellpadding=2 cellspacing=0> \n";

	if (exists ($credit_card_fields{'Ecom_Payment_Card_Name'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Name on Card:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	if ($check_check) {$new_value = ""}	else {$new_value = $frm{'Ecom_Payment_Card_Name'}}
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_Payment_Card_Name\" value=\"$new_value\" size=30></td>";
	$msg_v = (&ValidateCreditCardInfo('Ecom_Payment_Card_Name'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($credit_card_fields{'Ecom_Payment_Card_Number'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Card Number:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	if ($check_check) {$new_value = ""}	else {$new_value = $frm{'Ecom_Payment_Card_Number'}}
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_Payment_Card_Number\" value=\"$new_value\" size=19></td>";
	$msg_v = (&ValidateCreditCardInfo('Ecom_Payment_Card_Number'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}
	
	if (exists ($credit_card_fields{'Ecom_Payment_Card_ExpDate_Month'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Expiration Month:</font></td> \n";
	print "<td bgcolor=$font_right_column>$font_final_titles \n";
	if ($check_check) {$new_value = ""}	else {$new_value = $frm{'Ecom_Payment_Card_ExpDate_Month'}}
	print "<select Class=\"BillingBoxFormat\" name=\"Ecom_Payment_Card_ExpDate_Month\"> \n";
		if ($new_value == 0) {print "<option selected value=\"\">Select Month \n";
		} else {print "<option value=\"\">Select Month \n";}
		print "<option value=\"\"> ------------------- \n";
		if ($new_value == 1) {print "<option selected value =\"1\">January \n";
		} else {print "<option value =\"1\">January \n";}
		if ($new_value == 2) {print "<option selected value =\"2\">February \n";
		} else {print "<option value =\"2\">February \n";}
		if ($new_value == 3) {print "<option selected value =\"3\">March \n";
		} else {print "<option value =\"3\">March \n";}
		if ($new_value == 4) {print "<option selected value =\"4\">April \n";
		} else {print "<option value =\"4\">April \n";}
		if ($new_value == 5) {print "<option selected value =\"5\">May \n";
		} else {print "<option value =\"5\">May \n";}
		if ($new_value == 6) {print "<option selected value =\"6\">June \n";
		} else {print "<option value =\"6\">June \n";}
		if ($new_value == 7) {print "<option selected value =\"7\">July \n";
		} else {print "<option value =\"7\">July \n";}
		if ($new_value == 8) {print "<option selected value =\"8\">August \n";
		} else {print "<option value =\"8\">August \n";}
		if ($new_value == 9) {print "<option selected value =\"9\">September \n";
		} else {print "<option value =\"9\">September \n";}
		if ($new_value == 10) {print "<option selected value =\"10\">October \n";
		} else {print "<option value =\"10\">October \n";}
		if ($new_value == 11) {print "<option selected value =\"11\">November \n";
		} else {print "<option value =\"11\">November \n";}
		if ($new_value == 12) {print "<option selected value =\"12\">December \n";
		} else {print "<option value =\"12\">December \n";}
	print "</select></td> \n\n";
	$msg_v = (&ValidateCreditCardInfo('Ecom_Payment_Card_ExpDate_Month'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($credit_card_fields{'Ecom_Payment_Card_ExpDate_Day'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Expiration Day:</font></td> \n";
	print "<td bgcolor=$font_right_column>$font_final_titles \n";
	if ($check_check) {$new_value = ""}	else {$new_value = $frm{'Ecom_Payment_Card_ExpDate_Day'}}
	print "<select Class=\"BillingBoxFormat\" name=\"Ecom_Payment_Card_ExpDate_Day\"> \n";
		$count_day = 1;
		if ($new_value == 0) {
		print "<option selected value=\"\">Select Day \n";
		} else {
		print "<option value=\"\">Select Day \n";
		}
		print "<option value=\"\"> ------------------- \n";
		while ($count_day < 32) {
			if ($new_value == $count_day) {
			print "<option selected value=\"$count_day\">$count_day \n";
			} else {
			print "<option value=\"$count_day\">$count_day \n";
			}
			$count_day++;
		}
	print "</select></td> \n\n";
	$msg_v = (&ValidateCreditCardInfo('Ecom_Payment_Card_ExpDate_Day'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($credit_card_fields{'Ecom_Payment_Card_ExpDate_Year'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Expiration Year:</font></td> \n";
	print "<td bgcolor=$font_right_column>$font_final_titles \n";
	if ($check_check) {$new_value = ""}	else {$new_value = $frm{'Ecom_Payment_Card_ExpDate_Year'}}
	$count_year = $pass_year;
	$stop_year = ($count_year + 21);
	print "<select Class=\"BillingBoxFormat\" name=\"Ecom_Payment_Card_ExpDate_Year\"> \n";
		if ($new_value == 0) {
		print "<option selected value=\"\">Select Year \n";
		} else {
		print "<option value=\"\">Select Year \n";
		}
		print "<option value=\"\"> ------------------- \n";
		while ($count_year < $stop_year) {
			if ($new_value == $count_year) {
			print "<option selected value=\"$count_year\">$count_year \n";
			} else {
			print "<option value=\"$count_year\">$count_year \n";
			}
			$count_year++;
		}
	print "</select></td> \n\n";
	$msg_v = (&ValidateCreditCardInfo('Ecom_Payment_Card_ExpDate_Year'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($credit_card_fields{'Ecom_Payment_Card_Verification'})) {
	if ($link_cvvcid) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles <br></font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<a Class=\"TextLink\" href=\"$link_cvvcid_url\" onclick=\"window.open(this.href,6,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">";
	print "$link_cvvcid</a></td>"}
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Card Verification:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	if ($check_check) {$new_value = ""}	else {$new_value = $frm{'Ecom_Payment_Card_Verification'}}
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_Payment_Card_Verification\" value=\"$new_value\" size=12> </td>";
	$msg_v = (&ValidateCreditCardInfo('Ecom_Payment_Card_Verification'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	print "</table>";
	print "</td></tr></table> \n";
	print "</td></tr>";
	print "<tr><td colspan=2><font size=1><br></font></td></tr>";
	print "</table> \n";
	}
	# End Enable Credit Card

	# Enable Checking Account Payment
	if (scalar(keys(%checking_account_fields))) {
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5%><br></td>  \n";
	print "<td> \n\n";
	print "<table border=0 cellpadding=2 cellspacing=0 bgcolor=$font_outside_line><tr><td> \n";
	print "<table border=0 cellpadding=2 cellspacing=0> \n";

	if ($link_check) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles<br></font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<a Class=\"TextLink\" href=\"$link_check_url\" onclick=\"window.open(this.href,10,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">";
	print "$link_check</a></td>";
	print "<td bgcolor=$info_message_bg nowrap><br></td></tr> \n";
	}

	if (exists ($checking_account_fields{'Check_Holder_Name'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Name on Account:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	if ($card_check) {$new_value = ""}	else {$new_value = $frm{'Check_Holder_Name'}}
	print "<input Class=\"BillingBoxFormat\" name=\"Check_Holder_Name\" value=\"$new_value\" size=30></td>";
	$msg_v = (&ValidateCheckingInfo('Check_Holder_Name'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($checking_account_fields{'Check_Number'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Check Number:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	if ($card_check) {$new_value = ""}	else {$new_value = $frm{'Check_Number'}}
	print "<input Class=\"BillingBoxFormat\" name=\"Check_Number\" value=\"$new_value\" size=30></td>";
	$msg_v = (&ValidateCheckingInfo('Check_Number'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($checking_account_fields{'Check_Account_Number'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Account Number:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	if ($card_check) {$new_value = ""}	else {$new_value = $frm{'Check_Account_Number'}}
	print "<input Class=\"BillingBoxFormat\" name=\"Check_Account_Number\" value=\"$new_value\" size=30></td>";
	$msg_v = (&ValidateCheckingInfo('Check_Account_Number'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($checking_account_fields{'Check_Routing_Number'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Routing Number:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	if ($card_check) {$new_value = ""}	else {$new_value = $frm{'Check_Routing_Number'}}
	print "<input Class=\"BillingBoxFormat\" name=\"Check_Routing_Number\" value=\"$new_value\" size=30></td>";
	$msg_v = (&ValidateCheckingInfo('Check_Routing_Number'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($checking_account_fields{'Check_Fraction_Number'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Fraction Number:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	if ($card_check) {$new_value = ""}	else {$new_value = $frm{'Check_Fraction_Number'}}
	print "<input Class=\"BillingBoxFormat\" name=\"Check_Fraction_Number\" value=\"$new_value\" size=30></td>";
	$msg_v = (&ValidateCheckingInfo('Check_Fraction_Number'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($checking_account_fields{'Check_Bank_Name'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Bank Name:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	if ($card_check) {$new_value = ""}	else {$new_value = $frm{'Check_Bank_Name'}}
	print "<input Class=\"BillingBoxFormat\" name=\"Check_Bank_Name\" value=\"$new_value\" size=30></td>";
	$msg_v = (&ValidateCheckingInfo('Check_Bank_Name'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($checking_account_fields{'Check_Bank_Address'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Bank Address:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	if ($card_check) {$new_value = ""}	else {$new_value = $frm{'Check_Bank_Address'}}
	print "<input Class=\"BillingBoxFormat\" name=\"Check_Bank_Address\" value=\"$new_value\" size=30></td>";
	$msg_v = (&ValidateCheckingInfo('Check_Bank_Address'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	print "</table>";
	print "</td></tr></table> \n";
	print "</td></tr>";
	print "<tr><td colspan=2><font size=1><br></font></td></tr>";
	print "</table> \n";
	}}
	# End Enable Checking Account
	# End Method of Payment

	# Bill to Information
	unless ($zb_no_billing && $frm{'Final_Amount'} == 0) {
	if (scalar(keys(%billing_info_fields))) {
	$itm_n++;
	$box_heading = "Enter Billing Information:";
	$box_message = "Complete this information as it appears on your credit card or account.";
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5% nowrap><font size=3><strong>$itm_n.</strong></font></td> \n";
	print "<td  width=95%>$final_heading \n";
	print "<strong>$box_heading</strong></font>";
	print "</td></tr> \n";
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%>$final_text \n";
	print "$box_message </font></td></tr>\n";
	print "<tr><td colspan=2><font size=1><br></font></td></tr> \n";

	if ($frm{'Allow_Shipping'}) {
		print "<tr><td width=5%><br></td> \n";
		print "<td width=95%>$font_final_titles \n";
		if ($frm{'input_shipping_info'} eq "YES") {
		print "<input Class=\"BillingCheckBoxFormat\" type=\"checkbox\" name=\"input_shipping_info\" checked=\"on\" value=\"YES\"> ";
		} else {
		print "<input Class=\"BillingCheckBoxFormat\" type=\"checkbox\" name=\"input_shipping_info\" value=\"YES\"> ";
		}
		print "<strong>shortcut</strong>: Check here if exactly same as shipping address </font></td></tr>\n";
		print "<tr><td colspan=2><font size=1><br></font></td></tr> \n";
	}
	print "</table> \n";
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5%><br></td>  \n";
	print "<td> \n\n";

	print "<table border=0 cellpadding=2 cellspacing=0 bgcolor=$font_outside_line><tr><td> \n";
	print "<table border=0 cellpadding=2 cellspacing=0> \n";

	if (exists ($billing_info_fields{'Ecom_BillTo_Postal_Name_Prefix'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Title:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_Name_Prefix\" value=\"$frm{'Ecom_BillTo_Postal_Name_Prefix'}\" size=4></td>";
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Postal_Name_Prefix'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Postal_Name_First'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles First Name:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_Name_First\" value=\"$frm{'Ecom_BillTo_Postal_Name_First'}\" size=36></td>";
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Postal_Name_First'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Postal_Name_Middle'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Middle Name:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_Name_Middle\" value=\"$frm{'Ecom_BillTo_Postal_Name_Middle'}\" size=36></td>";
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Postal_Name_Middle'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Postal_Name_Last'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Last Name:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_Name_Last\" value=\"$frm{'Ecom_BillTo_Postal_Name_Last'}\" size=36></td>";
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Postal_Name_Last'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Postal_Name_Suffix'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Last Name Suffix:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_Name_Suffix\" value=\"$frm{'Ecom_BillTo_Postal_Name_Suffix'}\" size=4></td>";
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Postal_Name_Suffix'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Postal_Company'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Company Name:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_Company\" value=\"$frm{'Ecom_BillTo_Postal_Company'}\" size=36></td>";
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Postal_Company'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Postal_Street_Line1'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Address:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_Street_Line1\" value=\"$frm{'Ecom_BillTo_Postal_Street_Line1'}\" size=36></td>";
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Postal_Street_Line1'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Postal_Street_Line2'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Address:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_Street_Line2\" value=\"$frm{'Ecom_BillTo_Postal_Street_Line2'}\" size=36></td>";
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Postal_Street_Line2'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Postal_City'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles City:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_City\" value=\"$frm{'Ecom_BillTo_Postal_City'}\" size=36></td>";
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Postal_City'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Postal_StateProv'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>";
	print "$font_final_titles State - Province:</font></td> \n";
	print "<td bgcolor=$font_right_column>$font_final_titles \n";

	# Does state field use Drop Box
	if ($use_state_list) {
	print "<select Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_StateProv\"> \n";
	foreach $itm_db (@state_list_bill) {print "$itm_db \n"}
	print "</select> \n";
	} else {
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_StateProv\" value=\"$frm{'Ecom_BillTo_Postal_StateProv'}\" size=30>";
	}
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Postal_StateProv'));
	print "</td><td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Postal_Region'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles * Region:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_Region\" value=\"$frm{'Ecom_BillTo_Postal_Region'}\" size=30></td>";
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Postal_Region'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Postal_PostalCode'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Postal Code:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_PostalCode\" value=\"$frm{'Ecom_BillTo_Postal_PostalCode'}\" size=30></td>";
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Postal_PostalCode'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Postal_CountryCode'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>";
	print "$font_final_titles Country:</font></td> \n";
	print "<td bgcolor=$font_right_column>$font_final_titles \n";

	# Does country field use Drop Box
	if ($use_country_list) {
	print "<select Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_CountryCode\"> \n";
	foreach $itm_db (@country_list_bill) {print "$itm_db \n"}
	print "</select> \n";
	} else {
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Postal_CountryCode\" value=\"$frm{'Ecom_BillTo_Postal_CountryCode'}\" size=30>";
	}
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Postal_CountryCode'));
	print "</td><td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Telecom_Phone_Number'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Phone Number:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Telecom_Phone_Number\" value=\"$frm{'Ecom_BillTo_Telecom_Phone_Number'}\" size=30></td>";
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Telecom_Phone_Number'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($billing_info_fields{'Ecom_BillTo_Online_Email'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles E-mail Address:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_BillTo_Online_Email\" value=\"$frm{'Ecom_BillTo_Online_Email'}\" size=36></td>";
	$msg_v = (&ValidateBillingInfo('Ecom_BillTo_Online_Email'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	print "</table>";
	print "</td></tr></table> \n";
	print "</td></tr>";

	if ($force_state_message) {
	if (exists($billing_info_fields{'Ecom_BillTo_Postal_Region'})) {
	print "<tr><td width=5% align=right valign=top>$font_preview_titles * </font></td> \n";
	print "<td width=95%>$font_preview_titles $force_state_message </font></td></tr>\n";
	}}

	print "<tr><td colspan=2><font size=1><br></font></td></tr>";
	print "</table> \n";
	}}
	# End Bill To Input Tables

	# Receipt to Information
	unless ($zb_no_receipt && $frm{'Final_Amount'} == 0) {
	if (scalar(keys(%receipt_info_fields))) {
	$itm_n++;
	$box_heading = "Whom To Send Receipt To ?";
	$box_message = "Send receipt here if different than billing location.  ";
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5% nowrap><font size=3><strong>$itm_n.</strong></font></td> \n";
	print "<td  width=95%>$final_heading \n";
	print "<strong>$box_heading</strong>";
	print "</font></td></tr> \n";
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%>$final_text \n";
	print "$box_message </font></td></tr>\n";
	print "<tr><td colspan=2><font size=1><br></font></td></tr></table> \n";
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5%><br></td>  \n";
	print "<td> \n\n";

	print "<table border=0 cellpadding=2 cellspacing=0 bgcolor=$font_outside_line><tr><td> \n";
	print "<table border=0 cellpadding=2 cellspacing=0> \n";

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Postal_Name_Prefix'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Title:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_Name_Prefix\" value=\"$frm{'Ecom_ReceiptTo_Postal_Name_Prefix'}\" size=4></td>";
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Postal_Name_Prefix'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Postal_Name_First'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles First Name:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_Name_First\" value=\"$frm{'Ecom_ReceiptTo_Postal_Name_First'}\" size=36></td>";
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Postal_Name_First'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Postal_Name_Middle'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Middle Name:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_Name_Middle\" value=\"$frm{'Ecom_ReceiptTo_Postal_Name_Middle'}\" size=36></td>";
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Postal_Name_Middle'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Postal_Name_Last'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Last Name:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_Name_Last\" value=\"$frm{'Ecom_ReceiptTo_Postal_Name_Last'}\" size=36></td>";
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Postal_Name_Last'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Postal_Name_Suffix'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Last Name Suffix:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_Name_Suffix\" value=\"$frm{'Ecom_ReceiptTo_Postal_Name_Suffix'}\" size=4></td>";
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Postal_Name_Suffix'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Postal_Company'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Company Name:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_Company\" value=\"$frm{'Ecom_ReceiptTo_Postal_Company'}\" size=36></td>";
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Postal_Company'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Postal_Street_Line1'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Address:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_Street_Line1\" value=\"$frm{'Ecom_ReceiptTo_Postal_Street_Line1'}\" size=36></td>";
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Postal_Street_Line1'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Postal_Street_Line2'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Address:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_Street_Line2\" value=\"$frm{'Ecom_ReceiptTo_Postal_Street_Line2'}\" size=36></td>";
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Postal_Street_Line2'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Postal_City'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles City:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_City\" value=\"$frm{'Ecom_ReceiptTo_Postal_City'}\" size=30></td>";
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Postal_City'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Postal_StateProv'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>";
	print "$font_final_titles State - Province:</font></td> \n";
	print "<td bgcolor=$font_right_column>$font_final_titles \n";

	# Does state field use Drop Box
	if ($use_state_list) {
	print "<select Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_StateProv\"> \n";
	foreach $itm_db (@state_list_receipt) {print "$itm_db \n"}
	print "</select> \n";
	} else {
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_StateProv\" value=\"$frm{'Ecom_ReceiptTo_Postal_StateProv'}\" size=30>";
	}
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Postal_StateProv'));
	print "</td><td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Postal_Region'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles * Region:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_Region\" value=\"$frm{'Ecom_ReceiptTo_Postal_Region'}\" size=30></td>";
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Postal_Region'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Postal_PostalCode'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Postal Code:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_PostalCode\" value=\"$frm{'Ecom_ReceiptTo_Postal_PostalCode'}\" size=30></td>";
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Postal_PostalCode'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Postal_CountryCode'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>";
	print "$font_final_titles Country:</font></td> \n";
	print "<td bgcolor=$font_right_column>$font_final_titles \n";

	# Does country field use Drop Box
	if ($use_country_list) {
	print "<select Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_CountryCode\"> \n";
	foreach $itm_db (@country_list_receipt) {print "$itm_db \n"}
	print "</select> \n";
	} else {
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Postal_CountryCode\" value=\"$frm{'Ecom_ReceiptTo_Postal_CountryCode'}\" size=30>";
	}
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Postal_CountryCode'));
	print "</td><td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Telecom_Phone_Number'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles Phone Number:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Telecom_Phone_Number\" value=\"$frm{'Ecom_ReceiptTo_Telecom_Phone_Number'}\" size=30></td>";
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Telecom_Phone_Number'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($receipt_info_fields{'Ecom_ReceiptTo_Online_Email'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_final_titles E-mail Address:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"BillingBoxFormat\" name=\"Ecom_ReceiptTo_Online_Email\" value=\"$frm{'Ecom_ReceiptTo_Online_Email'}\" size=36></td>";
	$msg_v = (&ValidateReceiptInfo('Ecom_ReceiptTo_Online_Email'));
	print "<td bgcolor=$info_message_bg nowrap>$msg_v </td></tr> \n";
	}

	print "</table>";
	print "</td></tr></table> \n";
	print "</td></tr>";

	if ($force_state_message) {
	if (exists($receipt_info_fields{'Ecom_ReceiptTo_Postal_Region'})) {
	print "<tr><td width=5% align=right valign=top>$font_preview_titles * </font></td> \n";
	print "<td width=95%>$font_preview_titles $force_state_message </font></td></tr>\n";
	}}

	print "<tr><td colspan=2><font size=1><br></td></tr>";
	print "</table> \n";
	}}
	# End Receipt To Input Tables

	# Comments Special Instructions
	if ($enable_comments_box) {
	$itm_n++;
	$box_heading = "Instructions or Comments ?";
	$box_message = "Enter any special instructions or comments here.";
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5% nowrap><font size=3><strong>$itm_n.</strong></font></td> \n";
	print "<td  width=95%>$final_heading \n";
	print "<strong>$box_heading</strong>";
	print "</font></td></tr> \n";
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%>$final_text \n";
	print "$box_message </font></td></tr>\n";
	print "<tr><td colspan=2><font size=1><br></font></td></tr></table> \n";
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5%><br></td>  \n";
	print "<td> \n\n";
	print "<textarea Class=\"BillingTextAreaFormat\" name=\"special_instructions\" rows=\"4\" cols=\"45\" wrap=\"soft\">";
	print "$frm{'special_instructions'}</textarea> \n\n";
	print "</td></tr>";
	print "<tr><td colspan=2><font size=1><br></font></td></tr>";
	print "</table> \n";
	}

	# Cyber Permission
	if ($enable_cyber_permission) {
	$itm_n++;
	$box_heading = "Final Authorization Required:";
	$box_message = "You must give your final approval by checking Yes for final processing ";
	if ($link_terms) {
	$box_message .= "<a Class=\"TextLink\" href=\"$link_terms_url\" onclick=\"window.open(this.href,8,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">";
	$box_message .= "$link_terms</a>\n";}
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5% nowrap><font size=3><strong>$itm_n.</strong></font></td> \n";
	print "<td  width=95%>$final_heading \n";
	print "<strong>$box_heading</strong>";
	print "</font></td></tr> \n";
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%>$final_text \n";
	print "$box_message </font></td></tr>\n";
	print "<tr><td colspan=2><font size=1><br></font></td></tr></table> \n";
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5%><br></td>  \n";
	print "<td> \n\n";

   	print "<table border=0 width=100%><tr>";
   	print "<td bgcolor=green align=center width=5%>";
   	print "<input Class=\"BillingRadioFormat\" type=radio name=\"input_cyber_permission\" value=\"APPROVED\"></td>";
   	print "<td bgcolor=#D5FED1>$final_text ";
	print "<strong> YES</strong>, I authorize my account to be billed ";
   	print "<strong>$currency $submit_total</strong>." unless ($display_deposit);
	print "</font></td></tr></table>";

   	print "<table border=0 width=100%><tr>";
   	print "<td bgcolor=red align=center width=5%>";
   	print "<input Class=\"BillingRadioFormat\" type=radio name=\"input_cyber_permission\" value=\"\" checked=\"on\"></td>";
   	print "<td bgcolor=#FFCCCC>$final_text ";
   	print "<strong> NO</strong>, I do not authorize my account to be billed. \n";
	print "</font></td></tr></table>";
	print "</td></tr>";
	print "<tr><td colspan=2><font size=1><br></font></td></tr>";
	print "</table> \n";


	}

	# Submit Payment Information Menu
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%>\n";
	print "<tr><td width=5%><br></td><td width=95%>\n";
	print "<table border=0 cellpadding=0 cellspacing=0><tr> \n";

	if ($menu_home_bottom) {
	print "<td valign=top nowrap><a href=\"$menu_home_bottom_url\">$menu_home_bottom</a></td>\n"}
	if ($menu_previous_bottom) {
	print "<td valign=top nowrap><a href=\"$frm{'previouspage'}\">$menu_previous_bottom</a></td>\n"}
	if ($menu_editcart_bottom) {
	print "<td valign=top nowrap>";
	print "<a href=\"$programfile?viewcart&previouspage=$frm{'previouspage'}\">";
	print "$menu_editcart_bottom</a></td>\n";
	}

	# Submit-Resubmit all Preview Data as hidden
	print "<input type=hidden name=\"resubmit_info\" value=\"RESUBMIT\"> \n\n";
	# Adjust %frm to prevent resubmit conflict in hidden POST
	# Adjust %frm to prevent resubmit conflict in hidden POST
	# All Input Fields used in this form must be prevented from hidden POST
	# The only field on this form allowed as hidden post is the 'resubmit_info'
	# which is hidden to begin with

 	while (($key, $val) = each (%billing_info_fields)) {delete ($frm{$key})}
 	while (($key, $val) = each (%receipt_info_fields)) {delete ($frm{$key})}
 	while (($key, $val) = each (%credit_card_fields)) {delete ($frm{$key})}
 	while (($key, $val) = each (%checking_account_fields)) {delete ($frm{$key})}
	unless ($zb_no_method && $frm{'Final_Amount'} == 0) {delete ($frm{'input_payment_options'})}
	delete ($frm{'Ecom_Payment_Card_Type'});
	delete ($frm{'input_shipping_info'});
	delete ($frm{'special_instructions'});
	delete ($frm{'input_cyber_permission'});
	delete ($frm{'Deposit_Amount'});

	# Print adjusted frm Data and new POST data
	while (($key, $val) = each (%frm)) {print "<input type=hidden name=\"$key\" value=\"$val\">\n"}
	# orders printing must come after above frm print
	foreach $line (@orders) {print "<input type=hidden name=\"order\" value=\"$line\">\n"}
	print "\n\n";

	# Submit Payment FORM ends here
	print "<td valign=top>$menu_payment_bottom</td>\n";
	if ($menu_help_bottom) {
	print "<td valign=top>\n";
	print "<a href=\"$menu_help_bottom_url\" onclick=\"window.open(this.href,4,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">\n";
	print "$menu_help_bottom</a></td>\n";}
	print "</tr></table>\n";
	print "</td></tr></table>\n";
	print "</FORM>\n";


	# DEBUG PAYMENT INFO PAGE
	# DEBUG PAYMENT INFO PAGE
	# print "<br><hr><u><strong>All Global Vars</strong></u>";
	# print "<li>resubmit_info = $frm{'resubmit_info'}";
	# print "<li>FRM-OrderID = $frm{'OrderID'}";
	# print "<li>FRM-InfoID = $frm{'InfoID'}";
	# print "<li>previouspage = $frm{'previouspage'}";
	# print "<li>input_payment_options: <b>$frm{'input_payment_options'}</b> ";
	# print "<hr><u><strong>\%MissingInfoFields</strong></u>";
	# print "<ol>";
	# while (($key, $val) = each (%MissingInfoFields)) {print "<li>$key, <strong>$val</strong> \n"}
	# print "</ol>";
	# print "<hr><strong><u>\@UsingInfoFields</u></strong>";
	# print "<ol>";
	# foreach $_ (@UsingInfoFields) {print "<li>$_"}
	# print "</ol>";
	# print "<hr><strong><u>All POST Input From Preview Data or Resubmit</u></strong><br>";
	# print "<font size=2>This must hold at 59 fields from Preview, and 60 if Payment resubmit<br>";
	# print "These are hidden POST, and must not include any fields on this form </font>";
	# print "<ol>";
	# while (($key, $val) = each (%frm)) {print "<li>$key, <strong>$val</strong> \n"}
	# print "</ol>";
	# print "<hr><strong><u>orders Array</u></strong> \n";
	# foreach $_ (@orders) {print "<li>$_ \n";}

	print "$returntofont\n";
	print "@footer \n\n";
	}

# PAYMENT ACCEPTED
sub PaymentAccepted {
	my (@list) = ();
	my ($key, $val);
	my ($nav_top, $nav_bottom) = (0,0);
	my ($li, $lk, $lv, $msg_status);
	my ($totalprice, $totalqnty, $temprice);
	my ($line, $qty, $item, $desc, $price, $ship, $taxit);
	my ($DiscountOne);
	my ($DiscountTwo);
	my ($CombinedDiscount);
	my ($SubDiscount);
	my ($TaxRate);
	my ($AdjustedTax);
	my ($Tax);
	my ($HandlingCharge);
	my ($InsuranceCharge);
	my ($ShippingCharge);
	my ($FinalProducts) = CommifyNumbers ($frm{'Primary_Products'});
	my ($FinalAmount) = CommifyMoney ($frm{'Final_Amount'});
	my ($msg_tab);
	my ($msg_tab_ck);
	my ($check_additional);
	my ($mail_msg, $save_msg, $save_url, $ship_msg, $bill_msg, $receipt_msg);
	my($gateway_return_url) = $save_invoice_url . $$ . $InvoiceNumber . ".html" if ($save_invoice_html);
	$msg_status = "$FinalProducts Items " if ($frm{'Primary_Products'} > 1);
	$msg_status = "$FinalProducts Item " if ($frm{'Primary_Products'} == 1);
	$msg_status = $msg_status . " $currency $Display_Payment_Amount";

	print "Content-Type: text/html\n\n";
	print "@header \n\n";
	# top message
	$_ = $frm{'input_payment_options'};	

	if ($_ eq "MAIL") {
	print "Payment: ";
	print "$payment_options_list{$_} ";
	print "for Amount ";
	print "$currency $Display_Payment_Amount.<br> ";
	print "Print this invoice, complete any Payment Information below, and Mail";
	print " or Fax" if ($merchant_fax);
	print ".<p> ";

	} elsif ($_ eq "COD") {
	print "Payment: ";
	print "$payment_options_list{$_} ";
	print "for Amount ";
	print "$currency $Display_Payment_Amount.<br> ";
	print "Please print this invoice, COD charges may apply.  \n";
	print "<p> ";

	} elsif ($_ eq "ONACCT") {
	print "Payment will be credited ";
	print "$payment_options_list{$_} ";
	print "for Amount ";
	print "$currency $Display_Payment_Amount.<br>  \n";
	print "Account Name: $frm{'Ecom_Payment_Card_Name'}<br> " if ($frm{'Ecom_Payment_Card_Name'});
	print "Account Number: $frm{'Ecom_Payment_Card_Number'}<br> " if ($frm{'Ecom_Payment_Card_Number'});
	print "<p> ";

	} elsif ($_ eq "CALLME") {
	print "We will call you for your payment information and details. <br> ";
	print "Amount ";
	print "$currency $Display_Payment_Amount. ";
	print "Please print this invoice.  \n";
	print "<p> ";

	} elsif ($_ eq "ZEROPAY") {
	print "No charges are associated with this invoice ";
	print "$currency $Display_Payment_Amount.<p> ";

	} elsif ($_ eq "PAYPAL") {
	$paypal_return_url = $save_invoice_url . $$ . $InvoiceNumber . ".html" if ($use_web_copy_as_return_url);
	print "<center><table border=0 cellpadding=2 cellspacing=0><tr> ";
	print "<td valign=top> \n\n ";
	print "<FORM ACTION=\"$paypal_url\" METHOD=\"POST\"> \n";
		# allow _xclick or _ext-enter : 8/01
		if ($paypal_prepop) {
		print "<INPUT TYPE=\"hidden\" NAME=\"cmd\" VALUE=\"_ext-enter\"> \n";
		print "<INPUT TYPE=\"hidden\" NAME=\"redirect_cmd\" VALUE=\"_xclick\"> \n";
		} else {
		print "<INPUT TYPE=\"hidden\" NAME=\"cmd\" VALUE=\"_xclick\"> \n";}
	print "<INPUT TYPE=\"hidden\" NAME=\"business\" VALUE=\"$paypal_login\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"item_name\" VALUE=\"$paypal_merchant Order $InvoiceNumber On $ShortDate\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"item_number\" VALUE=\"Invoice $InvoiceNumber $ShortDate\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"amount\" VALUE=\"$Send_API_Amount\"> \n";
	# new fields 8/01
	print "<INPUT TYPE=\"hidden\" NAME=\"return\" VALUE=\"$paypal_return_url\"> \n" if($paypal_return_url);
	print "<INPUT TYPE=\"hidden\" NAME=\"image_url\" VALUE=\"$paypal_image_url\"> \n" if($paypal_image_url);
	print "<INPUT TYPE=\"hidden\" NAME=\"cancel_return\" VALUE=\"$paypal_cancel_return\"> \n" if($paypal_cancel_return);
	print "<INPUT TYPE=\"hidden\" NAME=\"no_note\" VALUE=\"$paypal_no_note\"> \n" if($paypal_no_note);
	# new pre-populate options 8/01
	if ($paypal_prepop==1) {
	# use shipping addr
	$ppPhone = $frm{'Ecom_ShipTo_Telecom_Phone_Number'};
	my ($ppFirst) = $frm{'Ecom_ShipTo_Postal_Name_First'} . " " . $frm{'Ecom_ShipTo_Postal_Name_Middle'};
	my ($ppState) = $frm{'Ecom_ShipTo_Postal_StateProv'} . " " . $frm{'Ecom_ShipTo_Postal_Region'};
	print "<INPUT TYPE=\"hidden\" NAME=\"first_name\" VALUE=\"$ppFirst\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"last_name\" VALUE=\"$frm{'Ecom_ShipTo_Postal_Name_Last'}\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"address1\" VALUE=\"$frm{'Ecom_ShipTo_Postal_Street_Line1'}\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"address2\" VALUE=\"$frm{'Ecom_ShipTo_Postal_Street_Line2'}\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"city\" VALUE=\"$frm{'Ecom_ShipTo_Postal_City'}\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"state\" VALUE=\"$ppState\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"zip\" VALUE=\"$frm{'Ecom_ShipTo_Postal_PostalCode'}\"> \n";
	} elsif ($paypal_prepop==2) {
	# use billing addr
	$ppPhone = $frm{'Ecom_BillTo_Telecom_Phone_Number'};
	my ($ppFirst) = $frm{'Ecom_BillTo_Postal_Name_First'} . " " . $frm{'Ecom_BillTo_Postal_Name_Middle'};
	my ($ppState) = $frm{'Ecom_BillTo_Postal_StateProv'} . " " . $frm{'Ecom_BillTo_Postal_Region'};
	print "<INPUT TYPE=\"hidden\" NAME=\"first_name\" VALUE=\"$ppFirst\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"last_name\" VALUE=\"$frm{'Ecom_BillTo_Postal_Name_Last'}\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"address1\" VALUE=\"$frm{'Ecom_BillTo_Postal_Street_Line1'}\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"address2\" VALUE=\"$frm{'Ecom_BillTo_Postal_Street_Line2'}\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"city\" VALUE=\"$frm{'Ecom_BillTo_Postal_City'}\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"state\" VALUE=\"$ppState\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"zip\" VALUE=\"$frm{'Ecom_BillTo_Postal_PostalCode'}\"> \n";
	}
	# 8/01 phone input is nnn|nnn|nnnn only
	$ppPhone =~ s/[^0-9]//g;
	my ($ppA,$ppB,$ppC) = (substr($ppPhone,0,3),substr($ppPhone,3,3),substr($ppPhone,6,4));
	print "<INPUT TYPE=\"hidden\" NAME=\"night_phone_a\" VALUE=\"$ppA\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"night_phone_b\" VALUE=\"$ppB\"> \n";
	print "<INPUT TYPE=\"hidden\" NAME=\"night_phone_c\" VALUE=\"$ppC\"> \n";
	# submimt
	print "<INPUT TYPE=\"image\" border=\"0\" SRC=\"$paypal_button\" NAME=\"submit\" ALT=\"Click here to complete Order Via PayPal\"> \n";
	print "</FORM> \n\n";
	print "</td>";
	print "<td valign=top> ";
	print "$action_message_s ";
	print "$payment_options_list{$_} ";
	print "submitting <b>";
	print "$currency $Display_Payment_Amount</b>.<br> ";
	print "Print this invoice, and click ";
	print "the PayPal button to complete this order.\n";
	print "$action_message_e </td></tr></table> ";
	print "</center><p> ";

	} elsif ($_ eq "GATEWAY") {
	print "<table border=0 cellpadding=2 cellspacing=0><tr> ";
	print "<td valign=middle> \n\n ";

	# CUSTOM <FORM> GATEWAY BEGIN CODE ---------------->
	# CUSTOM <FORM> GATEWAY BEGIN CODE ---------------->

	print "<FORM METHOD=POST ACTION=\"https://secure.quickcommerce.net/gateway/transact.dll\">";
	print "<INPUT TYPE=HIDDEN NAME=\"x_Version\" VALUE=\"3.0\">";
	print "<INPUT TYPE=HIDDEN NAME=\"x_Login\" VALUE=\"9942736\">";
	print "<INPUT TYPE=HIDDEN NAME=\"x_Show_Form\" VALUE=\"PAYMENT_FORM\">";
	print "<INPUT TYPE=HIDDEN NAME=\"x_Amount\" VALUE=\"$Send_API_Amount\">";
	print "<INPUT TYPE=HIDDEN NAME=\"x_Invoice_Num\" VALUE=\"$InvoiceNumber\">";
	print "<INPUT TYPE=HIDDEN NAME=\"x_Cust_ID\" VALUE=\"$frm{'InfoID'}\">";
	print "<INPUT TYPE=HIDDEN NAME=\"x_Description\" VALUE=\"Tam's Place Order # $InvoiceNumber\">";
	print "<INPUT TYPE=HIDDEN NAME=\"x_First_Name\" VALUE=\"$frm{'Ecom_BillTo_Postal_Name_First'}\">";
	print "<INPUT TYPE=HIDDEN NAME=\"x_Last_Name\" VALUE=\"$frm{'Ecom_BillTo_Postal_Name_Last'}\">";
	print "<INPUT TYPE=SUBMIT VALUE=\"Click here for secure payment form\">";
	print "</FORM>";

	# CUSTOM </FORM> GATEWAY END CODE <-----------------
	# CUSTOM </FORM> GATEWAY END CODE <-----------------

	print "</td>";
	print "<td valign=top> ";
	print "$action_message_s ";
	print "$payment_options_list{$_} ";
	print "<b>";
	print "$currency $Display_Payment_Amount</b>.<br> ";
	print "Click the payment button to proceed.\n";
	print "$action_message_e </td></tr></table>";

	} else {

		if ($use_gateway_mof) {
		print "<table border=0 cellpadding=2 cellspacing=0><tr> ";
		print "<td valign=middle> \n\n ";
		
		# CUSTOM FULL GATEWAY BEGIN CODE ---------------->
		# Insert your custom gateway <FORM></FORM> code here
		# See docs file: Final Invoice Variables.html for list of vars available
		# You must start a <FORM> and close </FORM> the form in your custom code
		# Note: This gateway assumes that MOFcart will collect cc/check info via SSL
		print "<FORM ACTION=\"---URL-TO-POST-TO----\" METHOD=\"POST\"> \n";
		print "<INPUT TYPE=\"hidden\" NAME=\"---RETURN-URL---\" VALUE=\"$gateway_return_url\"> \n";
		print "<INPUT TYPE=\"hidden\" NAME=\"---INVOICE-NUM---\" VALUE=\"$InvoiceNumber\"> \n";
		print "<INPUT TYPE=\"hidden\" NAME=\"---FINAL-AMOUNT---\" VALUE=\"$Send_API_Amount\"> \n";
		print "<input type=submit value=\"Authorize $currency $Send_API_Amount\"> \n";
		print "</FORM> \n\n";
		# CUSTOM FULL GATEWAY END CODE <-----------------

		print "</td>";
		print "<td valign=top> ";
		print "$action_message_s ";
		print "$payment_options_list{$_} ";
		print "<b>";
		print "$currency $Display_Payment_Amount</b>.<br> ";
		print "Click the Authorize button to finalize your order.\n";
		print "$action_message_e </td></tr></table>";

		} elsif ($check_check) {
		print "Payment: ";
		print "$payment_options_list{$_} ";
		print ", $frm{'Check_Bank_Name'}, " if ($frm{'Check_Bank_Name'}) ;
		print "for $currency $Display_Payment_Amount. <br> ";
		print "Please print this Final Invoice for your records. \n";
		print "<p> ";
		} elsif ($card_check) {
		# Note: $Send_API_Amount is always Final Amount for raw number
		# Note: $Display_Payment_Amount is the formatted Final Amount
		print "Payment: ";
		print "$payment_options_list{$_} ";
		print "for $currency $Display_Payment_Amount. <br> ";
		print "Please print this Final Invoice for your records. \n";
		print "<p> ";
		}
	}

	# Insert MOF navigation at TOP
	$nav_top++ if ($menu_home_top);
	$nav_top++ if ($menu_previous_top);
	$nav_top++ if ($menu_help_top);
	if ($nav_top && $includeOrderConfirmation) {
	print "<table border=0 cellpadding=0 cellspacing=0><tr>\n";
	if ($menu_home_top) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"$menu_home_top_url\">$menu_home_top</a></td>\n";}
	if ($menu_previous_top) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"$frm{'previouspage'}\">$menu_previous_top</a></td>\n";}
	if ($menu_help_top) {
	print "<td nowrap>\n";
	print "<a Class=\"TopNavLink\" href=\"$menu_help_top_url\" onclick=\"window.open(this.href,4,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">\n";
	print "$menu_help_top</a></td>\n";}
	print "</tr></table>\n";
	}

	# Order ID - Date - Invoice Num
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td valign=bottom nowrap>$font_invoice_num_s \n";
	print "Invoice: $InvoiceNumber $font_invoice_num_e </td><td align=right>";
	print "<table border=0 cellpadding=0 cellspacing=0> \n";
		my($x) = "Order ID: $frm{'OrderID'}";
		$x = "<br>" unless ($show_order_id);
		my($y) = "$MyDate";
		$y = "<br>" unless ($y);
	print "<tr><td align=right nowrap>$datetime_s $x $datetime_e </td></tr> \n";
	print "<tr><td align=right nowrap>$datetime_s $y $datetime_e </td></tr></table> \n";
	print "</td></tr></table> \n";

	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=50% $ship_to_bg_final> \n";

	# Display shipping info, etc.
	print "<table border=0 cellpadding=6 cellspacing=0 width=100% height=100%> ";
	print "<tr><td valign=top> \n";

	if ($frm{'Allow_Shipping'}) {
	$msg_tab = "$final_heading SHIP TO:</font><br>" ;	
	} elsif ($frm{'Allow_Tax'}) {
	$msg_tab = "$final_heading TAX AREA: </font><br>"
	} else {
	$msg_tab = "$final_heading ORDER INFORMATION: </font><br>" ;	
	$msg_tab = $msg_tab . "$action_message_s $msg_status $action_message_e\n"
	}

	print "$msg_tab \n";
	print "$action_message_s \n";
	$msg_tab_ck = 0;
	if ($frm{'Ecom_ShipTo_Postal_Name_Prefix'}) {
	print "$frm{'Ecom_ShipTo_Postal_Name_Prefix'} \n";
	$msg_tab_ck++;}
	if ($frm{'Ecom_ShipTo_Postal_Name_First'}) {
	print "$frm{'Ecom_ShipTo_Postal_Name_First'} \n";
	$msg_tab_ck++;}
	if ($frm{'Ecom_ShipTo_Postal_Name_Middle'}) {
	print "$frm{'Ecom_ShipTo_Postal_Name_Middle'} \n";
	$msg_tab_ck++;}
	if ($frm{'Ecom_ShipTo_Postal_Name_Last'}) {
	print "$frm{'Ecom_ShipTo_Postal_Name_Last'} \n";
	$msg_tab_ck++;}
	if ($frm{'Ecom_ShipTo_Postal_Name_Suffix'}) {
	print "$frm{'Ecom_ShipTo_Postal_Name_Suffix'} \n";
	$msg_tab_ck++;}
	print "<br>" if ($msg_tab_ck);
	$msg_tab_ck = 0;
	if ($frm{'Ecom_ShipTo_Postal_Company'}) {
	print "$frm{'Ecom_ShipTo_Postal_Company'} <br>\n"}
	if ($frm{'Ecom_ShipTo_Postal_Street_Line1'}) {
	print "$frm{'Ecom_ShipTo_Postal_Street_Line1'} <br>\n"}
	if ($frm{'Ecom_ShipTo_Postal_Street_Line2'}) {
	print "$frm{'Ecom_ShipTo_Postal_Street_Line2'} <br>\n"}
	if ($frm{'Ecom_ShipTo_Postal_City'}) {
	print "$frm{'Ecom_ShipTo_Postal_City'} \n";
	$msg_tab_ck++;}
	if ($frm{'Ecom_ShipTo_Postal_StateProv'}) {
	unless ($frm{'Ecom_ShipTo_Postal_StateProv'} eq "NOTINLIST") {
	my ($sc) = $frm{'Ecom_ShipTo_Postal_StateProv'};
	$sc =~ s/-/ /g;
	print "$sc \n";
	$msg_tab_ck++;
	}}
	if ($frm{'Ecom_ShipTo_Postal_Region'}) {
	print "$frm{'Ecom_ShipTo_Postal_Region'} \n";
	$msg_tab_ck++}
	if ($frm{'Ecom_ShipTo_Postal_PostalCode'}) {
	print "$frm{'Ecom_ShipTo_Postal_PostalCode'} \n";
	$msg_tab_ck++;}
	print "<br>" if ($msg_tab_ck);
	$msg_tab_ck = 0;
	if ($frm{'Ecom_ShipTo_Postal_CountryCode'}) {
	my ($tc) = $frm{'Ecom_ShipTo_Postal_CountryCode'};
	$tc =~ s/-/ /g;
	print "$tc \n";
	}
	print "$action_message_e </td></tr></table> \n";
	print "</td><td width=50% $bill_to_bg_final> \n";

	# Display Bill To info, etc.
	print "<table border=0 cellpadding=6 cellspacing=0 width=100% height=100%> ";
	print "<tr><td valign=top> \n";
		my ($k,$v,$t);
		while (($k,$v)=each(%frm)) {if ($k =~ /^Ecom_BillTo_/) {++$t if ($v)}}
	print "$final_heading BILL TO: </font>" if ($t);
	print "<br>";
	$msg_tab_ck = 0;
	print "$action_message_s \n";
	if ($frm{'Ecom_BillTo_Postal_Name_Prefix'}) {
	print "$frm{'Ecom_BillTo_Postal_Name_Prefix'} \n";
	$msg_tab_ck++;}
	if ($frm{'Ecom_BillTo_Postal_Name_First'}) {
	print "$frm{'Ecom_BillTo_Postal_Name_First'} \n";
	$msg_tab_ck++;}
	if ($frm{'Ecom_BillTo_Postal_Name_Middle'}) {
	print "$frm{'Ecom_BillTo_Postal_Name_Middle'} \n";
	$msg_tab_ck++;}
	if ($frm{'Ecom_BillTo_Postal_Name_Last'}) {
	print "$frm{'Ecom_BillTo_Postal_Name_Last'} \n";
	$msg_tab_ck++;}
	if ($frm{'Ecom_BillTo_Postal_Name_Suffix'}) {
	print "$frm{'Ecom_BillTo_Postal_Name_Suffix'} \n";
	$msg_tab_ck++;}
	print "<br>" if ($msg_tab_ck);
	$msg_tab_ck = 0;
	if ($frm{'Ecom_BillTo_Postal_Company'}) {
	print "$frm{'Ecom_BillTo_Postal_Company'} <br>\n"}
	if ($frm{'Ecom_BillTo_Postal_Street_Line1'}) {
	print "$frm{'Ecom_BillTo_Postal_Street_Line1'} <br>\n"}
	if ($frm{'Ecom_BillTo_Postal_Street_Line2'}) {
	print "$frm{'Ecom_BillTo_Postal_Street_Line2'} <br>\n"}
	if ($frm{'Ecom_BillTo_Postal_City'}) {
	print "$frm{'Ecom_BillTo_Postal_City'} \n";
	$msg_tab_ck++;}
	if ($frm{'Ecom_BillTo_Postal_StateProv'}) {
 	unless ($frm{'Ecom_BillTo_Postal_StateProv'} eq "NOTINLIST") {
	my ($sc) = $frm{'Ecom_BillTo_Postal_StateProv'};
	$sc =~ s/-/ /g;
	print "$sc \n";
	$msg_tab_ck++;}
	}
	if ($frm{'Ecom_BillTo_Postal_Region'}) {
	print "$frm{'Ecom_BillTo_Postal_Region'} \n";
	$msg_tab_ck++}
	if ($frm{'Ecom_BillTo_Postal_PostalCode'}) {
	print "$frm{'Ecom_BillTo_Postal_PostalCode'} \n";
	$msg_tab_ck++;}
	print "<br>" if ($msg_tab_ck);
	$msg_tab_ck = 0;
	if ($frm{'Ecom_BillTo_Postal_CountryCode'}) {
	my ($tc) = $frm{'Ecom_BillTo_Postal_CountryCode'};
	$tc =~ s/-/ /g;
	print "$tc \n";
	}
	print "$action_message_e </td></tr></table> \n";
	print "</td></tr></table> \n";

	# printing orders in cart
	print "<table $tableborder_color cellpadding=1 cellspacing=0 width=98%> \n";
	print "<tr bgcolor=$tableheading> \n";
	print "<td align=center>$fontheading <strong>Qty</strong></font></td> \n";
	print "<td align=center nowrap>$fontheading <strong>Item Name</strong></font></td> \n";
	print "<td align=center>$fontheading <strong>Description</strong></font></td> \n";
	print "<td align=center>$fontheading <strong>Price</strong></font></td></tr> \n";

	# populate orders in table / store hidden input
	foreach $line (@orders) {
  	($qty, $item, $desc, $price, $ship, $taxit) = split (/$delimit/, $line);
   	print "<tr bgcolor=$tableitem> \n";
	print "<td><center> $fontqnty $qty </center></font></td> \n";
	$item =~ s/\[/</g;
	$item =~ s/\]/>/g;
	if ($frm{'Tax_Amount'} > 0 && $identify_tax_items && $taxit) {
	print "<td>$fontitem $item </font> $identify_tax_items </td> \n";
	} else {
	print "<td>$fontitem $item </font></td> \n";
	}

	# Format User Input in Description
	@list = split (/\|/, $desc);
	$desc = shift (@list);
		foreach $li (@list) {
		($lk, $lv) = split (/::/, $li);
			if ($makelist) {
			$desc = $desc . "$font_key_s<li>$lk $font_key_e$font_val_s$lv$font_val_e";
			} else {
			$desc = $desc . "$font_key_s$lk $font_key_e$font_val_s$lv $font_val_e";
			}
		}
 	$desc =~ s/\[/</g;
	$desc =~ s/\]/>/g;
	$desc = $fontdesc_s . $desc . $fontdesc_e;
	print "<td>$desc </td> \n";

	# Print row for single item or multiple to sub totals
	if ($qty > 1 || $allow_fractions) {
	print "<td align=right>$fontprice \&nbsp\; </td></tr>\n";
		$sub_price = ($qty * $price);
		$totalprice += $sub_price;
		$totalqnty += $qty;
      		$sub_price = sprintf "%.2f", $sub_price;
      		$sub_price = CommifyMoney ($sub_price);
		$price = CommifyMoney ($price);
		$qty = CommifyNumbers ($qty);
   		print "<tr bgcolor=$tablesub><td> \&nbsp\; </td>\n";
		print "<td colspan=2>$fontsubtext\n";
		if ($item_in_subline) {
		print "Sub Total $qty of $item at $currency $price each "}
		else {
		print "Sub Total $qty ( $currency $price per unit ) "}
		print "</font></td>\n";
		print "<td align=right nowrap>$fontsub $currency $sub_price </font></td></tr>\n\n";
	} else {
		$totalprice += $price;
		$totalqnty += $qty;
		$price = CommifyMoney ($price);		
		print "<td valign=bottom align=right nowrap>$fontprice$currency $price </font></td></tr>\n\n";
	}}
   	print "</table> \n";
	print "$returntofont \n";

	print "<table border=0 cellpadding=2 cellspacing=0 width=98%> \n";
	# Display Summary Totals
	if ($totalqnty > 1) {$pd = "Items"} else {$pd = "Item"}
	$totalprice = sprintf "%.2f", $totalprice;
	$totalprice = CommifyMoney ($totalprice);
	$totalqnty = CommifyNumbers ($totalqnty);
	print "<tr><td align=right width=80%>$totaltext Subtotal <strong> \n";
	print "$totalqnty </strong> $pd : </font></td> \n";
	print "<td bgcolor=$totalback align=right nowrap> ";
	print "$totalcolor $currency $totalprice </font></td></tr>\n";

	# Totals from %frm Formerly %Computations -------------->
	# CommifyMoney here, keep computations free of formatting

	# Display First Discount
	if ($frm{'Primary_Discount'} > 0 || $frm{'Primary_Discount_Line_Override_Backend'}) {
	$DiscountOne = CommifyMoney ($frm{'Primary_Discount'});
	print "<tr><td align=right width=80%>$totaltext \n";
	print "$frm{'Primary_Discount_Status'} : </font>\n";
	print "</td><td bgcolor=$totalback align=right nowrap>$totalcolor ";
		if ($frm{'Primary_Discount'} == 0 && $frm{'Primary_Discount_Amt_Override'}) {
		print "$frm{'Primary_Discount_Amt_Override'} ";
		} else {
		print "<font color=red>-</font> $currency $DiscountOne ";
		}
	print "</font></td></tr>\n";
	}

	# Display Coupon Discount
	if ($frm{'Coupon_Discount'} > 0) {
	$DiscountTwo = CommifyMoney ($frm{'Coupon_Discount'});
	print "<tr><td align=right width=80%>$totaltext \n";
	print "Discount $frm{'Coupon_Discount_Status'} : </font>\n";
	print "</td><td bgcolor=$totalback align=right nowrap> - ";
	print "$totalcolor $currency $DiscountTwo </font></td></tr>\n";
	}

	# Display Subtotal if discounts
	if ($frm{'Combined_Discount'} > 0 ) {
	$SubDiscount = CommifyMoney ($frm{'Sub_Final_Discount'});
	$CombinedDiscount = CommifyMoney ($frm{'Combined_Discount'});
	print "<tr><td align=right width=80%>$totaltext \n";
	print "Sub Total After $currency $CombinedDiscount Total Discount : </font>\n";
	print "</td><td bgcolor=$totalback align=right nowrap> ";
	print "$totalcolor $currency <strong>$SubDiscount </strong></font></td></tr>\n";
	}

	# Tax Before
	if ($frm{'Tax_Rule'} eq "BEFORE") {
	if ($frm{'Tax_Amount'} > 0 || $frm{'Tax_Exempt_Status'}) {
	$TaxRate = ($frm{'Tax_Rate'} * 100);
	$AdjustedTax = CommifyMoney ($frm{'Adjusted_Tax_Amount_Before'});
	$Tax = CommifyMoney ($frm{'Tax_Amount'});
	print "<tr><td align=right width=80%>$totaltext \n";
		if ($frm{'Tax_Exempt_Status'}) {
		print "Tax exempt ($frm{'Tax_Exempt_Status'}) ";}
		else {
		print "Sales tax $TaxRate\% ";}
	print "\(on $currency $AdjustedTax taxable\) : </font>\n";
	print "</td><td bgcolor=$totalback align=right nowrap> ";
	print "$totalcolor $currency $Tax </font></td></tr>\n";
	}}

	# Handling Charges
	if ($frm{'Handling'} > 0 || $frm{'Handling_Line_Override'}) {
	$HandlingCharges = CommifyMoney ($frm{'Handling'});
	print "<tr><td align=right width=80%>$totaltext \n";
	print "$frm{'Handling_Status'} : </font>\n";
	print "</td><td bgcolor=$totalback align=right nowrap>$totalcolor ";
	if ($frm{'Handling'} == 0 && $frm{'Handling_Amt_Override'}) {
	print "$frm{'Handling_Amt_Override'} ";
	} else {
	print "$currency $HandlingCharges ";
	}
	print "</font></td></tr>\n";
	}

	# Insurance Charges
	if ($frm{'Insurance'} > 0 || $frm{'Insurance_Line_Override'}) {
	$InsuranceCharges = CommifyMoney ($frm{'Insurance'});
	print "<tr><td align=right width=80%>$totaltext \n";
	print "$frm{'Insurance_Status'} : </font>\n";
	print "</td><td bgcolor=$totalback align=right nowrap>$totalcolor ";
	if ($frm{'Insurance'} == 0 && $frm{'Insurance_Amt_Override'}) {
	print "$frm{'Insurance_Amt_Override'} ";
	} else {
	print "$currency $InsuranceCharges ";
	}
	print "</font></td></tr>\n";
	}

	# Shipping Charges
	if ($frm{'Shipping_Amount'} > 0 || $frm{'Shipping_Line_Override'}) {
	$ShippingCharges = CommifyMoney ($frm{'Shipping_Amount'});
	print "<tr><td align=right width=80%>$totaltext \n";
	print "$frm{'Shipping_Message'} : </font>\n";
	print "</td><td bgcolor=$totalback align=right nowrap>$totalcolor ";
	if ($frm{'Shipping_Amount'} == 0 && $frm{'Shipping_Amt_Override'}) {
	print "$frm{'Shipping_Amt_Override'} ";
	} else {
	print "$currency $ShippingCharges ";
	}
	print "</font></td></tr>\n";
	}

	# Tax After
	if ($frm{'Tax_Rule'} eq "AFTER") {
	if ($frm{'Tax_Amount'} > 0 || $frm{'Tax_Exempt_Status'}) {
	$TaxRate = ($frm{'Tax_Rate'} * 100);
	$AdjustedTax = CommifyMoney ($frm{'Adjusted_Tax_Amount_After'});
	$Tax = CommifyMoney ($frm{'Tax_Amount'});
	print "<tr><td align=right width=80%>$totaltext \n";
		if ($frm{'Tax_Exempt_Status'}) {
		print "Tax exempt ($frm{'Tax_Exempt_Status'}) ";}
		else {
		print "Sales tax $TaxRate\% ";}
	print "\(on $currency $AdjustedTax taxable\) : </font>\n";
	print "</td><td bgcolor=$totalback align=right nowrap> ";
	print "$totalcolor $currency $Tax </font></td></tr>\n";
	}}

	# cod flat charge adjustment
	if ($frm{'input_payment_options'} eq "COD") {
	if ($cod_charges > 0 ) {
	print "<tr><td align=right width=80%>$totaltext \n";
	print "COD Delivery Surcharge : </font>\n";
	print "</td><td bgcolor=$totalback align=right nowrap> ";
	print "$totalcolor $currency $cod_charges </font></td></tr>\n";
	}}

	# Final Total
	print "<tr><td align=right width=80%>$totaltext \n";
	print "<strong>Total Order Amount</strong> : </font>\n";
	print "</td><td bgcolor=$totalback align=right nowrap> ";
	print "$totalcolor $currency <strong> $FinalAmount </strong></font></td></tr>\n";

	# Any deposit amounts
	if ($frm{'Deposit_Amount'} > 0) {
	print "<tr><td align=right width=80%>$totaltext \n";
	print "Amount of Deposit : </font>\n";
	print "</td><td bgcolor=$totalback align=right nowrap> ";
	print "$totalcolor $currency $Display_Payment_Amount </font></td></tr>\n";
	}

	# Balance after deposits
	if ($frm{'Deposit_Amount'} > 0) {
	print "<tr><td align=right width=80%>$totaltext \n";
		if ($frm{'Overpaid_Surplus'}) {print "Overpaid Surplus "}
		else {print "Remaining Balance "}
	print ": </font>\n";
	print "</td><td bgcolor=$totalback align=right nowrap> ";
	print "$totalcolor $currency <strong> $frm{'Remaining_Balance'} ";
	print "</strong></font></td></tr>\n";
	}
	print "</table>";
	
	# Set up additional information
	if ($mail_customer_receipt) {
		# Order: ReceiptTo, BillTo, ShipTo
		if ($frm{'Ecom_ReceiptTo_Online_Email'}) {
		$mail_msg = "An email notice has been mailed to ";		
		$mail_msg = $mail_msg . $frm{'Ecom_ReceiptTo_Online_Email'};
		} elsif ($frm{'Ecom_BillTo_Online_Email'}) {
		$mail_msg = "An email notice has been mailed to ";		
		$mail_msg = $mail_msg . $frm{'Ecom_BillTo_Online_Email'};
		} elsif ($frm{'Ecom_ShipTo_Online_Email'}) {
		$mail_msg = "An email notice has been mailed to ";		
		$mail_msg = $mail_msg . $frm{'Ecom_ShipTo_Online_Email'};
		} else {
		$mail_msg = "An email receipt was not mailed because no customer email address was entered.";
		}
	}

	if ($save_invoice_html && $list_invoice_url) {
	$save_url = $save_invoice_url . $$ . $InvoiceNumber . ".html";
	$save_msg = "Invoice ";
	$save_msg = $save_msg . "<a Class=\"TextLink\" href=\"$save_url\">$save_url</a>";	
	}

	$ship_msg = "Phone $frm{'Ecom_ShipTo_Telecom_Phone_Number'} " if ($frm{'Ecom_ShipTo_Telecom_Phone_Number'});
	$ship_msg = $ship_msg . "Email $frm{'Ecom_ShipTo_Online_Email'} " if ($frm{'Ecom_ShipTo_Online_Email'});
	$bill_msg = "Phone $frm{'Ecom_BillTo_Telecom_Phone_Number'} " if ($frm{'Ecom_BillTo_Telecom_Phone_Number'});
	$bill_msg = $bill_msg . "Email $frm{'Ecom_BillTo_Online_Email'} " if ($frm{'Ecom_BillTo_Online_Email'});
	$receipt_msg = "$frm{'Ecom_ReceiptTo_Postal_Name_Prefix'} " if ($frm{'Ecom_ReceiptTo_Postal_Name_Prefix'});
	$receipt_msg = $receipt_msg . "$frm{'Ecom_ReceiptTo_Postal_Name_First'} " if ($frm{'Ecom_ReceiptTo_Postal_Name_First'});
	$receipt_msg = $receipt_msg . "$frm{'Ecom_ReceiptTo_Postal_Name_Middle'} " if ($frm{'Ecom_ReceiptTo_Postal_Name_Middle'});
	$receipt_msg = $receipt_msg . "$frm{'Ecom_ReceiptTo_Postal_Name_Last'} " if ($frm{'Ecom_ReceiptTo_Postal_Name_Last'});
	$receipt_msg = $receipt_msg . "$frm{'Ecom_ReceiptTo_Postal_Name_Suffix'} " if ($frm{'Ecom_ReceiptTo_Postal_Name_Suffix'});
	$receipt_msg = $receipt_msg . "$frm{'Ecom_ReceiptTo_Postal_Company'} " if ($frm{'Ecom_ReceiptTo_Postal_Company'});
	$receipt_msg = $receipt_msg . "$frm{'Ecom_ReceiptTo_Postal_Street_Line1'} " if ($frm{'Ecom_ReceiptTo_Postal_Street_Line1'});
	$receipt_msg = $receipt_msg . "$frm{'Ecom_ReceiptTo_Postal_Street_Line2'} " if ($frm{'Ecom_ReceiptTo_Postal_Street_Line2'});
	$receipt_msg = $receipt_msg . "$frm{'Ecom_ReceiptTo_Postal_City'} " if ($frm{'Ecom_ReceiptTo_Postal_City'});
	if ($frm{'Ecom_ReceiptTo_Postal_StateProv'}) {
	unless ($frm{'Ecom_ReceiptTo_Postal_StateProv'} eq "NOTINLIST") {
	my ($sc) = $frm{'Ecom_ReceiptTo_Postal_StateProv'};
	$sc =~ s/-/ /g;
	$receipt_msg = $receipt_msg . "$sc ";
	}}
	$receipt_msg = $receipt_msg . "$frm{'Ecom_ReceiptTo_Postal_Region'} " if ($frm{'Ecom_ReceiptTo_Postal_Region'});
	$receipt_msg = $receipt_msg . "$frm{'Ecom_ReceiptTo_Postal_PostalCode'} " if ($frm{'Ecom_ReceiptTo_Postal_PostalCode'});
	if ($frm{'Ecom_ReceiptTo_Postal_CountryCode'}) {
	my ($tc) = $frm{'Ecom_ReceiptTo_Postal_CountryCode'};
	$tc =~ s/-/ /g;
	$receipt_msg = $receipt_msg . "$tc ";
	}
	$receipt_msg = $receipt_msg . "$frm{'Ecom_ReceiptTo_Telecom_Phone_Number'} " if ($frm{'Ecom_ReceiptTo_Telecom_Phone_Number'});
	$receipt_msg = $receipt_msg . "$frm{'Ecom_ReceiptTo_Online_Email'} " if ($frm{'Ecom_ReceiptTo_Online_Email'});

	$check_additional++ if ($mail_msg);
	$check_additional++ if ($save_msg);
	$check_additional++ if ($ship_msg);
	$check_additional++ if ($bill_msg);
	$check_additional++ if ($receipt_msg);

	if ($check_additional) {
	print "<p><table border=0 cellpadding=2 cellspacing=0 width=98%> \n";
	print "<tr><td>$font_comments \n";
	print "<strong>Additional Information:</strong> \n";
	print "</font></td></tr> \n";
	print "<tr><td>$font_comments \n";
	print "$mail_msg <br>" if ($mail_msg);
	print "$save_msg <br>" if ($save_msg);
	print "Ship To: $ship_msg <br>" if ($ship_msg);
	print "Bill To: $bill_msg <br>" if ($bill_msg);
	print "Receipt To: $receipt_msg <br>" if ($receipt_msg);
	print "</font></td></tr></table> \n";
	}

	# Set up Mailing or Faxing payment info
	if ($frm{'input_payment_options'} eq "MAIL") {
	$line_str = "__________________________________";

	if ($allow_lines_credit || $allow_lines_check) {
	print "<p><table border=0 cellpadding=2 cellspacing=0 width=98%> \n";
	print "<tr><td colspan=2>$font_mailfax_form \n";
	print "<strong>Complete any Payment Information for Mailing";
	print " or Faxing" if ($merchant_fax);
	print ":</strong> \n";

	print "</font></td></tr> \n";

	# CC info
	if ($allow_lines_credit) {
	print "<tr><td width=10% align=right nowrap>$font_mailfax_form Credit Card Holder's Name </font></td> \n";
		if ($frm{'Ecom_Payment_Card_Name'}) {
		print "<td>___$frm{'Ecom_Payment_Card_Name'} </td> \n"}
		else {print "<td>$line_str </td> \n"}
		print "</tr> \n";
	print "<tr><td width=10% align=right nowrap>$font_mailfax_form Credit Card Number </font></td> \n";
		if ($frm{'Ecom_Payment_Card_Number'}) {
		print "<td>___$frm{'Ecom_Payment_Card_Number'} </td> \n"}
		else {print "<td>$line_str </td> \n"}
		print "</tr> \n";
	print "<tr><td width=10% align=right nowrap>$font_mailfax_form Credit Card Expiration Date </font></td> \n";
		$exp_date = $frm{'Ecom_Payment_Card_ExpDate_Month'};
		if ($frm{'Ecom_Payment_Card_ExpDate_Month'}) {
		$exp_date = $exp_date . "-" if ($frm{'Ecom_Payment_Card_ExpDate_Day'})}
		$exp_date = $exp_date . $frm{'Ecom_Payment_Card_ExpDate_Day'};
		if ($frm{'Ecom_Payment_Card_ExpDate_Month'} || $frm{'Ecom_Payment_Card_ExpDate_Day'}) {
		$exp_date = $exp_date . "-" if ($frm{'Ecom_Payment_Card_ExpDate_Year'})}
		$exp_date = $exp_date . $frm{'Ecom_Payment_Card_ExpDate_Year'};
		if ($exp_date) {print "<td>___$exp_date </td> \n"}
		else {print "<td>$line_str </td> \n"}
		print "</tr> \n";
	print "<tr><td width=10% align=right nowrap>$font_mailfax_form Signature </font></td> \n";
	print "<td>$line_str </td></tr> \n";
	}

	# Check info
	if ($allow_lines_check) {

	print "<tr><td width=10% align=right nowrap>$font_mailfax_form Name on Checking Account </font></td> \n";
	if ($frm{'Check_Holder_Name'}) {
		print "<td>___$frm{'Check_Holder_Name'} </td> \n"}
		else {print "<td>$line_str </td> \n"}
		print "</tr> \n";
	print "<tr><td width=10% align=right nowrap>$font_mailfax_form Check Number </font></td> \n";
	if ($frm{'Check_Number'}) {
		print "<td>___$frm{'Check_Number'} </td> \n"}
		else {print "<td>$line_str </td> \n"}
		print "</tr> \n";
	print "<tr><td width=10% align=right nowrap>$font_mailfax_form Checking Account Number </font></td> \n";
	if ($frm{'Check_Account_Number'}) {
		print "<td>___$frm{'Check_Account_Number'} </td> \n"}
		else {print "<td>$line_str </td> \n"}
		print "</tr> \n";
	print "<tr><td width=10% align=right nowrap>$font_mailfax_form Routing Number </font></td> \n";
	if ($frm{'Check_Routing_Number'}) {
		print "<td>___$frm{'Check_Routing_Number'} </td> \n"}
		else {print "<td>$line_str </td> \n"}
		print "</tr> \n";
	print "<tr><td width=10% align=right nowrap>$font_mailfax_form Fraction Number </font></td> \n";
	if ($frm{'Check_Fraction_Number'}) {
		print "<td>___$frm{'Check_Fraction_Number'} </td> \n"}
		else {print "<td>$line_str </td> \n"}
		print "</tr> \n";
	print "<tr><td width=10% align=right nowrap>$font_mailfax_form Bank Name </font></td> \n";
	if ($frm{'Check_Bank_Name'}) {
		print "<td>___$frm{'Check_Bank_Name'} </td> \n"}
		else {print "<td>$line_str </td> \n"}
		print "</tr> \n";
	print "<tr><td width=10% align=right nowrap>$font_mailfax_form Bank Address </font></td> \n";
	if ($frm{'Check_Bank_Address'}) {
		print "<td>___$frm{'Check_Bank_Address'} </td> \n"}
		else {print "<td>$line_str </td> \n"}
		print "</tr> \n";
	}
	print "</table> \n";
	}}

	# Special Instructions comments
	if ($frm{'special_instructions'}) {
	print "<p><table border=0 cellpadding=2 cellspacing=0 width=98%> \n";
	print "<tr><td>$font_comments \n";
	print "<strong>Special Instructions or Comments:</strong> \n";
	print "</font></td></tr> \n";
	print "<tr><td>$font_comments \n";
	print "$frm{'special_instructions'} \n";
	print "</font></td></tr></table> \n";
	}

	# Bottom Navigation Menu
	print "<p><table border=0 cellpadding=0 cellspacing=0><tr>\n";
	if ($menu_home_bottom) {
	print "<td valign=top nowrap><a href=\"$menu_home_bottom_url\">$menu_home_bottom</a></td>\n";}
	if ($menu_previous_bottom) {
	print "<td valign=top nowrap><a href=\"$frm{'previouspage'}\">$menu_previous_bottom</a></td>\n";}
	if ($menu_help_bottom) {
	print "<td valign=top>\n";
	print "<a href=\"$menu_help_bottom_url\" onclick=\"window.open(this.href,4,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">\n";
	print "$menu_help_bottom</a></td>\n";}
	print "</tr></table><p>";

	# DEBUG FINAL ORDER
	# print "<strong><u>Library Variables</u></strong> \n";
	# print "<ol>";
 	# print "<li>Date: $Date \n";
 	# print "<li>ShortDate: $ShortDate \n";
	# print "<li>Time: $Time \n";
	# print "<li>ShortTime: $ShortTime \n";
	# print "<li>InvoiceNumber: $InvoiceNumber \n";
	# print "</ol>";
	# print "<strong><u>All frm POST Input From Payment Info Form</u></strong><p>";
	# print "<ol>";
	# while (($key, $val) = each (%frm)) {print "<li>$key, <strong>$val</strong> \n"}
	# print "</ol>";
	# print "<strong><u>orders Array</u></strong> \n";
	# print "<ul> ";
	# foreach $_ (@orders) {print "<li>$_ \n";}
	# print "</ul> ";

	# YOU CAN PUT A SIMPLE <IMG SRC..> AFFILIATE [GET] LINK HERE -- Example
	# The variable [$Send_API_Amount] is the Final amount after all computations (deposit if used)
	# print "<IMG SRC=\"http://www.YOUR-AFFILIATE/PROGRAM/SCRIPT/sale.cgi?cashflow=$Send_API_Amount\" border=0> ";
		
	print "$returntofont\n";
	print "@footer \n\n";

}
# END MERCHANT ORDERFORM Cart ver 2.4
# Copyright by RGA 2000- 2001

