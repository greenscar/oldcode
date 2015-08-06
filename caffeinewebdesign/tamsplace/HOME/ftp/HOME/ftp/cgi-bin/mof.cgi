#!/usr/bin/perl
# use CGI::Carp qw(fatalsToBrowser);
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

# THIS IS THE FRONT END PROGRAM
# DO NOT CHANGE ANY OF THESE SETTINGS
# ===================================
require 5.001;
require 'mof.conf';
require 'moflib.pl';
# cookie names must be the same in both program files
$cookiename_OrderID = 'mof_v24_OrderID';
$cookiename_InfoID = 'mof_v24_InfoID';

# PROGRAM FLOW
# AcceptOrder
# PreviewInformation
# PreviewOrder

&SetDateVariable;
&RunTestMode if ($ERRORMODE==0 && $ENV{'QUERY_STRING'} =~ /^test/i);

 # QRY INPUT	
 if ($ENV{'QUERY_STRING'}) {
	&CheckAllowedDomains if (scalar(@ALLOWED_DOMAINS));
	&ProcessQueryString;
	&CheckCookie;
	if ($view) {
		if ($cookieOrderID) {
		$frm{'previouspage'} = substr ($ENV{'QUERY_STRING'},22);
		&ReadDataFile($cookieOrderID);
		$msg_function = "What's In Your Cart ?";
		&AcceptOrder;
		} else {
		print "Location: $cookieredirect\n\n";
		exit;
		}
	} else {
		if ($cookieOrderID) {
		&ReadDataFile($cookieOrderID);
		&ProcessDataFile;
		&WriteDataFile($cookieOrderID);
		$msg_function = "Adding $msg_i New Item" if ($msg_i == 1);
		$msg_function = "Adding $msg_i New Items" if ($msg_i != 1);
			if ($msg_d) {
			$msg_function = $msg_function . ", $msg_d Duplicate Item" if ($msg_d == 1);
			$msg_function = $msg_function . ", $msg_d Duplicate Items" if ($msg_d != 1);
			}
			&AcceptOrder;
		} else {
		&GenerateOrderID;
		&MakeCookie($cookiename_OrderID, $OrderID);
		@orders = @NewOrder;
		&WriteDataFile($OrderID);
		$msg_function = "Adding $msg_i New Item" if ($msg_i == 1);
		$msg_function = "Adding $msg_i New Items" if ($msg_i != 1);
		&AcceptOrder;
		}
	}

 # FORM POST INPUT
 } else {
	&CheckAllowedDomains if (scalar(@ALLOWED_DOMAINS));
	&ProcessForm;

	# POSTMODE = SINGLEPOST-CHECKBOXES-QUANTITYBOXES
	if ($frm{'postmode'} eq "SINGLEPOST" || $frm{'postmode'} eq "CHECKBOXES" || $frm{'postmode'} eq "QUANTITYBOXES") {
		&CheckCookie;
		if ($cookieOrderID) {
		&ReadDataFile($cookieOrderID);
		&ProcessDataFile;
		&WriteDataFile($cookieOrderID);
		$msg_function = "Adding $msg_i New Item" if ($msg_i == 1);
		$msg_function = "Adding $msg_i New Items" if ($msg_i != 1);
			if ($msg_d) {
			$msg_function = $msg_function . ", $msg_d Duplicate Item" if ($msg_d == 1);
			$msg_function = $msg_function . ", $msg_d Duplicate Items" if ($msg_d != 1);
			}
			&AcceptOrder;
		} else {
		&GenerateOrderID;
		&MakeCookie($cookiename_OrderID, $OrderID);
		@orders = @NewOrder;
		&WriteDataFile($OrderID);
		$msg_function = "Adding $msg_i New Item" if ($msg_i == 1);
		$msg_function = "Adding $msg_i New Items" if ($msg_i != 1);
		&AcceptOrder;
		}

	# UPDATE CART
	} elsif ($frm{'postmode'} eq "UPDATE") {
		&CheckCookie;
		if ($cookieOrderID) {
		$OrderID = $frm{'OrderID'};
		@orders = @NewOrder;
		&WriteDataFile($OrderID);
		$msg_function = "Updated $msg_i Cart Item" if ($msg_i == 1);
		$msg_function = "Updated $msg_i Cart Items" if ($msg_i != 1);
		&AcceptOrder;
		} else {
		print "Location: $cookieredirect\n\n";
		exit;
		}

	# DELETE CART
	} elsif ($frm{'postmode'} eq "DELETE") {
		$msg_i = $frm{'deleted_items'};
		&CheckCookie;
		if ($cookieOrderID) {
		$OrderID = $frm{'OrderID'};
		&WriteDataFile($OrderID);
		$msg_function = "Deleted $msg_i Cart Item" if ($msg_i == 1);
		$msg_function = "Deleted $msg_i Cart Items" if ($msg_i != 1);
		&AcceptOrder;
		} else {
		print "Location: $cookieredirect\n\n";
		exit;
		}

	# PREVIEW INVOICE
	} elsif ($frm{'postmode'} eq "PREVIEW") {
		# globals
		@UsingInfoFields = ();
		@MasterInfoList = ();
		%MissingInfoFields = ();
		$UseStateProv = 0;
		%Computations = ();
		&CheckCookie;
		$OrderID = $frm{'OrderID'};
		$InfoID = $cookieInfoID if ($cookieInfoID);
		$InfoID = $frm{'InfoID'} if $frm{'InfoID'};
		@orders = @NewOrder;

		# Preview Decision
		if (&CheckFieldsNeeded) {
			if ($cookieOrderID) {
				if ($frm{'submit_preview_info'} eq "NEWSUBMIT") {
				&ReadNewInfo;
				&WriteInfoFile($InfoID);
				$msg_function = "NEWSUBMIT";
				} elsif ($frm{'submit_preview_info'} eq "EDITING") {
				&ReadInfoFile($InfoID);
				$msg_function = "EDITING";
				} else {
					if ($cookieInfoID) {
					$InfoID = $cookieInfoID;
					&ReadInfoFile($InfoID);
					$msg_function = "FOUNDATA";
					} else {
					&GenerateInfoID;
					&MakeNullList;
					$msg_function = "NEWLIST";
					}
				}
			} else {
			print "Location: $cookieredirect\n\n";
			exit;
			}
		} else {
			if ($cookieOrderID) {
			$msg_function = "Nothing Needed";
			&MakeComputations;
			&PreviewOrder;
			exit;
			} else {
			print "Location: $cookieredirect\n\n";
			exit;
			}
		}
		# End Preview Decision

		&MakeCookie($cookiename_InfoID, $InfoID);
		if (&CheckUsingInfoFields) {
		&PreviewInformation;
		} else {
			if ($frm{'submit_preview_info'} eq "EDITING") {
			&PreviewInformation;
			} else {
			&MakeComputations;
			&PreviewOrder;
			}
		}

	# CUSTOM MODE
	} elsif ($frm{'postmode'} eq "CUSTOM") {
	# Reserved for custom input mode
		
	# MODE NOT FOUND
	} else {
 	$ErrMsg="<h4>Unable To Determine Input Mode</h4>";
	&ErrorMessage($ErrMsg);
	}
 }

