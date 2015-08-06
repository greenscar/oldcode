
function checkFields(qForm)
{
    if(contactUs.name.value == "")
    {
        alert("Please provide your name so we can contact you.");
        contactUs.elements["name"].focus();
        return(false);
    }
    if(contactUs.city.value == "")
    {
        alert("Please provide your city so we can contact you.");
        contactUs.elements["city"].focus();
        return(false);
    }
    if(contactUs.zip.value == "")
    {
        alert("Please provide your zip code so we can contact you.");
        contactUs.elements["zip"].focus();
        return(false);
    }
    if(contactUs.email.value == "")
    {
        alert("Please provide your email address so we can contact you.");
        contactUs.elements["email"].focus();
        return(false);
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

