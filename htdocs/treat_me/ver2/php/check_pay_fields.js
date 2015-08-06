
function checkFields(qForm)
{
    if(buyerInfo.x_first_name.value == "" || buyerInfo.x_last_name.value == "")
    {
        alert("Please give us your first and last name.");
        return(false);
    }
    if(buyerInfo.BuyAddress1.value == "")
    {
        alert("Please give us your street address.");
        return(false);
    }
    else
    {
        var fullAddress = buyerInfo.BuyAddress1.value + ", " + buyerInfo.BuyAddress2.value;
        buyerInfo.x_address.value = fullAddress;
    }
    
    if(buyerInfo.shipBuyAddress1.value == "")
    {
        var shipFullAddress = buyerInfo.BuyAddress1.value + ", " + buyerInfo.BuyAddress2.value;
        buyerInfo.x_ship_to_address.value = shipFullAddress;   
    }
    else
    {
        var shipFullAddress = buyerInfo.shipBuyAddress1.value + ", " + buyerInfo.shipBuyAddress2.value;
        buyerInfo.x_ship_to_address.value = shipFullAddress;   
    }
    if(buyerInfo.x_city.value == "")
    {
        alert("Please give us your city.");
        return(false);
    }
    if(buyerInfo.x_state.value == "")
    {
        alert("Please give us your state.");
        return(false);
    }
    if(buyerInfo.x_zip.value == "")
    {
        alert("Please give us your zip code.");
        return(false);
    }
    if(buyerInfo.x_email.value == "")
    {
        alert("We need your email address to process the order.");
        return(false);
    }
    if(buyerInfo.x_phone.value == "" && buyerInfo.eve_phone.value == "")
    {
        alert("We need your phone number to process the order.");
        return(false);
    }
    if(buyerInfo.giftWrap.checked == true && buyerInfo.giftWrapLabel.value == "")
    {
        alert("You have selected to have your item gift wrapped.\n Please enter what you would like your gift card to say.");
        return(false);
    }
    var payMethodSelected = false;
    var payMethod = "";
    for(counter = 0; counter < buyerInfo.PayMethod.length; counter ++)
    {
        if(buyerInfo.PayMethod[counter].checked)
        {
            payMethodSelected = true;
            payMethod = buyerInfo.PayMethod[counter].value;
        }
    }
    if(payMethodSelected == false)
    {
        if(buyerInfo.x_card_num.value != "")
        {
            //alert("cardNum = " + buyerInfo.x_card_num.value);
            buyerInfo.PayMethod.value = "Credit";
        }
        else
        {
            alert("Please select a payment option.");
            return(false);
        }
    }
    //alert("payMethod = " + buyerInfo.PayMethod.value);
    if(payMethod == "Credit")
    {
        if(buyerInfo.x_card_num.value == "")
        {
            alert("You have selected to pay by credit card, buy have not entered an account number.");
            return(false);
        }
        if(buyerInfo.x_exp_date.value == "")
        {
            alert("We need your credit card's expiration date please.");
            return(false);
        }
        if(!validCCForm(buyerInfo.CCType, buyerInfo.x_card_num ,this.buyerInfo.x_exp_date))
        {
            return(false);
        }
    }
    if(buyerInfo.x_ship_to_first_name.value == "" && buyerInfo.x_ship_to_last_name.value == "")
    {
        buyerInfo.x_ship_to_first_name.value = buyerInfo.x_first_name.value;
        buyerInfo.x_ship_to_last_name.value = buyerInfo.x_last_name.value;
    }
    if(buyerInfo.shipBuyAddress1.value == "" && buyerInfo.shipBuyAddress2.value == "")
    {
        buyerInfo.shipBuyAddress1.value = buyerInfo.BuyAddress1.value;
        buyerInfo.shipBuyAddress2.value = buyerInfo.BuyAddress2.value;
        buyerInfo.x_ship_to_city.value = buyerInfo.x_city.value;
        buyerInfo.x_ship_to_state.value = buyerInfo.x_state.value;
        buyerInfo.x_ship_to_zip.value = buyerInfo.x_zip.value;
    }
    return(true);
}

// Form Field Validation Functions:
//
// isValidExpDate(formField,fieldLabel,required)
//   -- checks for date in the format MM/YY or MM/YYYY against the current date
// isValidCreditCardNumber(formField,CCType,fieldLabel,required)
//   -- checks for valid credit card format using the Luhn check and known digits about various cards
//

function validRequired(formField,fieldLabel)
{
	var result = true;
	
	if (formField.value == "")
	{
		alert('Please enter a value for the "' + fieldLabel +'" field.');
		formField.focus();
		result = false;
	}
	
	return result;
}