# ACCEPT ORDER
sub AcceptOrder {
	@header = ();
	@footer = ();
	my ($i)=0;
	my (@list) = ();
	my ($nav_top, $nav_bottom) = (0,0);
	my ($li, $lk, $lv, $msg_status, $msg_n);
	my ($totalprice, $totalqnty, $temprice);
	my ($line, $qty, $item, $desc, $price, $ship, $taxit);

	# set up Continue Shopping URL
	if ($ContinueShopURL) {
	$previouspage = $ContinueShopURL;
	} elsif ($frm{'previouspage'}) {
	$previouspage = $frm{'previouspage'};
	} else {
       	if ($ERRORMODE==2 && $ENV{'HTTP_REFERER'} =~ /$ErrMsgRedirect/i) {
	$previouspage = $ErrMsgViewCart;
	} else {
	if ($frm{'RET_URL'}) {
	$previouspage = $frm{'RET_URL'};
	} else {			
	$previouspage = $ENV{'HTTP_REFERER'};
	}}}

	$msg_n = scalar(@orders);
	$msg_status = "Viewing $msg_n Items" if ($msg_n > 1);
	$msg_status = "Viewing $msg_n Item" if ($msg_n == 1);
	if ($msg_n == 0) {$msg_status = "Viewing No Items"}
	&GetTemplateFile($accept_order_template,"View Cart Main Template","accept_order_template");
	print "Content-Type: text/html\n\n";
	print "@header \n\n";
	$OrderID = $cookieOrderID if ($cookieOrderID);
	$OrderID = $OrderID if ($OrderID);
	# Insert MOF navigation at TOP
	$nav_top++ if ($menu_home_top);
	$nav_top++ if ($menu_previous_top);
	$nav_top++ if ($menu_help_top);
	$nav_top++ if ($menu_update_top);
	$nav_top++ if ($menu_delete_top);
	$nav_top++ if ($menu_preview_top);

	unless ($msg_n) {
	print "<SPAN Class=\"ValidationMessageText\">";
	print "Your Cart Is Empty<p></SPAN>"}

	if ($nav_top && $includeViewCart) {
	print "<table border=0 cellpadding=0 cellspacing=0><tr>\n";
	if ($menu_home_top) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"$menu_home_top_url\">$menu_home_top</a></td>\n";}
	if ($menu_previous_top) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"$previouspage\">$menu_previous_top</a></td>\n";}
	if ($menu_update_top && $msg_n) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"javascript:document.formUpdateCart.submit()\;\">$menu_update_top</a></td>\n";}
	if ($menu_delete_top && $msg_n) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"javascript:document.formDeleteCart.submit()\;\">$menu_delete_top</a></td>\n";}
	if ($menu_preview_top && $msg_n) {
	print "<td nowrap><a Class=\"TopNavNextLink\" href=\"javascript:document.formPreviewSubmit.submit()\;\">$menu_preview_top</a></td>\n";}
	if ($menu_help_top) {
	print "<td nowrap>\n";
	print "<a Class=\"TopNavLink\" href=\"$menu_help_top_url\" onclick=\"window.open(this.href,4,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">\n";
	print "$menu_help_top</a></td>\n";}
	print "</tr></table><br>\n\n";
	}

	# Update hidden POST AcceptOrder Quantities Form
	print "<FORM name=\"formUpdateCart\" method=POST action=\"$programfile\"> \n";
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%><tr><td> \n";
	print "<input type=hidden name=\"postmode\" value=\"UPDATE\"> \n";
	print "<input type=hidden name=\"OrderID\" value=\"$OrderID\"> \n";
	print "<input type=hidden name=\"previouspage\" value=\"$previouspage\"> \n\n";
	print "<table $action_message_bg border=0 cellpadding=0 cellspacing=0 width=300> \n";
	print "<tr><td><center> \n";
	print "$action_message_s $msg_status <br> ";
	print "$msg_function $action_message_e </center> </td> \n";
	print "</tr></table> \n";
	print "</td><td align=right> \n";
	print "<table border=0 cellpadding=0 cellspacing=0> \n";
		my($x) = "Order ID: $OrderID";
		$x = "<br>" unless ($show_order_id);
		my($y) = "$MyDate";
		$y = "<br>" unless ($y);
	print "<tr><td align=right nowrap>$datetime_s $x $datetime_e </td></tr>\n";
	print "<tr><td align=right nowrap>$datetime_s $y $datetime_e </td></tr> \n";
	print "</table> \n";
	print "</td></tr></table> \n";
	
	# printing orders in cart
	print "<table $tableborder_color cellpadding=1 cellspacing=0 width=98%> \n";
	print "<tr bgcolor=$tableheading> \n";
	print "<td align=center>$fontheading <strong>Qty</strong></font></td> \n";
	print "<td align=center nowrap>$fontheading <strong>Item Name</strong></font></td> \n";
	print "<td align=center>$fontheading <strong>Description</strong></font></td> \n";
	print "<td align=center>$fontheading <strong>Price</strong></td></font></tr> \n";

	# populate orders in table / store hidden input
	foreach $line (@orders) {
	++$i;
  	($qty, $item, $desc, $price, $ship, $taxit) = split (/$delimit/, $line);
   	print "<tr bgcolor=$tableitem> \n";
	print "<td align=center nowrap>$fontqnty </font>\n\n";
	print "<input Class=\"QuantityBoxFormat\" type=text name=\"quantity_$i\" value=\"$qty\" size=4 maxlength=4> \n";
	print "<a Class=\"TrashCanLink\" href=\"javascript:document.formTrash_$i.submit()\;\">$trash_can_icon</a>" if ($trash_can_mode);
	print "</td><td> \n";
	print "<input type=hidden name=\"product_$i\" ";
	print "value=\"$item$delimit$desc$delimit$price$delimit$ship$delimit$taxit\"> \n\n";
	$item =~ s/\[/</g;
	$item =~ s/\]/>/g;
	print "$fontitem $item </font></td> \n";

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
		print "<td>$desc </td> \n";

	# Print row for single item or multiple to sub totals
	if ($qty > 1 || $allow_fractions) {
	print "<td align=right>$fontprice \&nbsp\; </font></td></tr>\n";
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

	# Print Summary Totals
	if ($totalqnty > 1) {$pd = "Items"} else {$pd = "Item"}
	$Computations{'Primary_Price'} = $totalprice;
	$Computations{'Primary_Products'} = $totalqnty;
	$Computations{'Primary_Discount'} = &ComputeDiscount if scalar(@use_discount);
	my ($discountline) = $Computations{'Primary_Discount'};
	$discounttotal = ($totalprice - $Computations{'Primary_Discount'});
	$discounttotal = sprintf "%.2f", $discounttotal;
	$discounttotal = CommifyMoney ($discounttotal);
	$totalprice = sprintf "%.2f", $totalprice;
	$totalprice = CommifyMoney ($totalprice);
	$totalqnty = CommifyNumbers ($totalqnty);
	$Computations{'Primary_Discount'} = CommifyNumbers($Computations{'Primary_Discount'});

	# sub total
	print "<table border=0 cellpadding=2 cellspacing=0 width=98%> \n";
	print "<tr><td align=center>";
	if ($linkUpdateIMG && $msg_n) {
	print "<a Class=\"UpdateQuantityLink\" href=\"javascript:document.formUpdateCart.submit()\;\">";
	print "$linkUpdateIMG</a>\n";
	} else {
	print "<br>";
	}
	print "</td><td align=right width=60%>$totaltext Subtotal <strong> \n";
	print "$totalqnty </strong> $pd : </font></td> \n";
	print "<td bgcolor=$totalback align=right nowrap> ";
	print "$totalcolor $currency $totalprice </font></td></tr>\n";

	# default discount
	if ($discountline > 0 || $Computations{'Primary_Discount_Line_Override'}) {
	print "<tr><td><br></td><td align=right width=60%>$totaltext \n";
	print "$Computations{'Primary_Discount_Status'} : </font></td> \n";
	print "<td bgcolor=$totalback align=right nowrap> ";
	print "$totalcolor ";
		if ($discountline == 0 && $Computations{'Primary_Discount_Amt_Override'}) {
		print "$Computations{'Primary_Discount_Amt_Override'} ";
		} else {
		print "<font color=red>-</font> $currency $Computations{'Primary_Discount'} ";
		}
	print "</font></td></tr>\n";

	# sub total after default discount
	print "<tr><td><br></td><td align=right width=60%>$totaltext <strong> Subtotal \n";
	print "After Discount</strong> : </font></td> \n";
	print "<td bgcolor=$totalback align=right nowrap> ";
	print "$totalcolor $currency $discounttotal </font></td></tr>\n";
	}
	print "</table><p> ";
	
	# Bottom Navigation Menu
	print "<table border=0 cellpadding=0 cellspacing=0><tr>\n";
	if ($menu_home_bottom) {
	print "<td valign=top nowrap><a href=\"$menu_home_bottom_url\">$menu_home_bottom</a></td>\n";}
	if ($menu_previous_bottom) {
	print "<td valign=top nowrap><a href=\"$previouspage\">$menu_previous_bottom</a></td>\n";}
	# Update FORM ends here, Can only start another FORM POST now
	print "<td valign=top>$menu_update_bottom</FORM></td>\n";
	if ($menu_delete_bottom && $msg_n) {
	print "<td valign=top>";
	print "<FORM name=\"formDeleteCart\" method=POST action=\"$programfile\">\n";
	print "<input type=hidden name=\"postmode\" value=\"DELETE\">\n";
	print "<input type=hidden name=\"deleted_items\" value=\"$msg_n\">\n";
	print "<input type=hidden name=\"OrderID\" value=\"$OrderID\">\n";
	print "<input type=hidden name=\"previouspage\" value=\"$previouspage\">\n";
	print "$menu_delete_bottom</FORM></td>\n";
	}
	if ($menu_preview_bottom && $msg_n) {
	print "<td valign=top>";
	print "<FORM name=\"formPreviewSubmit\" method=POST action=\"$programfile\">\n";
	print "<input type=hidden name=\"postmode\" value=\"PREVIEW\">\n";
	print "<input type=hidden name=\"OrderID\" value=\"$OrderID\">\n";
	print "<input type=hidden name=\"previouspage\" value=\"$previouspage\">\n";
	foreach $line (@orders) {print "<input type=hidden name=\"order\" value=\"$line\">\n"}
	print "$menu_preview_bottom</FORM></td>\n";
	}
	if ($menu_help_bottom) {
	print "<td valign=top>\n";
	print "<a href=\"$menu_help_bottom_url\" onclick=\"window.open(this.href,4,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">\n";
	print "$menu_help_bottom</a></td>\n";}
	print "</tr></table>";

	if ($msg_n) {
	print "<font size=2><p>If you changed any quantities, click ";
	print "<strong>Re-calculate </strong> before proceeding to ";
	print "<strong>next</strong>. </font>";
	} else {
	print "<SPAN Class=\"ValidationMessageText\">";
	print "<font size=2><p>There are no items in your cart<br></SPAN>";
	print "You can return to your ";
	print "<a Class=\"TextLink\" href=\"$previouspage\">Previous Shopping Page</a><br>";
	print "Or you can return to our ";
	print "<a Class=\"TextLink\" href=\"$menu_home_bottom_url\">Site's Main Page</a></font>";
	}

	# set up trashcan mode
	if ($trash_can_mode) {
	my ($i, $ii) = (0,0);
	print "\n\n";
	foreach $line (@orders) {
	++$i;
	print "<FORM name=\"formTrash_$i\" method=POST action=\"$programfile\">\n";
	print "<input type=hidden name=\"postmode\" value=\"UPDATE\">\n";
	print "<input type=hidden name=\"OrderID\" value=\"$OrderID\">\n";
	print "<input type=hidden name=\"previouspage\" value=\"$previouspage\">\n";
		$ii=0;
		foreach (@orders) {
  		unless ($line eq $_) {
		++$ii;
  		($qty, $item, $desc, $price, $ship, $taxit) = split (/$delimit/, $_);
		print "<input type=hidden name=\"quantity_$ii\" value=\"$qty\">\n";
		print "<input type=hidden name=\"product_$ii\" ";
		print "value=\"$item$delimit$desc$delimit$price$delimit$ship$delimit$taxit\">\n";
		}}
	print "</FORM>\n";
	}}
	print "$returntofont\n";
	print "@footer \n\n";
 }


# ===================================================================== #
#          HOW TO ADD NEW FIELDS TO THE SHIPPING INFO PAGE              #
# ===================================================================== #
# 1. ADD FIELD(S)                                                       #
#    * Add the field to the printed HTML this section                   #
# 2. ADD FIELD(S) TO MASTER INFO LIST                                   #
#    * List the new field name(s) in [GetMasterInfoList] array          #
#    * This will create new Field(s) in InfoFile storage                #
#    * You must list new Field(s) to store whether required or not      #
# 3. ADD FIELD(S) to USING INFO FIELDS (if required)                    #
#    * If Field(s) required Add to [CheckFieldsNeeded]                  #
#    * push to UsingInfoFields array, a list of all required Field(s)   #
# 4. ADD ANY VALIDATION NEEDED                                          #
#    * If required, validate new Field(s) in [CheckUsingInfoFields]     #
#    * which validates and flags in MissingInfoFields array if          #
#    * there is anything "Missing" or "Incomplete"                      #
# 5. ADD DISPLAY FLAGS (if desired)                                     #
#    * Use the sub routine [ValidatePreviewFields] to set up proper     #
#    * display flag (Missing/Incomplete) on PreviewInformation page     #
# NOTE: If PreviewInformation page reloads, because validation failed   #
#    * we can only prefill a text box.  We cannot Find the already      #
#    * selected value of a drop box, list box, radio button, checkbox   #
#    * unless you write a routine for matching the returning input      #
# 6. SET NEW FIELD(S) TO PRINT WHERE NEEDED                             #
#    * To print at [PreviewOrder] use $NewInfo{'NewField'}              #
#    * %NewInfo fields will automatically parse as hidden to mofpay     #
#    * Use $frm{'NewField'} to print in <mofpay.cgi><invoice.pl>        #
#    * <merchant.mail><customer.mail>                                   #
# ===================================================================== #


# PREVIEW INFORMATION
sub PreviewInformation {
	my ($itm_n)=0;
	my ($key, $val);
	my (@InsuranceList) = ();
	my (@MethodList) = ();
	$msg_v;
	@country_list = ();
	@state_list = ();
	($allow_shipping, $allow_tax) = (0,0);

	# how many items failed validation
	$itm_m = scalar(keys(%MissingInfoFields));

	# using shipping and/or tax flags
	$allow_shipping++ if (scalar(@use_shipping));
	$allow_shipping++ if (scalar(keys(%use_method)));
	$allow_tax++ if (scalar(keys(%use_city_tax)));
	$allow_tax++ if (scalar(keys(%use_zipcode_tax)));
	$allow_tax++ if (scalar(keys(%use_state_tax)));
	$allow_tax++ if (scalar(keys(%use_country_tax)));
	
	@country_list = (&GetDropBoxList($use_country_list,'Ecom_ShipTo_Postal_CountryCode')) if ($use_country_list);
	@state_list = (&GetDropBoxList($use_state_list,'Ecom_ShipTo_Postal_StateProv')) if ($use_state_list);
	&GetTemplateFile($preview_info_template,"Shipping Information Template","preview_info_template");

	# you must call any sub routine that can ErrorMessage(ErrMsg)
	# BEFORE you set up the print Content-Type header

	# HTML output
	print "Content-Type: text/html\n\n";
	print "@header \n\n";
	# Insert MOF navigation at TOP
	$nav_top++ if ($menu_home_top);
	$nav_top++ if ($menu_previous_top);
	$nav_top++ if ($menu_viewcart_top);
	$nav_top++ if ($menu_preview_top);
	$nav_top++ if ($menu_help_top);

	if ($nav_top && $includeShipInfo) {
	print "<table border=0 cellpadding=0 cellspacing=0><tr>\n";
	if ($menu_home_top) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"$menu_home_top_url\">$menu_home_top</a></td>\n";}
	if ($menu_previous_top) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"$frm{'previouspage'}\">$menu_previous_top</a></td>\n";}
	if ($menu_viewcart_top) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"$programfile?viewcart&previouspage=$frm{'previouspage'}\">$menu_viewcart_top</a></td>\n";}
	if ($menu_preview_top) {
	print "<td nowrap><a Class=\"TopNavNextLink\" href=\"javascript:document.formPreviewSubmit.submit()\;\">$menu_preview_top</a></td>\n";}
	if ($menu_help_top) {
	print "<td nowrap>\n";
	print "<a Class=\"TopNavLink\" href=\"$menu_help_top_url\" onclick=\"window.open(this.href,4,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">\n";
	print "$menu_help_top</a></td>\n";}
	print "</tr></table><br>\n";
	}

		if ($itm_m == 1) {$fld = "Field is"}
		else {$fld = "Fields are"}
	if ($msg_function eq "FOUNDATA") {
	print "Enter all information below. $itm_m $fld incomplete. ";
	print "When the information is complete, continue by clicking the ";
	print "<strong>next</strong> button.";
	} elsif ($msg_function eq "EDITING") {
	print "When finished changing your information, ";
	print "click the <strong>next</strong> button to see your Order Summary.";
	} elsif ($msg_function eq "NEWSUBMIT") {
	print "<SPAN Class=\"ValidationMessageText\">";
	print "Some information for $itm_m $fld missing or incomplete. ";
	print "Complete all required information and continue by clicking the ";
	print "<strong>next</strong> button.";
		if ($MissingInfoFields{'Ecom_ShipTo_Online_Email'} eq "Incomplete") {
		print "  <font color=red>Email appears incomplete</font>.";
		}
	print "</SPAN>";
	} elsif ($msg_function eq "NEWLIST") {
	print "Enter all information below. $itm_m $fld required. ";
	print "When the information is complete, continue by clicking the ";
	print "<strong>next</strong> button.";
	}

	print "<P>";
	print "<FORM name=\"formPreviewSubmit\" method=POST action=\"$programfile\"> \n";
	print "<input type=hidden name=\"postmode\" value=\"PREVIEW\"> \n";
	print "<input type=hidden name=\"submit_preview_info\" value=\"NEWSUBMIT\"> \n";
	print "<input type=hidden name=\"OrderID\" value=\"$frm{'OrderID'}\"> \n";
	print "<input type=hidden name=\"InfoID\" value=\"$InfoID\"> \n";
	print "<input type=hidden name=\"previouspage\" value=\"$frm{'previouspage'}\"> \n\n";
	foreach $line (@orders) {print "<input type=hidden name=\"order\" value=\"$line\"> \n"}
	print " \n\n";

	# Shipping or just tax Message ?
	if ($allow_shipping || $allow_tax) {
	$itm_n++;

	if ($allow_shipping) {
	$box_heading = "Enter Shipping Destination:";
	$box_message = "We need the shipping destination to compute any fees for shipping, handling, tax.";
	} else {
	$box_heading = "Enter Tax Location:";
	$box_message = "We need the taxing location to assess any applicable taxes.";
	}

	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5% nowrap><font size=3><strong>$itm_n.</strong></font></td> \n";
	print "<td  width=95%>$preview_heading \n";
	print "<strong>$box_heading </font></strong>";
	print "<font color=red size=1> EDITING </font>" if ($msg_function eq "EDITING");
	print "</font></td></tr> \n";
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%>$preview_text \n";
	print "$box_message </font></td></tr>\n";
	print "<tr><td colspan=2><font size=1><br></font></td></tr></table> \n";

	# shipping-tax box input
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5%><br></td>  \n";
	print "<td> \n\n";

	print "<table border=0 cellpadding=2 cellspacing=0 bgcolor=$font_outside_line><tr><td> \n";
	print "<table border=0 cellpadding=2 cellspacing=0> \n";

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Postal_Name_Prefix'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_preview_titles Title:</font></td> \n";
	print "<td bgcolor=$font_right_column></font> \n";
	print "<input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_Name_Prefix\" value=\"$NewInfo{'Ecom_ShipTo_Postal_Name_Prefix'}\" size=4></td>";
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Postal_Name_Prefix'));
	print "<td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Postal_Name_First'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_preview_titles First Name:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_Name_First\" value=\"$NewInfo{'Ecom_ShipTo_Postal_Name_First'}\" size=36></td>";
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Postal_Name_First'));
	print "<td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Postal_Name_Middle'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_preview_titles Middle Name:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_Name_Middle\" value=\"$NewInfo{'Ecom_ShipTo_Postal_Name_Middle'}\" size=36></td>";
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Postal_Name_Middle'));
	print "<td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Postal_Name_Last'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_preview_titles Last Name:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_Name_Last\" value=\"$NewInfo{'Ecom_ShipTo_Postal_Name_Last'}\" size=36></td>";
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Postal_Name_Last'));
	print "<td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Postal_Name_Suffix'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_preview_titles Last Name Suffix:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_Name_Suffix\" value=\"$NewInfo{'Ecom_ShipTo_Postal_Name_Suffix'}\" size=4></td>";
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Postal_Name_Suffix'));
	print "<td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Postal_Company'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_preview_titles Company Name:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_Company\" value=\"$NewInfo{'Ecom_ShipTo_Postal_Company'}\" size=36></td>";
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Postal_Company'));
	print "<td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Postal_Street_Line1'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_preview_titles Address:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_Street_Line1\" value=\"$NewInfo{'Ecom_ShipTo_Postal_Street_Line1'}\" size=36></td>";
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Postal_Street_Line1'));
	print "<td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Postal_Street_Line2'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_preview_titles Address:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_Street_Line2\" value=\"$NewInfo{'Ecom_ShipTo_Postal_Street_Line2'}\" size=36></td>";
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Postal_Street_Line2'));
	print "<td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Postal_City'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_preview_titles City:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_City\" value=\"$NewInfo{'Ecom_ShipTo_Postal_City'}\" size=30></td>";
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Postal_City'));
	print "<td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Postal_StateProv'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>";
	print "$font_preview_titles State - Province:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	# Does state field use Drop Box
	if ($use_state_list) {
	print "<select Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_StateProv\"> \n";
	foreach $itm_db (@state_list) {print "$itm_db \n"}
	print "</select> \n";
	} else {
	print " <input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_StateProv\" value=\"$NewInfo{'Ecom_ShipTo_Postal_StateProv'}\" size=30>";
	}
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Postal_StateProv'));
	print "</td><td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Postal_Region'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_preview_titles * Region:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_Region\" value=\"$NewInfo{'Ecom_ShipTo_Postal_Region'}\" size=30></td>";
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Postal_Region'));
	print "<td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Postal_PostalCode'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_preview_titles Postal Code:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_PostalCode\" value=\"$NewInfo{'Ecom_ShipTo_Postal_PostalCode'}\" size=30></td>";
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Postal_PostalCode'));
	print "<td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Postal_CountryCode'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>";
	print "$font_preview_titles Country:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	# Does country field use Drop Box
	if ($use_country_list) {
	print "<select Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_CountryCode\"> \n";
	foreach $itm_db (@country_list) {print "$itm_db \n"}
	print "</select> \n";
	} else {
	print " <input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Postal_CountryCode\" value=\"$NewInfo{'Ecom_ShipTo_Postal_CountryCode'}\" size=30>";
	}
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Postal_CountryCode'));
	print "</td><td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Telecom_Phone_Number'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_preview_titles Phone Number:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Telecom_Phone_Number\" value=\"$NewInfo{'Ecom_ShipTo_Telecom_Phone_Number'}\" size=36></td>";
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Telecom_Phone_Number'));
	print "<td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	if (exists ($shipping_destination_fields{'Ecom_ShipTo_Online_Email'})) {
	print "<tr><td align=right bgcolor=$font_left_column nowrap>$font_preview_titles E-mail Address:</font></td> \n";
	print "<td bgcolor=$font_right_column> \n";
	print "<input Class=\"ShippingBoxFormat\" name=\"Ecom_ShipTo_Online_Email\" value=\"$NewInfo{'Ecom_ShipTo_Online_Email'}\" size=36></td>";
	$msg_v = (&ValidatePreviewFields('Ecom_ShipTo_Online_Email'));
	print "<td bgcolor=$preview_message_bg nowrap>$msg_v </td></tr> \n";
	}

	print "</table>";
	print "</td></tr></table> \n";
	print "</td></tr>";

	if ($force_state_message) {
	if (exists($shipping_destination_fields{'Ecom_ShipTo_Postal_Region'})) {
	print "<tr><td width=5% align=right valign=top>$font_preview_titles * </font></td> \n";
	print "<td width=95%>$font_preview_titles $force_state_message </font></td></tr>\n";
	}}

	print "<tr><td colspan=2><font size=1><br></font></td></tr>";
	print "</table> \n";

	# tax exempt status
	if ($allow_tax || $use_global_tax) {
	if ($tax_exempt_status) {
	$itm_n++;
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5% nowrap><font size=3><strong>$itm_n.</strong></font></td> \n";
	print "<td  width=95%>$preview_heading \n";
	print "<strong>Do You Have Tax Exempt Status ?</font></strong>";
	print "<font color=red size=1> EDITING</font>" if ($msg_function eq "EDITING");
	print "</td></tr> \n";
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%>$preview_text \n";
	print "Enter your Tax ID or VAT number below, otherwise leave this box blank. ";

		# print extra message if ID/VAT fails validation
		if ($MissingInfoFields{'Tax_Exempt_Status'} eq "Incomplete") {
		print "<b>The ID or VAT number appears incorrect</b>.";}

	print "</font></td></tr>\n";
	print "<tr><td colspan=2><font size=1><br></font></td></tr> \n";
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%> \n";
	if ( $NewInfo{'Tax_Exempt_Status'} ) {
	print "<input Class=\"ShippingBoxFormat\" name=\"Tax_Exempt_Status\" value=\"$NewInfo{'Tax_Exempt_Status'}\" size=30></font> \n";
	} else {
	print "<input Class=\"ShippingBoxFormat\" name=\"Tax_Exempt_Status\" value=\"\" size=30></font> \n";
	}
	$msg_v = (&ValidatePreviewFields('Tax_Exempt_Status'));
	print " $msg_v";
	print "</td></tr>\n";
	print "<tr><td colspan=2><font size=1><br></font></td></tr> \n";
	print "</td></tr></table> \n";
	}}

	# shipping method
	if (scalar(keys(%use_method))) {
	$itm_n++;
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5% nowrap><font size=3><strong>$itm_n.</strong></font></td> \n";
	print "<td  width=95%>$preview_heading \n";
	print "<strong>Select Shipping Method:</strong></font>";
	print "<font color=red size=1> EDITING</font>" if ($msg_function eq "EDITING");
	print "</td></tr> \n";

	if ($link_shipping) {

	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%>$preview_text \n";

	print "<a Class=\"TextLink\" href=\"$link_shipping_url\" onclick=\"window.open(this.href,14,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">";
	print "$link_shipping</a>\n";
	print "</font></td></tr>\n";

	}

	print "<tr><td colspan=2><font size=1><br></td></tr> \n";
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%>$preview_text \n";

	# Build options
	@MethodList = (sort keys(%use_method));
	if ($type_method_options =~ /\bdropbox\b/i) {
	print "<select Class=\"ShippingBoxFormat\" name=\"Compute_Shipping_Method\"> \n";
	foreach $_ (@MethodList) {
	if ($NewInfo{'Compute_Shipping_Method'}) {
		if ($NewInfo{'Compute_Shipping_Method'} eq $_) {
		print "<option selected value=\"$_\"> $use_method{$_} \n";
		} else {
		print "<option value=\"$_\"> $use_method{$_} \n";
		}
	} else {
		if ($default_method eq $_) {
		print "<option selected value=\"$_\"> $use_method{$_} \n";
		} else {
		print "<option value=\"$_\"> $use_method{$_} \n";
		}
	}
	}
	print "</select> \n";
	} elsif ($type_method_options =~ /\bradio\b/i) {
	foreach $_ (@MethodList) {
	if ($NewInfo{'Compute_Shipping_Method'}) {
		if ($NewInfo{'Compute_Shipping_Method'} eq $_) {
		print "<input Class=\"ShippingRadioFormat\" type=radio name=\"Compute_Shipping_Method\" value=\"$_\" checked=\"on\"> $use_method{$_} <br>\n";
		} else {
		print "<input Class=\"ShippingRadioFormat\" type=radio name=\"Compute_Shipping_Method\" value=\"$_\"> $use_method{$_} <br>\n";
		}
	} else {
		if ($default_method eq $_) {
		print "<input Class=\"ShippingRadioFormat\" type=radio name=\"Compute_Shipping_Method\" value=\"$_\" checked=\"on\"> $use_method{$_} <br>\n";
		} else {
		print "<input Class=\"ShippingRadioFormat\" type=radio name=\"Compute_Shipping_Method\" value=\"$_\"> $use_method{$_} <br>\n";	
		}
	}
	}
	}
	print "</font></td></tr>\n";
	print "<tr><td colspan=2><font size=1><br></font></td></tr> \n";
	print "</td></tr></table> \n";
	}

	# insurance options
	if (scalar(keys(%use_insurance)) && $allow_shipping) {
	$itm_n++;
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5% nowrap><font size=3><strong>$itm_n.</strong></font></td> \n";
	print "<td  width=95%>$preview_heading \n";
	print "<strong>Select Insurance Options:</font></strong>";
	print "<font color=red size=1> EDITING</font>" if ($msg_function eq "EDITING");
	print "</td></tr> \n";
	# print "<tr><td width=5%><br></td> \n";
	# print "<td width=95%>$preview_text \n";
	# print "PUT OTHER TEXT FOR INSURANCE AREA.</font></td></tr>\n";
	print "<tr><td colspan=2><font size=1><br></font></td></tr> \n";
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%>$preview_text \n";

	# Build options
    	@InsuranceList = sort { $a <=> $b } (values %use_insurance);
	if ($type_insurance_options =~ /\bdropbox\b/i) {
	print "<select Class=\"ShippingBoxFormat\" name=\"Compute_Insurance\"> \n";
	foreach $_ (@InsuranceList) {
		while (($key, $val) = each (%use_insurance)) {		
			if ($_ == $val) {
				if ($NewInfo{'Compute_Insurance'} == $val) {
				print "<option selected value=\"$val\">$key \n";
				} else {
				print "<option value=\"$val\">$key \n";
				}
			}
		}
	}
	print "</select> \n";
	} elsif ($type_insurance_options =~ /\bradio\b/i) {
	foreach $_ (@InsuranceList) {
		while (($key, $val) = each (%use_insurance)) {		
			if ($_ == $val) {
				if ($NewInfo{'Compute_Insurance'} == $val) {
				print "<input Class=\"ShippingRadioFormat\" type=radio name=\"Compute_Insurance\" value=\"$val\" checked=\"on\"> $key <br>\n";
				} else {
				print "<input Class=\"ShippingRadioFormat\" type=radio name=\"Compute_Insurance\" value=\"$val\"> $key <br>\n";
				}
			}
		}
	}
	}
	print "</font></td></tr>\n";
	print "<tr><td colspan=2><font size=1><br></font></td></tr> \n";
	print "</td></tr></table> \n";
	} # End use_insurance
	} # End overall usage of tax, address, method, insurance

	# discount coupons
	unless ($use_ARES) {
	if (scalar(@use_coupons)) {
	$itm_n++;
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%> \n";
	print "<tr><td width=5% nowrap><font size=3><strong>$itm_n.</strong></font></td> \n";
	print "<td  width=95%>$preview_heading \n";
	print "<strong>Do You Have Any Discount Coupons ?</font></strong>";
	print "<font color=red size=1> EDITING</font>" if ($msg_function eq "EDITING");
	print "</td></tr> \n";
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%>$preview_text \n";
	print "Enter any discount coupon numbers or codes here. <br>";
	print "Enter None or New Member if you have none. </font></td></tr>\n";
	print "<tr><td colspan=2><font size=1><br></font></td></tr> \n";
	print "<tr><td width=5%><br></td> \n";
	print "<td width=95%> \n";

	if ( $NewInfo{'Compute_Coupons'} ) {
	print "<input Class=\"ShippingBoxFormat\" name=\"Compute_Coupons\" value=\"$NewInfo{'Compute_Coupons'}\" size=30></font> \n";
	} else {
	print "<input Class=\"ShippingBoxFormat\" name=\"Compute_Coupons\" value=\"$default_coupon\" size=30></font> \n";
	}
	$msg_v = (&ValidatePreviewFields('Compute_Coupons'));
	print " $msg_v";
	print "</td></tr>\n";
	print "<tr><td colspan=2><font size=1><br></font></td></tr> \n";
	print "</td></tr></table> \n";
	}
	}

	# Submit Preview Information Menu
	print "<table border=0 cellpadding=0 cellspacing=0 width=98%>\n";
	print "<tr><td width=5%><br></td><td width=95%>\n";
	print "<table border=0 cellpadding=0 cellspacing=0><tr>\n";
	if ($menu_home_bottom) {
	print "<td valign=top nowrap><a href=\"$menu_home_bottom_url\">$menu_home_bottom</a></td>\n";}
	if ($menu_previous_bottom) {
	print "<td valign=top nowrap><a href=\"$frm{'previouspage'}\">$menu_previous_bottom</a></td>\n";}
	if ($menu_editcart_bottom) {
	print "<td valign=top nowrap>";
	print "<a href=\"$programfile?viewcart&previouspage=$frm{'previouspage'}\">";
	print "$menu_editcart_bottom</a></td>\n";
	}
	# Submit Preview FORM ends here
	print "<td valign=top>$menu_preview_bottom</FORM></td>\n";
	if ($menu_help_bottom) {
	print "<td valign=top>\n";
	print "<a href=\"$menu_help_bottom_url\" onclick=\"window.open(this.href,4,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">\n";
	print "$menu_help_bottom</a></td>\n";}
	print "</tr></table>";
	print "</td></tr></table>\n";

	# DEBUG PREVIEW INFO PAGE
	# print "<br><hr><u><strong>\%MissingInfoFields</strong></u>";
	# while (($key, $val) = each (%MissingInfoFields)){print "<li>$key, <strong>$val</strong> \n"}
	# print "<br><hr><u><strong>\%NewInfo</strong> Global Array </u>";
   	# while (($key, $val) = each (%NewInfo)) {print "<li>$key, <strong>$val</strong> \n"}
	# print "<hr><strong><u>\@UsingInfoFields</u></strong>";
	# foreach $_ (@UsingInfoFields) {print "<li>$_"}
	# print "<br><hr><u><strong>\%shipping_destination_fields</strong> CONFIG</u>";
   	# while (($key, $val) = each (%shipping_destination_fields)) {print "<li>$key, $val \n"}
	# print "<br><hr><u><strong>All Global Vars</strong></u>";
	# print "<li>UseStateProv = $UseStateProv";
	# print "<li>postmode = $frm{'postmode'}";
	# print "<li>submit_preview_info = $frm{'submit_preview_info'}";
	# print "<li>FRM-OrderID = $frm{'OrderID'}";
	# print "<li>OrderID = $OrderID";
	# print "<li>FRM-InfoID = $frm{'InfoID'}";
	# print "<li>InfoID = $InfoID";
	# print "<li>previouspage = $frm{'previouspage'}";
	# print "<li>msg_i = $msg_i";
	# print "<li>cookieOrderID = $cookieOrderID";
	# print "<li>cookieInfoID = $cookieInfoID";
	# TESTING ORDERS ARRAY
	# print "<font size=2><br><hr>\n";
	# print "<u><strong>\@orders</strong> Main List</u>";
	# foreach $line (@orders) {print "<li>$line";}

	print "$returntofont\n";
	print "@footer \n\n";
  }

