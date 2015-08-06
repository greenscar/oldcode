      <!--
      function reloadPage(init) {  //reloads the window if Nav4 resized
         if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
         document.pgW=innerWidth; document.pgH=innerHeight; onresize=reloadPage; }}
         else if (innerWidth!=document.pgW || innerHeight!=document.pgH) location.reload();
      }
      reloadPage(true);
      function findObj(n, d) { //v4.01
         var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
         d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
         if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
         for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=findObj(n,d.layers[i].document);
         if(!x && d.getElementById) x=d.getElementById(n); return x;
      }
      
      function showHideLayers() { //v6.0
         var i,p,v,obj,args=showHideLayers.arguments;
         for (i=0; i<(args.length-2); i+=3) if ((obj=findObj(args[i]))!=null) { v=args[i+2];
         if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
         obj.visibility=v; }
      }
      
      function getDate()
      {
         var Today = new Date();
         var week, month;
         
         switch (Today.getDay()) {
           case 0:
             week = "Sunday";
             break;
           case 1:
             week = "Monday";
             break;
           case 2:
             week = "Tuesday";
             break;
           case 3:
             week = "Wednesday";
             break;
           case 4:
             week = "Thursday";
             break;
           case 5:
             week = "Friday";
             break;
           case 6:
             week = "Saturday";
             break;
         }
         
         switch (Today.getMonth()) {
           case 0:
             month = "January";
             break;
           case 1:
             month = "February";
             break;
           case 2:
             month = "March";
             break;
           case 3:
             month = "April";
             break;
           case 4:
             month = "May";
             break;
           case 5:
             month = "June";
             break;
           case 6:
             month = "July";
             break;
           case 7:
             month = "August";
             break;
           case 8:
             month = "September";
             break;
           case 9:
             month = "October";
             break;
           case 10:
             month = "November";
             break;
           case 11:
             month = "December";
             break;
         }
         //date.date.value=(week + " " + month + " " + Today.getDate() + ", " + Today.getYear());
      }
      //-->