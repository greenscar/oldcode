/*
 Moving Menu by James Sandlin
 Coded By: James Sandlin
 Date: 08/30/2004
*/
<!--
direction = new Array(10);
var absolute_speed = 3;
//var timeoutID=0;
timeoutID = new Array(10);
startY = new Array(10);
currentY = new Array(10);
destY = new Array(10);
moving = new Array(10);
var browser = null;
var activeMenu = null;
var activeSubMenu = null;
layerVisible = new Array(10);
var menuLoc = 20;
var menuHeight = 30;

function init()
{   
   if(document.all)
   {
      // Internet Explorer 4 or Opera with IE user agent
      layerRef="document.all";
      styleSwitch=".style";
      visibleVar="visible";
      screenSize = document.body.clientWidth + 18;
      browser ="ie";
   }
   else if(document.getElementById)
   {
      // browser implements part of W3C DOM HTML
      // Gecko, Internet Explorer 5+, Opera 5+
      layerRef="document.getElementById";
      styleSwitch=".style";
      visibleVar="visible";
      browser="moz";
   }
   else if (document.subMenus)
   {
      // Navigator 4
      layerRef="document.subMenus";
      styleSwitch="";
      visibleVar="show";
      screenSize = window.innerWidth;
      browser ="ns4";
   }
   else
   {
      //alert("Older than 4.0 browser.");
      browser="none";
      newbrowser = false;
   }
   for(var i=0; i < subMenus.length; i++)
   {
      layerVisible[subMenus[i]] = false;
   }
   //alert("browser == " + browser + "\ntimeoutID = " + timeoutID);
   window.status= new Date();
   check = true;
}


function pauseMe(Amount)
{
   d = new Date() //today's date
   while (1)
   {
      mill=new Date() // Date Now
      diff = mill-d //difference in milliseconds
      if( diff > Amount )
         break;
   }
}