# PREVIEW INVOICE ORDER
sub PreviewOrder {
	@header = ();
	@footer = ();
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
	my ($FinalAmount) = CommifyMoney ($Computations{'Final_Amount'});
	my ($FinalProducts) = CommifyNumbers ($Computations{'Primary_Products'});
	my ($msg_tab);
	my ($msg_tab_ck) = 0;
	$msg_status = "$FinalProducts Items " if ($Computations{'Primary_Products'} > 1);
	$msg_status = "$FinalProducts Item " if ($Computations{'Primary_Products'} == 1);
	$msg_status = $msg_status . " $currency $FinalAmount ";

	# using shipping and/or tax flags
	$allow_shipping++ if (scalar(@use_shipping));
	$allow_shipping++ if (scalar(keys(%use_method)));
	$allow_tax++ if (scalar(keys(%use_city_tax)));
	$allow_tax++ if (scalar(keys(%use_zipcode_tax)));
	$allow_tax++ if (scalar(keys(%use_state_tax)));
	$allow_tax++ if (scalar(keys(%use_country_tax)));
	&GetTemplateFile($preview_template,"Order Summary, Order Preview Template","preview_template");
	print "Content-Type: text/html\n\n";
	print "@header \n\n";
	# Insert MOF navigation at TOP
	$nav_top++ if ($menu_home_top);
	$nav_top++ if ($menu_previous_top);
	$nav_top++ if ($menu_viewcart_top);
	$nav_top++ if ($menu_shipinfo_top);
	$nav_top++ if ($menu_payment_top);
	$nav_top++ if ($menu_help_top);

	if ($nav_top && $includeOrderSummary) {
	print "<table border=0 cellpadding=0 cellspacing=0><tr>\n";
	if ($menu_home_top) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"$menu_home_top_url\">$menu_home_top</a></td>\n";}
	if ($menu_previous_top) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"$frm{'previouspage'}\">$menu_previous_top</a></td>\n";}
	if ($menu_viewcart_top) {
	print "<td nowrap>";
	print "<a Class=\"TopNavLink\" href=\"$programfile?viewcart&previouspage=$frm{'previouspage'}\">";
	print "$menu_viewcart_top</a></td>\n";}
	if ($menu_shipinfo_top) {
	if ($allow_shipping || $allow_tax) {
	print "<td nowrap><a Class=\"TopNavLink\" href=\"javascript:document.formShipInfo.submit()\;\">$menu_shipinfo_top</a></td>\n";
	}}
	if ($menu_payment_top) {
	print "<td nowrap><a Class=\"TopNavNextLink\" href=\"javascript:document.formCheckout.submit()\;\">$menu_payment_top</a></td>\n";}
	if ($menu_help_top) {
	print "<td nowrap>\n";
	print "<a Class=\"TopNavLink\" href=\"$menu_help_top_url\" onclick=\"window.open(this.href,4,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">\n";
	print "$menu_help_top</a></td>\n";}
	print "</tr></table><br>\n";
	}

	print "<table border=0 cellpadding=0 cellspacing=0 width=98%><tr><td width=300> \n";
	print "<table $action_message_bg_preview border=0 cellpadding=0 cellspacing=0 width=300 height=100%> \n";

	# Display shipping info, etc.
	print "<tr><td valign=bottom> \n";
	print "<table border=0 cellpadding=6 cellspacing=0 width=100% height=100%> ";
	print "<tr><td> \n";

	if ($allow_shipping) {
	$msg_tab = "<font size=1 color=black>SHIP TO: </font><br>" ;	
	} elsif ($allow_tax) {
	$msg_tab = "<font size=1 color=black>TAX AREA: </font><br>"
	} else {
	$msg_tab = "<font size=1 color=black>ORDER PREVIEW: </font><br>" ;	
	$msg_tab = $msg_tab . "$action_message_s $msg_status $action_message_e\n"
	}

	print "$msg_tab </font>\n";
	print "$action_message_s \n";
	print "<a Class=\"ShipToTabLink\" href=\"javascript:document.formShipInfo.submit()\;\">" if ($linkActualInfo);
	$edit_check_top = 0;
	if ($NewInfo{'Ecom_ShipTo_Postal_Name_Prefix'}) {
	print "$NewInfo{'Ecom_ShipTo_Postal_Name_Prefix'} \n";
	$msg_tab_ck++;
	$edit_check_top++;
	}
	if ($NewInfo{'Ecom_ShipTo_Postal_Name_First'}) {
	print "$NewInfo{'Ecom_ShipTo_Postal_Name_First'} \n";
	$msg_tab_ck++;
	$edit_check_top++;
	}
	if ($NewInfo{'Ecom_ShipTo_Postal_Name_Middle'}) {
	print "$NewInfo{'Ecom_ShipTo_Postal_Name_Middle'} \n";
	$msg_tab_ck++;
	$edit_check_top++;
	}
	if ($NewInfo{'Ecom_ShipTo_Postal_Name_Last'}) {
	print "$NewInfo{'Ecom_ShipTo_Postal_Name_Last'} \n";
	$msg_tab_ck++;
	$edit_check_top++;
	}
	if ($NewInfo{'Ecom_ShipTo_Postal_Name_Suffix'}) {
	print "$NewInfo{'Ecom_ShipTo_Postal_Name_Suffix'} \n";
	$msg_tab_ck++;
	$edit_check_top++;
	}
	print "<br>" if ($msg_tab_ck);
	$msg_tab_ck = 0;
	if ($NewInfo{'Ecom_ShipTo_Postal_Company'}) {
	print "$NewInfo{'Ecom_ShipTo_Postal_Company'} <br>\n";
	$edit_check_top++;
	}
	if ($NewInfo{'Ecom_ShipTo_Postal_Street_Line1'}) {
	print "$NewInfo{'Ecom_ShipTo_Postal_Street_Line1'} <br>\n";
	$edit_check_top++;
	}
	if ($NewInfo{'Ecom_ShipTo_Postal_Street_Line2'}) {
	print "$NewInfo{'Ecom_ShipTo_Postal_Street_Line2'} <br>\n";
	$edit_check_top++;
	}
	if ($NewInfo{'Ecom_ShipTo_Postal_City'}) {
	print "$NewInfo{'Ecom_ShipTo_Postal_City'} \n";
	$msg_tab_ck++;
	$edit_check_top++;
	}
	if ($NewInfo{'Ecom_ShipTo_Postal_StateProv'}) {
	unless ($NewInfo{'Ecom_ShipTo_Postal_StateProv'} eq "NOTINLIST") {
	my ($sc) = $NewInfo{'Ecom_ShipTo_Postal_StateProv'};
	$sc =~ s/-/ /g;
	print "$sc \n";
	$msg_tab_ck++;
	$edit_check_top++;
	}
	}
	if ($NewInfo{'Ecom_ShipTo_Postal_Region'}) {
	print "$NewInfo{'Ecom_ShipTo_Postal_Region'} \n";
	$msg_tab_ck++;
	$edit_check_top++;
	}
	if ($NewInfo{'Ecom_ShipTo_Postal_PostalCode'}) {
	print "$NewInfo{'Ecom_ShipTo_Postal_PostalCode'} \n";
	$edit_check_top++;
	}
	print "<br>" if ($msg_tab_ck);
	$msg_tab_ck = 0;
	if ($NewInfo{'Ecom_ShipTo_Postal_CountryCode'}) {
	my ($tc) = $NewInfo{'Ecom_ShipTo_Postal_CountryCode'};
	$msg_tab_ck++;
	$tc =~ s/-/ /g;
	print "$tc \n";
	$edit_check_top++;
	}
	
	print "</a>" if ($linkActualInfo);
	print "$action_message_e </td></tr></table> \n";
	print "</td> \n";
	print "</tr></table> \n";

	# Top Edit Button - Can't edit unless ship or tax
	if ($allow_shipping || $allow_tax) {
	if ($linkActualIMG) {
	print "</td><td valign=center> \n";
	print "<a Class=\"EditShippingIMG\" href=\"javascript:document.formShipInfo.submit()\;\">";
	print "$linkActualIMG</a>";
	}}

	# Displaying OrderID Date
	print "</td><td align=right valign=bottom> \n";
	print "<table border=0 cellpadding=0 cellspacing=0> \n";
		my($x) = "Order ID: $OrderID";
		$x = "<br>" unless ($show_order_id);
		my($y) = "$MyDate";
		$y = "<br>" unless ($y);
	print "<tr><td align=right nowrap>$datetime_s $x $datetime_e </td></tr>\n";
	print "<tr><td align=right nowrap>$datetime_s $y $datetime_e </td></tr> \n";
	print "</table> \n";
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
	if ($Computations{'Tax_Amount'} > 0 && $identify_tax_items && $taxit) {
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
			$desc = $desc . "$font_key_s$lk $font_key_e$font_val_s$lv$font_val_e";
			}
		}
	 	$desc =~ s/\[/</g;
		$desc =~ s/\]/>/g;
		$desc = $fontdesc_s . $desc . $fontdesc_e;
		print "<td>$desc </td> \n";

	# Print row for single item or multiple to sub totals
	if ($qty > 1 || $allow_fractions) {
	print "<td align=right>$fontprice \&nbsp\; </font></td></tr>\n";
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

	# Right Summary tables
	print "<table border=0 cellpadding=2 cellspacing=0 width=98%>\n";

	# Display Summary Totals
	if ($totalqnty > 1) {$pd = "Items"} else {$pd = "Item"}
	$totalprice = sprintf "%.2f", $totalprice;
	$totalprice = CommifyMoney ($totalprice);
	$totalqnty = CommifyNumbers ($totalqnty);
	print "<tr><td align=right width=80% nowrap>";
	if ($linkHaveCouponsIMG && !$use_ARES && scalar(@use_coupons) && $Computations{'Coupon_Discount'}==0) {
	print "<a Class=\"EditShippingIMG\" href=\"javascript:document.formShipInfo.submit()\;\">$linkHaveCouponsIMG</a>";
	}	
	print "$totaltext Subtotal <strong> \n";
	print "$totalqnty </strong> $pd : </font></td> \n";
	print "<td bgcolor=$totalback align=right width=20% nowrap> ";
	print "$totalcolor $currency $totalprice </font></td></tr>\n";

	# Totals from %Computations ------------------>
	# CommifyMoney here, keep computations free of formatting

	# Display First Discount
	if ($Computations{'Primary_Discount'} > 0 || $Computations{'Primary_Discount_Line_Override'}) {
	$DiscountOne = CommifyMoney ($Computations{'Primary_Discount'});
	print "<tr><td align=right width=80% nowrap>$totaltext \n";
	print "$Computations{'Primary_Discount_Status'} : </font>\n";
	print "</td><td bgcolor=$totalback align=right width=20% nowrap>$totalcolor ";
	if ($Computations{'Primary_Discount'} == 0 && $Computations{'Primary_Discount_Amt_Override'}) {
	print "$Computations{'Primary_Discount_Amt_Override'} ";
	} else {
	print "<font color=red>-</font> $currency $DiscountOne ";
	}
	print "</font></td></tr>\n";
	}

	# Display Coupon Discount
	if ($Computations{'Coupon_Discount'} > 0) {
	$DiscountTwo = CommifyMoney ($Computations{'Coupon_Discount'});
	print "<tr><td align=right width=80% nowrap>$totaltext \n";
	print "<a Class=\"EditShippingIMG\" href=\"javascript:document.formShipInfo.submit()\;\">$linkCouponIMG</a>" if ($linkCouponIMG && !$use_ARES);
	print "<a Class=\"SummaryTextLink\" href=\"javascript:document.formShipInfo.submit()\;\">" if ($linkCouponLine && !$use_ARES);
	print "Discount $Computations{'Coupon_Discount_Status'}";
	print "</a>" if ($linkCouponLine && !$use_ARES);
	print " : </font>\n";
	print "</td><td bgcolor=$totalback align=right width=20% nowrap><font color=red>-</font> $totalcolor $currency ";
	print "$DiscountTwo </font></td></tr>\n";
	}

	# Display Subtotal if discounts
	if ($Computations{'Combined_Discount'} > 0 ) {
	$SubDiscount = CommifyMoney ($Computations{'Sub_Final_Discount'});
	$CombinedDiscount = CommifyMoney ($Computations{'Combined_Discount'});
	print "<tr><td align=right width=80% nowrap>$totaltext \n";
	print "Sub Total After $currency $CombinedDiscount Total Discount : </font>\n";
	print "</td><td bgcolor=$totalback align=right width=20% nowrap> ";
	print "$totalcolor $currency <strong>$SubDiscount </strong></font></td></tr>\n";
	}

	# Tax Before
	if ($Computations{'Tax_Rule'} eq "BEFORE") {
	if ($Computations{'Tax_Amount'} > 0 || $NewInfo{'Tax_Exempt_Status'}) {
	$TaxRate = ($Computations{'Tax_Rate'} * 100);
	$AdjustedTax = CommifyMoney ($Computations{'Adjusted_Tax_Amount_Before'});
	$Tax = CommifyMoney ($Computations{'Tax_Amount'});
	print "<tr><td align=right width=80% nowrap>$totaltext \n";
	print "<a Class=\"EditShippingIMG\" href=\"javascript:document.formShipInfo.submit()\;\">$linkTaxIMG</a>" if ($linkTaxIMG);
	print "<a Class=\"SummaryTextLink\" href=\"javascript:document.formShipInfo.submit()\;\">" if ($linkTaxLine);
		if ($NewInfo{'Tax_Exempt_Status'}) {
		print "Tax exempt ($NewInfo{'Tax_Exempt_Status'}) ";}
		else {
		print "Sales tax $TaxRate\% ";}
	print "\(on $currency $AdjustedTax taxable\)";
	print "</a>" if ($linkTaxLine);
	print " : </font>\n";
	print "</td><td bgcolor=$totalback align=right width=20% nowrap> ";
	print "$totalcolor $currency $Tax </font></td></tr>\n";
	}}

	# Handling Charges
	if ($Computations{'Handling'} > 0 || $Computations{'Handling_Line_Override'}) {
	$HandlingCharges = CommifyMoney ($Computations{'Handling'});
	print "<tr><td align=right width=80% nowrap>$totaltext \n";
	print "$Computations{'Handling_Status'} : </font>\n";
	print "</td><td bgcolor=$totalback align=right width=20% nowrap>$totalcolor ";
	if ($Computations{'Handling'} == 0 && $Computations{'Handling_Amt_Override'}) {
	print "$Computations{'Handling_Amt_Override'} ";
	} else {
	print "$currency $HandlingCharges ";
	}
	print " </font></td></tr>\n";
	}

	# Insurance Charges
	if ($Computations{'Insurance'} > 0 || $Computations{'Insurance_Line_Override'}) {
	$InsuranceCharges = CommifyMoney ($Computations{'Insurance'});
	print "<tr><td align=right width=80% nowrap>$totaltext \n";
	print "<a Class=\"EditShippingIMG\" href=\"javascript:document.formShipInfo.submit()\;\">$linkInsuranceIMG</a>" if ($linkInsuranceIMG);
	print "<a Class=\"SummaryTextLink\" href=\"javascript:document.formShipInfo.submit()\;\">" if ($linkInsuranceLine);
	print "$Computations{'Insurance_Status'}";
	print "</a>" if ($linkInsuranceLine);
	print " : </font>\n";
	print "</td><td bgcolor=$totalback align=right width=20% nowrap>$totalcolor ";
	if ($Computations{'Insurance'} == 0 && $Computations{'Insurance_Amt_Override'}) {
	print "$Computations{'Insurance_Amt_Override'} ";
	} else {
	print "$currency $InsuranceCharges ";
	}
	print "</font></td></tr>\n";
	}

	# Shipping Charges
	if ($Computations{'Shipping_Amount'} > 0 || $Computations{'Shipping_Line_Override'}) {
	$ShippingCharges = CommifyMoney ($Computations{'Shipping_Amount'});
	print "<tr><td align=right width=80% nowrap>$totaltext \n";
	print "<a Class=\"EditShippingIMG\" href=\"javascript:document.formShipInfo.submit()\;\">$linkShippingIMG</a>" if ($linkShippingIMG);
	print "<a Class=\"SummaryTextLink\" href=\"javascript:document.formShipInfo.submit()\;\">" if ($linkShippingLine);
	print "$Computations{'Shipping_Message'}";
	print "</a>" if ($linkShippingLine);
	print " : </font>\n";
	print "</td><td bgcolor=$totalback align=right width=20% nowrap>$totalcolor ";
	if ($Computations{'Shipping_Amount'} == 0 && $Computations{'Shipping_Amt_Override'}) {
	print "$Computations{'Shipping_Amt_Override'} ";
	} else {
	print "$currency $ShippingCharges ";
	}
	print "</font></td></tr>\n";
	}

	# Tax After
	if ($Computations{'Tax_Rule'} eq "AFTER") {
	if ($Computations{'Tax_Amount'} > 0 || $NewInfo{'Tax_Exempt_Status'}) {
	$TaxRate = ($Computations{'Tax_Rate'} * 100);
	$AdjustedTax = CommifyMoney ($Computations{'Adjusted_Tax_Amount_After'});
	$Tax = CommifyMoney ($Computations{'Tax_Amount'});
	print "<tr><td align=right width=80% nowrap>$totaltext \n";
	print "<a Class=\"EditShippingIMG\" href=\"javascript:document.formShipInfo.submit()\;\">$linkTaxIMG</a>" if ($linkTaxIMG);
	print "<a Class=\"SummaryTextLink\" href=\"javascript:document.formShipInfo.submit()\;\">" if ($linkTaxLine);
		if ($NewInfo{'Tax_Exempt_Status'}) {
		print "Tax exempt ($NewInfo{'Tax_Exempt_Status'}) ";}
		else {
		print "Sales tax $TaxRate\% ";}
	print "\(on $currency $AdjustedTax taxable\)";
	print "</a>" if ($linkTaxLine);
	print " : </font>\n";
	print "</td><td bgcolor=$totalback align=right width=20% nowrap> ";
	print "$totalcolor $currency $Tax </font></td></tr>\n";
	}}

	# Final Total
	print "<tr><td align=right width=80% nowrap>$totaltext \n";
	print "<strong>Total Order Amount</strong> : </font>\n";
	print "</td><td bgcolor=$totalback align=right width=20% nowrap> ";
	print "$totalcolor $currency <strong> $FinalAmount </strong> </font></td></tr>\n";
	print "</table> \n";

	# Bottom Navigation Menu
	print "<p><table border=0 cellpadding=0 cellspacing=0><tr> \n";
	if ($menu_home_bottom) {
	print "<td valign=top nowrap><a href=\"$menu_home_bottom_url\">$menu_home_bottom</a></td> \n";}
	if ($menu_previous_bottom) {
	print "<td valign=top nowrap><a href=\"$frm{'previouspage'}\">$menu_previous_bottom</a></td> \n";}
	if ($menu_editcart_bottom) {
	print "<td valign=top nowrap>";
	print "<a href=\"$programfile?viewcart&previouspage=$frm{'previouspage'}\"> ";
	print "$menu_editcart_bottom</a></td> \n";
	}

	# Edit Preview Information
	if (scalar(@UsingInfoFields)) {
	if ($menu_edit_preview_bottom) {
	print "<td valign=top>";
	print "<FORM name=\"formShipInfo\" method=POST action=\"$programfile\"> \n";
	print "<input type=hidden name=\"postmode\" value=\"PREVIEW\"> \n";
	print "<input type=hidden name=\"submit_preview_info\" value=\"EDITING\"> \n";
	print "<input type=hidden name=\"OrderID\" value=\"$frm{'OrderID'}\"> \n";
	print "<input type=hidden name=\"InfoID\" value=\"$InfoID\"> \n";
	print "<input type=hidden name=\"previouspage\" value=\"$frm{'previouspage'}\"> \n\n";
	foreach $line (@orders) {print "<input type=hidden name=\"order\" value=\"$line\"> \n"}
	print "$menu_edit_preview_bottom</FORM></td> \n";
	}}

	# PAYMENT CENTER POST
	print "<td valign=top>";
	print "<FORM name=\"formCheckout\" method=\"post\" action=\"$paymentfile\"> \n";
	print "\n\n";

	# parse collected data ---------------->
	# This is where you would put your hidden field to bypass
	# The Billing Info page: example
	# print "<input type=\"hidden\" name=\"input_payment_options\" value=\"MAIL\"> \n";

	if ($zb_passthrough) {
	unless ($Computations{'Final_Amount'}>0) {
	print "<input type=\"hidden\" name=\"input_payment_options\" value=\"ZEROPAY\">\n";
	}}
   	while (($key, $val) = each (%Computations)) {
	print "<input type=\"hidden\" name=\"$key\" value=\"$val\">\n"}
	foreach (@orders) {
	print "<input type=\"hidden\" name=\"order\" value=\"$_\">\n"}
   	while (($key, $val) = each (%NewInfo)) {
	print "<input type=\"hidden\" name=\"$key\" value=\"$val\">\n"}

	print "<input type=\"hidden\" name=\"Allow_Tax\" value=\"$allow_tax\">\n";
	print "<input type=\"hidden\" name=\"Allow_Shipping\" value=\"$allow_shipping\">\n";
	print "<input type=\"hidden\" name=\"OrderID\" value=\"$frm{'OrderID'}\">\n";
	print "<input type=\"hidden\" name=\"InfoID\" value=\"$InfoID\">\n";
	print "<input type=\"hidden\" name=\"previouspage\" value=\"$frm{'previouspage'}\">\n";
	print "$menu_payment_bottom</FORM></td>\n";

	if ($menu_help_bottom) {
	print "<td valign=top>\n";
	print "<a href=\"$menu_help_bottom_url\" onclick=\"window.open(this.href,4,'directories=no,location=no,menubar=no,status=no,titlebar=no,toolbar=no,scrollbars=yes,width=450,height=400,resizable=no');return false\">\n";
	print "$menu_help_bottom</a></td>\n";}
	print "</tr></table>";

	# DEBUG PREVIEW
	# print "<br><hr><u><strong>\%Computations</strong></u>";
   	# while (($key, $val) = each (%Computations)) {
	# print "<li>$key, <strong>$val</strong> \n";
	# }
	# print "<br><hr><u><strong>\%MissingInfoFields</strong></u>";
   	# while (($key, $val) = each (%MissingInfoFields)) {
	# print "<li>$key, <strong>$val</strong> \n";
	# }
	# print "<br><hr><u><strong>\%NewInfo</strong> Global Array </u>";
   	# while (($key, $val) = each (%NewInfo)) {
	# print "<li>$key, <strong>$val</strong> \n";
	# }
	# print "<hr><strong><u>\@UsingInfoFields</u></strong>";
	# foreach $_ (@UsingInfoFields) {print "<li>$_"}
	# print "<br><hr><u><strong>\%shipping_destination_fields</strong> CONFIG</u>";
   	# while (($key, $val) = each (%shipping_destination_fields)) {
	# print "<li>$key, $val \n";
	# }
	# print "<br><hr><u><strong>All Global Vars</strong></u>";
	# print "<li>postmode = $frm{'postmode'}";
	# print "<li>submit_preview_info = $frm{'submit_preview_info'}";
	# print "<li>FRM-OrderID = $frm{'OrderID'}";
	# print "<li>OrderID = $OrderID";
	# print "<li>FRM-InfoID = $frm{'InfoID'}";
	# print "<li>InfoID = $InfoID";
	# print "<li>previouspage = $frm{'previouspage'}";
	# print "<li>msg_i = $msg_i";
	# print "<li>cookieOrderID = $cookieOrderID";
	# print "<li>cookieInfoID = $cookieInfoID";
	# TESTING ORDERS ARRAY
	# print "<font size=2><br><hr>\n";
	# print "<u><strong>\@orders</strong> Main List</u>";
	# foreach $line (@orders) {print "<li>$line";}
			
	print "$returntofont\n";
	print "@footer \n\n";
  }
# END MERCHANT ORDERFORM Cart ver 2.4
# Copyright by RGA 2000- 2001
