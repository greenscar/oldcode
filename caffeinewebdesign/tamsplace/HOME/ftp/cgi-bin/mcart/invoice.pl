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

sub SaveInvoiceFile {
	my (@tmpfile) = ();
	my ($FileNumber) = $$ . $InvoiceNumber;
	$FileNumber =~ s/[^A-Za-z0-9._-]//g;
	my ($file_path_name) = $save_invoice_path . $FileNumber . ".html";
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
	$msg_status = "$FinalProducts Items " if ($frm{'Primary_Products'} > 1);
	$msg_status = "$FinalProducts Item " if ($frm{'Primary_Products'} == 1);
	$msg_status = $msg_status . " $currency $Display_Payment_Amount";
	foreach $_ (@header) {push (@tmpfile, $_)}

	# top message
	$_ = $frm{'input_payment_options'};	

	if ($_ eq "MAIL") {
	push (@tmpfile, "This is a copy of your original invoice.<br> ");
	push (@tmpfile, "Payment: ");
	push (@tmpfile, "$payment_options_list{$_} ");
	push (@tmpfile, "for Amount ");
	push (@tmpfile, "$currency $Display_Payment_Amount. ");

	} elsif ($_ eq "COD") {
	push (@tmpfile, "Payment: ");
	push (@tmpfile, "$payment_options_list{$_} ");
	push (@tmpfile, "for Amount ");
	push (@tmpfile, "$currency $Display_Payment_Amount.<br> ");
	push (@tmpfile, "Please print this invoice, COD charges may apply.  \n");
	push (@tmpfile, "<p> ");

	} elsif ($_ eq "ONACCT") {
	push (@tmpfile, "Payment will be credited to account ");
	push (@tmpfile, "$currency $Display_Payment_Amount.<br> \n");
	push (@tmpfile, "Account Name: $frm{'Ecom_Payment_Card_Name'}<br>") if ($frm{'Ecom_Payment_Card_Name'});
	push (@tmpfile, "Account Number: $frm{'Ecom_Payment_Card_Number'}<br>") if ($frm{'Ecom_Payment_Card_Number'});

	} elsif ($_ eq "CALLME") {
	push (@tmpfile, "We will call you for your payment information and details. <br>");
	push (@tmpfile, "Amount ");
	push (@tmpfile, "$currency $Display_Payment_Amount. ");
	push (@tmpfile, "Please print this invoice. \n");
	push (@tmpfile, "<p> ");

	} elsif ($_ eq "PAYPAL") {
	push (@tmpfile, "Thanks for using PayPal for your Payment of ");
	push (@tmpfile, "$currency $Display_Payment_Amount.<br> ");
	push (@tmpfile, "If you did not already submit your payment, then ");
	push (@tmpfile, "<a href=\"http://www.paypal.com\"> \n");
	push (@tmpfile, "Click Here </a>\n");

	} elsif ($_ eq "ZEROPAY") {
	push (@tmpfile, "No charges are associated with this invoice ");
	push (@tmpfile, "$currency $Display_Payment_Amount.<br> ");
	push (@tmpfile, "\n");

	# custom forms gateway payment
	} elsif ($_ eq "GATEWAY") {
	push (@tmpfile, "Thank You for your order.<br>Payment via $gateway_item_name ");
	push (@tmpfile, "$currency $Display_Payment_Amount.<br> ");

	} else {
		if ($check_check) {
		push (@tmpfile, "This is a copy of your original invoice.<br> ");
		push (@tmpfile, "Payment: ");
		push (@tmpfile, "$payment_options_list{$_} ");
		push (@tmpfile, ", $frm{'Check_Bank_Name'}, ") if ($frm{'Check_Bank_Name'}) ;
		push (@tmpfile, "for $currency $Display_Payment_Amount.  ");
		} elsif ($card_check) {
		push (@tmpfile, "This is a copy of your original invoice.<br> ");
		push (@tmpfile, "Payment: ");
		push (@tmpfile, "$payment_options_list{$_} ");
		push (@tmpfile, "for $currency $Display_Payment_Amount.  ");
		}
	}
	push (@tmpfile, "<p> ");

	# Order ID - Date - Invoice Num
	push (@tmpfile, "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n");
	push (@tmpfile, "<tr><td valign=bottom nowrap>$font_invoice_num_s \n");
	push (@tmpfile, "Invoice: $InvoiceNumber $font_invoice_num_e </td><td align=right>");
	push (@tmpfile, "<table border=0 cellpadding=0 cellspacing=0> \n");
		my($x) = "Order ID: $frm{'OrderID'}";
		$x = "<br>" unless ($show_order_id);
		my($y) = "$MyDate";
		$y = "<br>" unless ($y);
	push (@tmpfile, "<tr><td align=right nowrap>$datetime_s $x $datetime_e </td></tr> \n");
	push (@tmpfile, "<tr><td align=right nowrap>$datetime_s $y $datetime_e </td></tr></table> \n");
	push (@tmpfile, "</td></tr></table> \n");
	push (@tmpfile, "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n");
	push (@tmpfile, "<tr><td width=50% $ship_to_bg_final> \n");

	# Display shipping info, etc.
	push (@tmpfile, "<table border=0 cellpadding=6 cellspacing=0 width=100% height=100%> ");
	push (@tmpfile, "<tr><td valign=top> \n");

	if ($frm{'Allow_Shipping'}) {
	$msg_tab = "$final_heading SHIP TO: </font><br>" ;	
	} elsif ($frm{'Allow_Tax'}) {
	$msg_tab = "$final_heading TAX AREA: </font><br>"
	} else {
	$msg_tab = "$final_heading ORDER INFORMATION: </font><br>" ;	
	$msg_tab = $msg_tab . "$action_message_s $msg_status $action_message_e\n"
	}

	push (@tmpfile, "$msg_tab \n");
	push (@tmpfile, "$action_message_s \n");
	$msg_tab_ck = 0;
	if ($frm{'Ecom_ShipTo_Postal_Name_Prefix'}) {
	push (@tmpfile, "$frm{'Ecom_ShipTo_Postal_Name_Prefix'} \n");
	$msg_tab_ck++;}
	if ($frm{'Ecom_ShipTo_Postal_Name_First'}) {
	push (@tmpfile, "$frm{'Ecom_ShipTo_Postal_Name_First'} \n");
	$msg_tab_ck++;}
	if ($frm{'Ecom_ShipTo_Postal_Name_Middle'}) {
	push (@tmpfile, "$frm{'Ecom_ShipTo_Postal_Name_Middle'} \n");
	$msg_tab_ck++;}
	if ($frm{'Ecom_ShipTo_Postal_Name_Last'}) {
	push (@tmpfile, "$frm{'Ecom_ShipTo_Postal_Name_Last'} \n");
	$msg_tab_ck++;}
	if ($frm{'Ecom_ShipTo_Postal_Name_Suffix'}) {
	push (@tmpfile, "$frm{'Ecom_ShipTo_Postal_Name_Suffix'} \n");
	$msg_tab_ck++;}
	push (@tmpfile, "<br>") if ($msg_tab_ck);
	$msg_tab_ck = 0;
	if ($frm{'Ecom_ShipTo_Postal_Company'}) {
	push (@tmpfile, "$frm{'Ecom_ShipTo_Postal_Company'} <br>\n")}
	if ($frm{'Ecom_ShipTo_Postal_Street_Line1'}) {
	push (@tmpfile, "$frm{'Ecom_ShipTo_Postal_Street_Line1'} <br>\n")}
	if ($frm{'Ecom_ShipTo_Postal_Street_Line2'}) {
	push (@tmpfile, "$frm{'Ecom_ShipTo_Postal_Street_Line2'} <br>\n")}
	if ($frm{'Ecom_ShipTo_Postal_City'}) {
	push (@tmpfile, "$frm{'Ecom_ShipTo_Postal_City'} \n");
	$msg_tab_ck++;}
	if ($frm{'Ecom_ShipTo_Postal_StateProv'}) {
	unless ($frm{'Ecom_ShipTo_Postal_StateProv'} eq "NOTINLIST") {
	my ($sc) = $frm{'Ecom_ShipTo_Postal_StateProv'};
	$sc =~ s/-/ /g;
	push (@tmpfile, "$sc \n");
	$msg_tab_ck++;}
	}
	if ($frm{'Ecom_ShipTo_Postal_Region'}) {
	push (@tmpfile, "$frm{'Ecom_ShipTo_Postal_Region'} \n");
	$msg_tab_ck++;}
	if ($frm{'Ecom_ShipTo_Postal_PostalCode'}) {
	push (@tmpfile, "$frm{'Ecom_ShipTo_Postal_PostalCode'} \n");
	$msg_tab_ck++;}
	push (@tmpfile, "<br>") if ($msg_tab_ck);
	$msg_tab_ck = 0;
	if ($frm{'Ecom_ShipTo_Postal_CountryCode'}) {
	my ($tc) = $frm{'Ecom_ShipTo_Postal_CountryCode'};
	$tc =~ s/-/ /g;
	push (@tmpfile, "$tc \n");
	}
	push (@tmpfile, "$action_message_e </td></tr></table> \n");
	push (@tmpfile, "</td><td width=50% $bill_to_bg_final> \n");

	# Display Bill To info, etc.
	push (@tmpfile, "<table border=0 cellpadding=6 cellspacing=0 width=100% height=100%> ");
	push (@tmpfile, "<tr><td valign=top> \n");
		my ($k,$v,$t);
		while (($k,$v)=each(%frm)) {if ($k =~ /^Ecom_BillTo_/) {++$t if ($v)}}
	push (@tmpfile, "$final_heading BILL TO: </font>") if ($t);
	push (@tmpfile, "<br>");
	$msg_tab_ck = 0;
	push (@tmpfile, "$action_message_s \n");
	if ($frm{'Ecom_BillTo_Postal_Name_Prefix'}) {
	push (@tmpfile, "$frm{'Ecom_BillTo_Postal_Name_Prefix'} \n");
	$msg_tab_ck++;}
	if ($frm{'Ecom_BillTo_Postal_Name_First'}) {
	push (@tmpfile, "$frm{'Ecom_BillTo_Postal_Name_First'} \n");
	$msg_tab_ck++;}
	if ($frm{'Ecom_BillTo_Postal_Name_Middle'}) {
	push (@tmpfile, "$frm{'Ecom_BillTo_Postal_Name_Middle'} \n");
	$msg_tab_ck++;}
	if ($frm{'Ecom_BillTo_Postal_Name_Last'}) {
	push (@tmpfile, "$frm{'Ecom_BillTo_Postal_Name_Last'} \n");
	$msg_tab_ck++;}
	if ($frm{'Ecom_BillTo_Postal_Name_Suffix'}) {
	push (@tmpfile, "$frm{'Ecom_BillTo_Postal_Name_Suffix'} \n");
	$msg_tab_ck++;}
	push (@tmpfile, "<br>") if ($msg_tab_ck);
	$msg_tab_ck = 0;
	if ($frm{'Ecom_BillTo_Postal_Company'}) {
	push (@tmpfile, "$frm{'Ecom_BillTo_Postal_Company'} <br>\n")}
	if ($frm{'Ecom_BillTo_Postal_Street_Line1'}) {
	push (@tmpfile, "$frm{'Ecom_BillTo_Postal_Street_Line1'} <br>\n")}
	if ($frm{'Ecom_BillTo_Postal_Street_Line2'}) {
	push (@tmpfile, "$frm{'Ecom_BillTo_Postal_Street_Line2'} <br>\n")}
	if ($frm{'Ecom_BillTo_Postal_City'}) {
	push (@tmpfile, "$frm{'Ecom_BillTo_Postal_City'} \n");
	$msg_tab_ck++;}
	if ($frm{'Ecom_BillTo_Postal_StateProv'}) {
 	unless ($frm{'Ecom_BillTo_Postal_StateProv'} eq "NOTINLIST") {
	my ($sc) = $frm{'Ecom_BillTo_Postal_StateProv'};
	$sc =~ s/-/ /g;
	push (@tmpfile, "$sc \n");
	$msg_tab_ck++;
	}}
	if ($frm{'Ecom_BillTo_Postal_Region'}) {
	push (@tmpfile, "$frm{'Ecom_BillTo_Postal_Region'} \n");
	$msg_tab_ck++;}
	if ($frm{'Ecom_BillTo_Postal_PostalCode'}) {
	push (@tmpfile, "$frm{'Ecom_BillTo_Postal_PostalCode'} \n");
	$msg_tab_ck++;}
	push (@tmpfile, "<br>") if ($msg_tab_ck);
	$msg_tab_ck = 0;
	if ($frm{'Ecom_BillTo_Postal_CountryCode'}) {
	my ($tc) = $frm{'Ecom_BillTo_Postal_CountryCode'};
	$tc =~ s/-/ /g;
	push (@tmpfile, "$tc \n");
	}
	push (@tmpfile, "$action_message_e </td></tr></table> \n");
	push (@tmpfile, "</td></tr></table> \n");

	# printing orders in cart
	push (@tmpfile, "<table $tableborder_color cellpadding=1 cellspacing=0 width=98%> \n");
	push (@tmpfile, "<tr bgcolor=$tableheading> \n");
	push (@tmpfile, "<td align=center>$fontheading <strong>Qty</strong></font></td> \n");
	push (@tmpfile, "<td align=center nowrap>$fontheading <strong>Item Name</strong></font></td> \n");
	push (@tmpfile, "<td align=center>$fontheading <strong>Description</strong></font></td> \n");
	push (@tmpfile, "<td align=center>$fontheading <strong>Price</strong></font></td></tr> \n");

	# populate orders in table / store hidden input
	foreach $line (@orders) {
  	($qty, $item, $desc, $price, $ship, $taxit) = split (/$delimit/, $line);
   	push (@tmpfile, "<tr bgcolor=$tableitem> \n");
	push (@tmpfile, "<td><center> $fontqnty $qty </center></td> \n");
	$item =~ s/\[/</g;
	$item =~ s/\]/>/g;
	if ($frm{'Tax_Amount'} > 0 && $identify_tax_items && $taxit) {
	push (@tmpfile, "<td>$fontitem $item $identify_tax_items </td> \n");
	} else {
	push (@tmpfile, "<td>$fontitem $item </td> \n");
	}

	# Format User Input in Description
	@list = split (/\|/, $desc);
	$desc = shift (@list);
		foreach $li (@list) {
		($lk, $lv) = split (/::/, $li);
			if ($makelist) {
			$desc = $desc . "$font_key_s<li>$lk $font_key_e$font_val_s$lv$font_val_e";
			} else {
			$desc = $desc . "$font_key_s$lk $font_key_e$font_val_s$lv$font_val_e";
			}
		}
	 	$desc =~ s/\[/</g;
		$desc =~ s/\]/>/g;
		$desc = $fontdesc_s . $desc . $fontdesc_e;
		push (@tmpfile, "<td>$desc </td> \n");

	# Print row for single item or multiple to sub totals
	if ($qty > 1 || $allow_fractions) {
	push (@tmpfile, "<td align=right>$fontprice \&nbsp\; </td></tr>\n");
		$sub_price = ($qty * $price);
		$totalprice += $sub_price;
		$totalqnty += $qty;
	      	$sub_price = sprintf "%.2f", $sub_price;
      		$sub_price = CommifyMoney ($sub_price);
		$price = CommifyMoney ($price);
		$qty = CommifyNumbers ($qty);
   		push (@tmpfile, "<tr bgcolor=$tablesub><td> \&nbsp\; </td>\n");
		push (@tmpfile, "<td colspan=2>$fontsubtext\n"); 
		if ($item_in_subline) {
		push (@tmpfile, "Sub Total $qty of $item at $currency $price each ")}
		else {
		push (@tmpfile, "Sub Total $qty ( $currency $price per unit ) ")}
		push (@tmpfile, "</font></td>\n");
		push (@tmpfile, "<td align=right nowrap>$fontsub $currency $sub_price </font></td></tr>\n\n");
	} else {
		$totalprice += $price;
		$totalqnty += $qty;
		$price = CommifyMoney ($price);		
		push (@tmpfile, "<td valign=bottom align=right nowrap>$fontprice$currency $price </font></td></tr>\n\n");
	}}
   	push (@tmpfile, "</table> \n");
	push (@tmpfile, "$returntofont \n");

	push (@tmpfile, "<table border=0 cellpadding=2 cellspacing=0 width=98%> \n");
	# Display Summary Totals
	if ($totalqnty > 1) {$pd = "Items"} else {$pd = "Item"}
	$totalprice = sprintf "%.2f", $totalprice;
	$totalprice = CommifyMoney ($totalprice);
	$totalqnty = CommifyNumbers ($totalqnty);
	push (@tmpfile, "<tr><td align=right width=80%>$totaltext Subtotal <strong> \n");
	push (@tmpfile, "$totalqnty </strong> $pd : </font></td> \n");
	push (@tmpfile, "<td bgcolor=$totalback align=right nowrap> ");
	push (@tmpfile, "$totalcolor $currency $totalprice </font></td></tr>\n");

	# Totals from %frm Formerly %Computations -------------->
	# CommifyMoney here, keep computations free of formatting

	# Display First Discount
	if ($frm{'Primary_Discount'} > 0 || $frm{'Primary_Discount_Line_Override_Backend'}) {
	$DiscountOne = CommifyMoney ($frm{'Primary_Discount'});
	push (@tmpfile, "<tr><td align=right width=80%>$totaltext \n");
	push (@tmpfile, "$frm{'Primary_Discount_Status'} : </font>\n");
	push (@tmpfile, "</td><td bgcolor=$totalback align=right nowrap>$totalcolor");
		if ($frm{'Primary_Discount'} == 0 && $frm{'Primary_Discount_Amt_Override'}) {
		push (@tmpfile, "$frm{'Primary_Discount_Amt_Override'} ");
		} else {
		push (@tmpfile, "<font color=red>-</font> $currency $DiscountOne ");
		}
	push (@tmpfile, "</font></td></tr>\n");
	}

	# Display Coupon Discount
	if ($frm{'Coupon_Discount'} > 0) {
	$DiscountTwo = CommifyMoney ($frm{'Coupon_Discount'});
	push (@tmpfile, "<tr><td align=right width=80%>$totaltext \n");
	push (@tmpfile, "Discount $frm{'Coupon_Discount_Status'} : </font>\n");
	push (@tmpfile, "</td><td bgcolor=$totalback align=right nowrap> - ");
	push (@tmpfile, "$totalcolor $currency $DiscountTwo </font></td></tr>\n");
	}

	# Display Subtotal if discounts
	if ($frm{'Combined_Discount'} > 0 ) {
	$SubDiscount = CommifyMoney ($frm{'Sub_Final_Discount'});
	$CombinedDiscount = CommifyMoney ($frm{'Combined_Discount'});
	push (@tmpfile, "<tr><td align=right width=80%>$totaltext \n");
	push (@tmpfile, "Sub Total After $currency $CombinedDiscount Total Discount : </font>\n");
	push (@tmpfile, "</td><td bgcolor=$totalback align=right nowrap> ");
	push (@tmpfile, "$totalcolor $currency <strong>$SubDiscount </strong></font></td></tr>\n");
	}

	# Tax Before
	if ($frm{'Tax_Rule'} eq "BEFORE") {
	if ($frm{'Tax_Amount'} > 0 || $frm{'Tax_Exempt_Status'}) {
	$TaxRate = ($frm{'Tax_Rate'} * 100);
	$AdjustedTax = CommifyMoney ($frm{'Adjusted_Tax_Amount_Before'});
	$Tax = CommifyMoney ($frm{'Tax_Amount'});
	push (@tmpfile, "<tr><td align=right width=80%>$totaltext \n");
		if ($frm{'Tax_Exempt_Status'}) {
		push (@tmpfile, "Tax exempt ($frm{'Tax_Exempt_Status'}) ");}
		else {
		push (@tmpfile, "Sales tax $TaxRate\% ");}
	push (@tmpfile, "\(on $currency $AdjustedTax taxable\) : </font>\n");
	push (@tmpfile, "</td><td bgcolor=$totalback align=right nowrap> ");
	push (@tmpfile, "$totalcolor $currency $Tax </font></td></tr>\n");
	}}

	# Handling Charges
	if ($frm{'Handling'} > 0 || $frm{'Handling_Line_Override'}) {
	$HandlingCharges = CommifyMoney ($frm{'Handling'});
	push (@tmpfile, "<tr><td align=right width=80%>$totaltext \n");
	push (@tmpfile, "$frm{'Handling_Status'} : </font>\n");
	push (@tmpfile, "</td><td bgcolor=$totalback align=right nowrap>$totalcolor  ");
	if ($frm{'Handling'} == 0 && $frm{'Handling_Amt_Override'}) {
	push (@tmpfile, "$frm{'Handling_Amt_Override'} ");
	} else {
	push (@tmpfile, "$currency $HandlingCharges ");
	}
	push (@tmpfile, "</font></td></tr>\n");
	}

	# Insurance Charges
	if ($frm{'Insurance'} > 0 || $frm{'Insurance_Line_Override'}) {
	$InsuranceCharges = CommifyMoney ($frm{'Insurance'});
	push (@tmpfile, "<tr><td align=right width=80%>$totaltext \n");
	push (@tmpfile, "$frm{'Insurance_Status'} : </font>\n");
	push (@tmpfile, "</td><td bgcolor=$totalback align=right nowrap>$totalcolor ");
	if ($frm{'Insurance'} == 0 && $frm{'Insurance_Amt_Override'}) {
	push (@tmpfile, "$frm{'Insurance_Amt_Override'} ");
	} else {
	push (@tmpfile, "$currency $InsuranceCharges ");
	}
	push (@tmpfile, "</font></td></tr>\n");
	}

	# Shipping Charges
	if ($frm{'Shipping_Amount'} > 0 || $frm{'Shipping_Line_Override'}) {
	$ShippingCharges = CommifyMoney ($frm{'Shipping_Amount'});
	push (@tmpfile, "<tr><td align=right width=80%>$totaltext \n");
	push (@tmpfile, "$frm{'Shipping_Message'} : </font>\n");
	push (@tmpfile, "</td><td bgcolor=$totalback align=right nowrap>$totalcolor ");
	if ($frm{'Shipping_Amount'} == 0 && $frm{'Shipping_Amt_Override'}) {
	push (@tmpfile, "$frm{'Shipping_Amt_Override'} ");
	} else {
	push (@tmpfile, "$currency $ShippingCharges ");
	}
	push (@tmpfile, "</font></td></tr>\n");
	}

	# Tax After
	if ($frm{'Tax_Rule'} eq "AFTER") {
	if ($frm{'Tax_Amount'} > 0 || $frm{'Tax_Exempt_Status'}) {
	$TaxRate = ($frm{'Tax_Rate'} * 100);
	$AdjustedTax = CommifyMoney ($frm{'Adjusted_Tax_Amount_After'});
	$Tax = CommifyMoney ($frm{'Tax_Amount'});
	push (@tmpfile, "<tr><td align=right width=80%>$totaltext \n");
		if ($frm{'Tax_Exempt_Status'}) {
		push (@tmpfile, "Tax exempt ($frm{'Tax_Exempt_Status'}) ");}
		else {
		push (@tmpfile, "Sales tax $TaxRate\% ");}
	push (@tmpfile, "\(on $currency $AdjustedTax taxable\) : </font>\n");
	push (@tmpfile, "</td><td bgcolor=$totalback align=right nowrap> ");
	push (@tmpfile, "$totalcolor $currency $Tax </font></td></tr>\n");
	}}

	# cod flat charge adjustment
	if ($frm{'input_payment_options'} eq "COD") {
	if ($cod_charges > 0 ) {
	push (@tmpfile, "<tr><td align=right width=80%>$totaltext \n");
	push (@tmpfile, "COD Delivery Surcharge : </font>\n");
	push (@tmpfile, "</td><td bgcolor=$totalback align=right nowrap> ");
	push (@tmpfile, "$totalcolor $currency $cod_charges </font></td></tr>\n");
	}}

	# Final Total
	push (@tmpfile, "<tr><td align=right width=80%>$totaltext \n");
	push (@tmpfile, "<strong>Total Order Amount</strong> : </font>\n");
	push (@tmpfile, "</td><td bgcolor=$totalback align=right nowrap> ");
	push (@tmpfile, "$totalcolor $currency <strong> $FinalAmount </strong></font></td></tr>\n");

	# Any deposit amounts
	if ($frm{'Deposit_Amount'} > 0) {
	push (@tmpfile, "<tr><td align=right width=80%>$totaltext \n");
	push (@tmpfile, "Amount of Deposit : </font>\n");
	push (@tmpfile, "</td><td bgcolor=$totalback align=right nowrap> ");
	push (@tmpfile, "$totalcolor $currency $Display_Payment_Amount </font></td></tr>\n");
	}

	# Balance after deposits
	if ($frm{'Deposit_Amount'} > 0) {
	push (@tmpfile, "<tr><td align=right width=80%>$totaltext \n");
		if ($frm{'Overpaid_Surplus'}) {
		push (@tmpfile, "Overpaid Surplus ")} 
		else {
		push (@tmpfile, "Remaining Balance ")}
	push (@tmpfile, ": </font>\n");
	push (@tmpfile, "</td><td bgcolor=$totalback align=right nowrap> ");
	push (@tmpfile, "$totalcolor $currency <strong> $frm{'Remaining_Balance'} ");
	push (@tmpfile, "</strong></font></td></tr>\n");
	}
	push (@tmpfile, "</table>\n");

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

	$ship_msg = "Email $frm{'Ecom_ShipTo_Online_Email'} " if ($frm{'Ecom_ShipTo_Online_Email'});
	$bill_msg = "Email $frm{'Ecom_BillTo_Online_Email'} " if ($frm{'Ecom_BillTo_Online_Email'});
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
	$receipt_msg = $receipt_msg . "$frm{'Ecom_ReceiptTo_Online_Email'} " if ($frm{'Ecom_ReceiptTo_Online_Email'});

	$check_additional++ if ($mail_msg);
	$check_additional++ if ($ship_msg);
	$check_additional++ if ($bill_msg);
	$check_additional++ if ($receipt_msg);

	if ($check_additional) {
	push (@tmpfile, "<p><table border=0 cellpadding=2 cellspacing=0 width=98%> \n");
	push (@tmpfile, "<tr><td>$font_comments \n");
	push (@tmpfile, "<strong>Additional Information:</strong> \n");
	push (@tmpfile, "</font></td></tr> \n");
	push (@tmpfile, "<tr><td>$font_comments \n");
	push (@tmpfile, "$mail_msg <br>") if ($mail_msg);
	push (@tmpfile, "Ship To: $ship_msg <br>") if ($ship_msg);
	push (@tmpfile, "Bill To: $bill_msg <br>") if ($bill_msg);
	push (@tmpfile, "Receipt To: $receipt_msg <br>") if ($receipt_msg);
	push (@tmpfile, "</font></td></tr></table> \n");
	}

	# Set up Mailing or Faxing payment info
	if ($frm{'input_payment_options'} eq "MAIL") {
	$line_str = "__________________________________";

	if ($allow_lines_credit || $allow_lines_check) {

	push (@tmpfile, "<p><table border=0 cellpadding=2 cellspacing=0 width=98%> \n");
	push (@tmpfile, "<tr><td colspan=2>$font_mailfax_form \n");
	push (@tmpfile, "<strong>Complete Any Payment Information For Mailing ");
	push (@tmpfile, "or Faxing") if ($merchant_fax);
	push (@tmpfile, ":</strong> \n");
	push (@tmpfile, "</font></td></tr> \n");

	# CC info
	if ($allow_lines_credit) {
	push (@tmpfile, "<tr><td width=10% align=right nowrap>$font_mailfax_form Credit Card Holder's Name </font></td> \n");
	push (@tmpfile, "<td>$line_str </td></tr> \n");
	push (@tmpfile, "<tr><td width=10% align=right nowrap>$font_mailfax_form Credit Card Number </font></td> \n");
	push (@tmpfile, "<td>$line_str </td></tr> \n");
	push (@tmpfile, "<tr><td width=10% align=right nowrap>$font_mailfax_form Credit Card Expiration Date </font></td> \n");
	push (@tmpfile, "<td>$line_str </td></tr> \n");
	push (@tmpfile, "<tr><td width=10% align=right nowrap>$font_mailfax_form Signature </font></td> \n");
	push (@tmpfile, "<td>$line_str </td></tr> \n");
	}

	# Check info
	if ($allow_lines_check) {
	push (@tmpfile, "<tr><td width=10% align=right nowrap>$font_mailfax_form Name on Checking Account </font></td> \n");
	push (@tmpfile, "<td>$line_str </td></tr> \n");
	push (@tmpfile, "<tr><td width=10% align=right nowrap>$font_mailfax_form Check Number </font></td> \n");
	push (@tmpfile, "<td>$line_str </td></tr> \n");
	push (@tmpfile, "<tr><td width=10% align=right nowrap>$font_mailfax_form Checking Account Number </font></td> \n");
	push (@tmpfile, "<td>$line_str </td></tr> \n");
	push (@tmpfile, "<tr><td width=10% align=right nowrap>$font_mailfax_form Bank Routing Number </font></td> \n");
	push (@tmpfile, "<td>$line_str </td></tr> \n");
	push (@tmpfile, "<tr><td width=10% align=right nowrap>$font_mailfax_form Fraction Number </font></td> \n");
	push (@tmpfile, "<td>$line_str </td></tr> \n");
	push (@tmpfile, "<tr><td width=10% align=right nowrap>$font_mailfax_form Bank Name </font></td> \n");
	push (@tmpfile, "<td>$line_str </td></tr> \n");
	push (@tmpfile, "<tr><td width=10% align=right nowrap>$font_mailfax_form Bank Address </font></td> \n");
	push (@tmpfile, "<td>$line_str </td></tr> \n");
	}
	push (@tmpfile, "</table> \n");
	}}

	# Special Instructions comments
	if ($frm{'special_instructions'}) {
	push (@tmpfile, "<p><table border=0 cellpadding=2 cellspacing=0 width=98%> \n");
	push (@tmpfile, "<tr><td>$font_comments \n");
	push (@tmpfile, "<strong>Special Instructions or Comments:</strong> \n");
	push (@tmpfile, "</font></td></tr> \n");
	push (@tmpfile, "<tr><td>$font_comments \n");
	push (@tmpfile, "$frm{'special_instructions'} \n");
	push (@tmpfile, "</font></td></tr></table> \n");
	}
	push (@tmpfile, "<p>$returntofont \n");
	foreach $_ (@footer) {push (@tmpfile, $_)}

	# PRINT TO FILE
	unless (open (FILE, ">$file_path_name") ) { 
		$ErrMsg = "Unable to Create HTML Invoice File: $frm{'OrderID'}";
		&ErrorMessage($ErrMsg);
		}
		print FILE @tmpfile;
		close(FILE);
		chmod (0777, $file_path_name) if ($set_ssl_chmod);
	}

1;
# END MERCHANT ORDERFORM Cart ver 2.4
# Copyright by RGA 2000- 2001