function hideLayers()
{
    if(browser == "ns4")
    {
        document.fxn_hide_layer.visibility="hidden";
    }
    if(browser == "ie")
    {
        document.all.fxn_hide_layer.style.visibility="hidden";
    }
    if(browser == "moz")
    {
        document.getElementById("fxn_hide_layer").style.visibility="hidden";
    }
   for(var i=0; i < subMenus.length; i++)
   {
      hideLayer(subMenus[i]);
   }
}
function showLayer(subMenuName)
{
   //alert("showLayer()");
   //alert("browser = " + browser);
   if(browser == "ns4")
   {
      document.fxn_hide_layer.visibility="visible";
   }
   if(browser == "ie")
   {
      document.all.fxn_hide_layer.style.visibility="visible";
   }
   if(browser == "moz")
   {
      document.getElementById("fxn_hide_layer").style.visibility="visible";
   }
   //alert(subMenuName);
   //alert(subMenuName + " visible => " + layerVisible[subMenuName]);
   if((!layerVisible[subMenuName]))// && (!moving[subMenuName]))
   {
      activeSubMenu = subMenuName;
      direction[subMenuName] = 1;
      moveLayer(subMenuName);
      layerVisible[subMenuName] = true;
   }   
   for(var i=0; i < subMenus.length; i++)
   {
      if(subMenus[i] != subMenuName)
         hideLayer(subMenus[i]);
   }
}
function hideLayer(subMenuName)
{
   if((layerVisible[subMenuName]))// && (!moving[subMenuName]))
   {
      direction[subMenuName] = -1;
      moveLayer(subMenuName);
      layerVisible[subMenuName] = false;
   }
}
function moveLayer(subMenuName)
{
   //alert("moveLayer("+subMenuName+")");
   var height = 0;
   var moveTo = 0;
   //alert("browser = " + browser);
   if(browser == "ns4")
   {
      destY[subMenuName] = startY[subMenuName] + (menuHeight * direction[subMenuName]);
      document.elements(subMenuName).top = destY[subMenuName];
   }
   if(browser == "ie")
   {
      //alert("ie\nmenuHeight="+menuHeight);
      //alert(document.getElementById(subMenuName).style.top);
      //document.getElementById(subMenuName).style.top = parseInt(document.getElementById(subMenuName).style.top) + menuHeight;
      height = parseInt(document.getElementById(subMenuName).style.height);
      if(direction[subMenuName] == 1)
      {
         destY[subMenuName] =  /*menuLoc +*/  (menuHeight * direction[subMenuName] - 4);
         //alert("destY = " + destY[subMenuName]);
      }
      else
      {
         //alert("height = " + height + "menuLoc = " + menuLoc);
         destY[subMenuName] = (menuLoc * 2) + (height * direction[subMenuName] - 13);
         //alert("destY = " + destY[subMenuName]);
      }
      //alert(document.getElementById(subMenuName).style.top);
   }
   if(browser == "moz")
   {
      height = parseInt(document.getElementById(subMenuName).style.height);
      //menuLoc = parseInt(document.getElementById("entireMenu").style.top);
      if(direction[subMenuName] == 1)
      {
         destY[subMenuName] =  /*menuLoc +*/  (menuHeight * direction[subMenuName] - 4);
      }
      else
      {
         destY[subMenuName] = menuLoc + (height * direction[subMenuName]) + 2;
      }
      //alert("startY = " + menuLoc);
      //alert("destY = " + destY);
   }
   if(!timeoutID[subMenuName])
   {
      moveMenu(subMenuName);
      started=1;
   }  
}
function moveMenu(subMenuName)
{
   //alert("moveMenu("+subMenuName+")");
   var subMenuElement = document.getElementById(subMenuName);
   currentY[subMenuName] = parseInt(subMenuElement.style.top);
   var currentLoc = currentY[subMenuName];
   var nextLoc = parseInt(subMenuElement.style.top) + absolute_speed * direction[subMenuName];
   var destLoc = destY[subMenuName];
   
   var toAlert = "currentLoc = " +currentLoc+ "\n       nextY = " + nextLoc + "\ndestY = " + destLoc + "\ndirection = " + direction[subMenuName];
   //if((direction[subMenuName] == 1) && (currentY[subMenuName] >= destY[subMenuName]))
   if((direction[subMenuName] == 1) && (nextLoc > destY[subMenuName]))
   {
      currentY[subMenuName] = destY[subMenuName];
   }
   //else if((direction[subMenuName] == -1) && (currentY[subMenuName] <= destY[subMenuName]))
   else if((direction[subMenuName] == -1) && (nextLoc < destY[subMenuName]))
   {
      currentY[subMenuName] = destY[subMenuName];
   }
   else
   {
      currentY[subMenuName] = parseInt(subMenuElement.style.top) + absolute_speed * direction[subMenuName];
   }
   toAlert += "newCurrentY = " + currentY[subMenuName];
   //alert(toAlert);
   //exit();  
   
   if(browser == "ns4")
   {
      document.getElementById(subMenuName).top=currentY[subMenuName];
   }
   if(browser == "ie")
   {
      document.getElementById(subMenuName).style.top = currentY[subMenuName];
   }
   if(browser == "moz")
   {
      document.getElementById(subMenuName).style.top = currentY[subMenuName] + "px";
   }
   if (direction[subMenuName] == 1 && currentY[subMenuName] >= destY[subMenuName])
   {
      // Clear the timeout fxn that is set to be called.
      window.clearTimeout(timeoutID);
      moving[subMenuName] = false;
      timeoutID[subMenuName]=0;
   }
   else if (direction[subMenuName] == -1 && currentY[subMenuName] <= destY[subMenuName])
   {
      // Clear the timeout fxn that is set to be called.
      window.clearTimeout(timeoutID);
      moving[subMenuName] = false;
      timeoutID[subMenuName]=0;
   }
   else
   {
      var toCall = "moveMenu('" + subMenuName + "');";
      moving[subMenuName] = true;
      timeoutID[subMenuName] = window.setTimeout(toCall,5);
   }
}
-->