function allDigits(str)
{
	return inValidCharSet(str,"0123456789");
}

function inValidCharSet(str,charset)
{
	var result = true;
	
	for (var i=0;i<str.length;i++)
		if (charset.indexOf(str.substr(i,1))<0)
		{
			result = false;
			break;
		}
	
	return result;
}

function isValidExpDate(formField,fieldLabel,required)
{
	var result = true;
	var formValue = formField.value;

	if (required && !validRequired(formField,fieldLabel))
		result = false;
  
 	if (result && (formField.value.length>0))
 	{
 		var elems = formValue.split("/");
 		
 		result = (elems.length == 2); // should be two components
 		var expired = false;
 		
 		if (result)
 		{
 			var month = parseInt(elems[0],10);
 			var year = parseInt(elems[1],10);
 			
 			if (elems[1].length == 2)
 				year += 2000;
 			
 			var now = new Date();
 			
 			var nowMonth = now.getMonth() + 1;
 			var nowYear = now.getFullYear();
 			
 			expired = (nowYear > year) || ((nowYear == year ) && (nowMonth > month));
 			
			result = allDigits(elems[0]) && (month > 0) && (month < 13) &&
					 allDigits(elems[1]) && ((elems[1].length == 2) || (elems[1].length == 4));
 		}
 		
  		if (!result)
 		{
 			alert('Please enter a date in the format MM/YY for the "' + fieldLabel +'" field.');
			formField.focus();
		}
		else if (expired)
		{
 			result = false;
 			alert('The date for "' + fieldLabel +'" has expired.');
			formField.focus();
		}
	} 
	
	return result;
}

function isValidCreditCardNumber(formField,CCType,fieldLabel,required)
{
	var result = true;
 	var x_card_num = formField.value;

	if (required && !validRequired(formField,fieldLabel))
		result = false;
 
  	if (result && (formField.value.length>0))
 	{ 
 		if (!allDigits(x_card_num))
 		{
 			alert('Please enter only numbers (no dashes or spaces) for the "' + fieldLabel +'" field.');
			formField.focus();
			result = false;
		}	

		if (result)
 		{ 
 			
 			if (!LuhnCheck(x_card_num) || !validatex_card_num(CCType,x_card_num))
 			{
 				alert('Please enter a valid card number for the "' + fieldLabel +'" field.');
				formField.focus();
				result = false;
			}	
		} 

	} 
	
	return result;
}

function LuhnCheck(str) 
{
  var result = true;

  var sum = 0; 
  var mul = 1; 
  var strLen = str.length;
  
  for (i = 0; i < strLen; i++) 
  {
    var digit = str.substring(strLen-i-1,strLen-i);
    var tproduct = parseInt(digit ,10)*mul;
    if (tproduct >= 10)
      sum += (tproduct % 10) + 1;
    else
      sum += tproduct;
    if (mul == 1)
      mul++;
    else
      mul--;
  }
  if ((sum % 10) != 0)
    result = false;
    
  return result;
}



function GetRadioValue(rArray)
{
	for (var i=0;i<rArray.length;i++)
	{
		if (rArray[i].checked)
			return rArray[i].value;
	}
	
	return null;
}


function validatex_card_num(cardType,cardNum)
{
	var result = false;
	cardType = cardType.toUpperCase();
	
	var cardLen = cardNum.length;
	var firstdig = cardNum.substring(0,1);
	var seconddig = cardNum.substring(1,2);
	var first4digs = cardNum.substring(0,4);

	switch (cardType)
	{
		case "VISA":
			result = ((cardLen == 16) || (cardLen == 13)) && (firstdig == "4");
			break;
		case "AMEX":
			var validNums = "47";
			result = (cardLen == 15) && (firstdig == "3") && (validNums.indexOf(seconddig)>=0);
			break;
		case "MASTERCARD":
			var validNums = "12345";
			result = (cardLen == 16) && (firstdig == "5") && (validNums.indexOf(seconddig)>=0);
			break;
		case "DISCOVER":
			result = (cardLen == 16) && (first4digs == "6011");
			break;
		case "DINERS":
			var validNums = "068";
			result = (cardLen == 14) && (firstdig == "3") && (validNums.indexOf(seconddig)>=0);
			break;
	}
	return result;
}

function validCCForm(CCTypeField,x_card_numField,x_exp_dateField)
{
	var result = isValidCreditCardNumber(x_card_numField,CCTypeField.value,"Credit Card Number",true) &&
		isValidExpDate(x_exp_dateField,"Expiration Date",true);
	return result;
}

