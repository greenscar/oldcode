
<!--

function validateShopForm(form)
{
   if(field_is_blank(form, "store_name", "Store Name"))
      return(false);
   if(field_is_blank(form, "store_address", "Store Address"))
      return(false);
   if(!check_email(form, "email"))
      return(false);
   if(field_is_blank(form, "city", "City"))
      return(false);
   if(field_is_blank(form, "state", "State"))
      return(false);
   if(!check_zip_code(form, "zip"))
      return(false);
   if(!check_phone_num(form, "phone", "Phone Number"))
      return(false);
   if(field_is_blank(form, "comments_suggestions", "Comments"))
      return(false);
   return(true);
}
function check_zip_code(form, the_field)
{
  //alert("form = " + form.name);
    var zip_reg_exp = /^[0-9]{5}$/;
    obj_field = eval(form.name + "." + the_field);
    if(!zip_reg_exp.test(obj_field.value))
    {
      alert ("Please enter a zip code in the number format XXXXX");
      obj_field.select();
      obj_field.focus();
      return (false);
    } 
    return (true);
}
function check_email(form, theField)
{
    
    var email = /(^[a-z]([a-z_\.]*)@([a-z_\.]*)([.][a-z]{3})$)|(^[a-z]([a-z_\.]*)@([a-z_\.]*)(\.[a-z]{3})(\.[a-z]{2})*$)/;
    obj_field = eval(form.name + "." + theField);
    if((!email.test(obj_field.value)))
    {
        alert("Please enter a valid email address");
        obj_field.select();
        obj_field.focus();
        return(false);
    }
    return(true);
} 
function swapImgRestore() { //v3.0
  var i,x,a=document.sr;
  for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++)
    x.src=x.oSrc;
}

function preloadImages() { //v3.0
  var d=document;
  if(d.images){
    if(!d.p) d.p=new Array();
    var i,j=d.p.length,a=preloadImages.arguments;
    for(i=0; i<a.length; i++)
      if (a[i].indexOf("#")!=0){
        d.p[j]=new Image; d.p[j++].src=a[i];
      }
  }
}

function findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function swapImage() { //v3.0
  var i,j=0,x,a=swapImage.arguments;
  document.sr=new Array;
  for(i=0;i<(a.length-2);i+=3)
    if ((x=findObj(a[i]))!=null)
    {
      document.sr[j++]=x;
      if(!x.oSrc)
        x.oSrc=x.src;
      x.src=a[i+2];
    }
}


