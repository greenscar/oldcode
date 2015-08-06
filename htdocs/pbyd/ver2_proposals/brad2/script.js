<!--
function findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}
function nbGroup(event, grpName) { //v6.0
var i,img,nbArr,args=nbGroup.arguments;
  if (event == "init" && args.length > 2) {
    if ((img = findObj(args[2])) != null && !img.init) {
      img.init = true; img.up = args[3]; img.dn = img.src;
      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      nbArr[nbArr.length] = img;
      for (i=4; i < args.length-1; i+=2) if ((img = findObj(args[i])) != null) {
        if (!img.up) img.up = img.src;
        img.src = img.dn = args[i+1];
        nbArr[nbArr.length] = img;
    } }
  } else if (event == "over") {
    document.nbOver = nbArr = new Array();
    for (i=1; i < args.length-1; i+=3) if ((img = findObj(args[i])) != null) {
      if (!img.up) img.up = img.src;
      img.src = (img.dn && args[i+2]) ? args[i+2] : ((args[i+1])?args[i+1] : img.up);
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    for (i=0; i < document.nbOver.length; i++) { img = document.nbOver[i]; img.src = (img.dn) ? img.dn : img.up; }
  } else if (event == "down") {
    nbArr = document[grpName];
    if (nbArr) for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.up; img.dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = findObj(args[i])) != null) {
      if (!img.up) img.up = img.src;
      img.src = img.dn = (args[i+1])? args[i+1] : img.up;
      nbArr[nbArr.length] = img;
  } }
}

function preloadImages() { //v3.0
 var d=document; if(d.images){ if(!d.p) d.p=new Array();
   var i,j=d.p.length,a=preloadImages.arguments; for(i=0; i<a.length; i++)
   if (a[i].indexOf("#")!=0){ d.p[j]=new Image; d.p[j++].src=a[i];}}
}

function protectmail() {
   var name = "contactus";
   var address = "pbyd.com";
   var link = name + "@" + address;
   var subject = "Service Inquiry";
   document.write('<a class="email" href=mailto:' + name + '@' + address + '?subject=' + subject + '>' + link + '</a>');
}
function validateForm(form)
{
   if(field_is_blank(form, "name", "Name"))
   {
   	  document.getElementById("name").className="textfield_incomplete";
         document.getElementById("name").focus();
   	  return(false);
   }
   if(field_is_blank(form, "day_phone", "Day Phone"))
   {
      document.getElementById("day_phone").className="textfield_incomplete";
   	  return(false);
   }
   return(true);
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
//-->