function validate_name_lookup(form)
{
    if((form.first_name.value.length == 0) || (form.last_name.value.length == 0))
    {
        alert("You must enter a first and last name.");
        form.first_name.select();
        form.first_name.focus();
        return(false);
    }
    return(true);
}
function valid_web_address(theForm, theField)
{
    var address = /(^http:\/\/(([a-zA-Z\-0-9]+\.)([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))/;
    obj_field = eval("form." + theField);
    if((!address.test(obj_field.value)))
    {
        alert("Please enter a valid web address");
        obj_field.select();
        obj_field.focus();
        return(false);
    }
    return(true);
}

function drop_down_selected(theForm, theField, name)
{
    var val = eval("theForm." + theField);
    if(val.value == 0)
    {
       alert("Please select a " + name);
       return(false);
    }
    else
       return(true);
}
function check_password(theForm, field1, field2)
{
    obj_field1 = eval("form." + field1);
    obj_field2 = eval("form." + field2);
    if(obj_field1.value != obj_field2.value)
    {
        alert("Your passwords do not match. Please try again.");
        obj_field1.select();
        obj_field1.focus();
        return(false);
    }
    else if(obj_field1.value.length < 6)
    {
        alert("Please enter a password with at least 6 characters.");
        obj_field1.select();
        obj_field1.focus();
        return(false);
    }
    return(true);
}


function check_phone_num(form, the_field, descr)
{
    var pn_reg_exp = /^[1-9][0-9]{2}-[1-9][0-9]{2}-[0-9]{4}$/;
    obj_field = eval("form." + the_field); 
    if(!pn_reg_exp.test(obj_field.value))
    {
      alert ("Please enter a " + descr + " in the format XXX-XXX-XXXX");
      obj_field.select();
      obj_field.focus();
      return (false);
    } 
    return (true);
}
function field_only_chars(form, the_field, descr)
{
    var string_reg_exp = /^[A-Za-z]+$/;
    obj_field = eval("form." + the_field);
    if(!string_reg_exp.test(obj_field.value))
    {
      alert ("Please enter a valid " + descr);
      obj_field.select();
      obj_field.focus();
      return (false);
    }
    return (true);
}
function field_is_blank(form, the_field, descr)
{
    var val = eval("form." + the_field);
    if(val.value.length > 0)
        return(false);
    else
        alert("Please enter the " + descr);
        eval("form." + the_field + ".select()");
        eval("form." + the_field + ".focus()");
        return(true);
}
function check_store_num(form, the_field)
{
    var zip_reg_exp = /^[0-9]{3}$/;
    obj_field = eval("form." + the_field);
    if(!zip_reg_exp.test(obj_field.value))
    {
      alert ("Please enter a valid store number");
      obj_field.select();
      obj_field.focus();
      return (false);
    }
    return (true);
}

function only_numbers(form, the_field, descr){
    var nums = /^[0-9]+$/;
    obj_field = eval("form." + the_field);
    if(!nums.test(obj_field.value))
    {
      alert ("Please enter a valid " + descr);
      obj_field.select();
      obj_field.focus();
      return (false);
    }
    return (true);
}
    

function ensure_radio_checked(form, the_field)
{
    var length = eval("form." + the_field + ".length");
    //alert("length = " + length);
    for(var i=0; i < length; i++)
    {
      //alert(eval("form." + the_field + "[" + i + "].checked"));
        if(eval("form." + the_field + "[" + i + "].checked"))
        {
            return(true);
        }
    }
    alert("Please select an option on " + the_field);
    return(false);
}


function validate_date(form, the_field)
{
    //alert("validate_date");
    var obj_field = eval("form." + the_field);
    var strValue = eval("form." + the_field + ".value");
    var objRegExp = /^\d{2}(\/)\d{2}(\/)\d{4}$/
    //alert(strValue);
    //check to see if in correct format
    if(!objRegExp.test(strValue))
    {
        alert ("Please enter a date in the format MM/DD/YYYY");
        obj_field.select();
        obj_field.focus();
        return(false);
    }
    else
    {
        var strSeparator = strValue.substring(2,3) //find date separator
        var arrayDate = strValue.split(strSeparator); //split date into month, day, year
        //create a lookup for months not equal to Feb.
        var arrayLookup = { '01' : 31,'03' : 31, '04' : 30,'05' : 31,'06' : 30,'07' : 31,
                            '08' : 31,'09' : 30,'10' : 31,'11' : 30,'12' : 31}
        /*
         * parseInt strips the leading 0's. 
         * We must specify we want it parsed in base 10, because if the string starts
         *  with 0, the code assumes it is base 16.
         */
        var intMonth = arrayDate[0];
        var intDay = parseInt(arrayDate[1], 10);
        var intYear = parseInt(arrayDate[2], 10);
        //alert("month = " + intMonth + "\nday = " + intDay + "\nyear = " + intYear);
        var date = new Date();
        var thisYear = date.getYear();
        if(intMonth < 1 || intMonth > 12)
        {
            alert("Your month must be between 1 and 12.");
            return(false);
        }
        var enteredDate = new Date(intYear, (intMonth - 1), intDay);
        //alert("entered = " + enteredDate + "\ntoday = " + date);
        if(enteredDate <= date){
            alert("Please enter a future date for the expiration.");
            return(false);
        }
        
        //check if month value and day value agree
        //alert("array = " + arrayLookup[intMonth]);
        //alert(intMonth + " = " + arrayLookup[intMonth]);
        if(arrayLookup[intMonth] != null)
        {
            //alert("arrayLookup[intMonth] != null");
            if(intDay <= arrayLookup[intMonth] && intDay > 0)
                return true; //found in lookup table, good date
            else
            {
                alert("The month you entered doesn't have that many days.");
                return(false);
            }
        }
        //check for February
        if(intMonth == 2)
        {
            if( ((intYear % 4 == 0 && intDay <= 29) || (intYear % 4 != 0 && intDay <=28)) && intDay !=0)
                return true; //Feb. had valid number of days
            else
            {
                alert("You have selected February 29th on a year that is not a leap year. Please try again");
                return(false);
            }           
        }
    }
    return(false);
}
function check_field(form, the_field, the_field_display, obj_reg_exp){ 
    obj_field = eval("document." + form + "." + the_field); 
    if(!obj_reg_exp.test(obj_field.value))
    {
      alert ("Please enter a valid " + the_field_display + "");
      obj_field.select();
      obj_field.focus();
      return (false);
    } 
    return (true);
}
function only_chars(form, the_field, error_the_field){
    var chars = /\_d/;
    return(check_field(form, the_field, error_the_field, chars));
}
//-->