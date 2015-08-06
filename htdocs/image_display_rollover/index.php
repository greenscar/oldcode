<?php
   $dir = "images/big";
   $photos = array();
	include("create_main.php");
   if (is_dir($dir))
   {
      if ($dh = opendir($dir))
		{
         while (($file = readdir($dh)) !== false)
			{
				set_time_limit(60);
            if(strpos($file, ".jpg"))
            {
					if(!(file_exists("./images/big/$file")))
					{
						//echo("file = $file<br>");
						create_main($file, 500);
					}
               array_push($photos, "images/big/$file");
            }
         }
         closedir($dh);
      }  
   }
?>
<html>
<head><title>Pics</title>
<script language="JavaScript">
<!--
var counter = 0;
var images = new Array(<?php
for($i=0; $i < sizeof($photos); $i++)
{
	echo("\"" . $photos[$i] . "\"");
	if(($i+1) < sizeof($photos))
		echo(", ");
}
?>);
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}
function MM_nbGroup(event, grpName) { //v6.0
var i,img,nbArr,args=MM_nbGroup.arguments;
  if (event == "init" && args.length > 2) {
    if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
      img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      nbArr[nbArr.length] = img;
      for (i=4; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
        if (!img.MM_up) img.MM_up = img.src;
        img.src = img.MM_dn = args[i+1];
        nbArr[nbArr.length] = img;
    } }
  } else if (event == "over") {
    document.MM_nbOver = nbArr = new Array();
    for (i=1; i < args.length-1; i+=3) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = (img.MM_dn && args[i+2]) ? args[i+2] : ((args[i+1])?args[i+1] : img.MM_up);
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    for (i=0; i < document.MM_nbOver.length; i++) { img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up; }
  } else if (event == "down") {
    nbArr = document[grpName];
    if (nbArr) for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = img.MM_dn = (args[i+1])? args[i+1] : img.MM_up;
      nbArr[nbArr.length] = img;
  } }
}

function MM_preloadImages() { //v3.0
 var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
   var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
   if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function nextPhoto()
{
	//alert(document.bigpic.src);
	//alert(counter + " => " + images.length);
	if(counter == (images.length - 1))
		counter = 0;
	else
		counter ++;
	//counter = counter;
	document.bigpic.src = images[counter];
	//alert(counter);
}
function prevPhoto()
{
	//alert(document.bigpic.src);
	//alert(counter + " => " + images.length);
	if(counter == 0)
		counter = (images.length - 1);
	else
		counter --;
	//counter = counter;
	document.bigpic.src = images[counter];
	//alert(counter);
}
//-->
</script><style type="text/css">
	body {
		font-family: Arial, Verdana, Helvetica, sans-serif;
		font-size: 15px;
		font-color: white;
		font-style: normal;
		font-weight: bold;
		font-variant: normal;
		text-decoration: none;
	}
	#small_pics {
		float: left;
		padding: 10px;
		margin: 5px;
		background: #666;
		border: 5px solid #ccc;
		/*
		width: 190px;
		*/
		text-align: center;
		/* ie5win fudge begins */
		voice-family: "\"}\"";
		voice-family:inherit;
		width: 190px;
	}
	html>body #small_pics {
		width: 160px; 
		/* ie5win fudge ends */
	}
	#big_pic_container {
		position: relative;
		height: 100px;
		top:10px;
		/*
		left: 200px;
		*/
		width: 555px;
		border: 0px solid green;
		/* ie5win fudge begins */
		voice-family: "\"}\"";
		voice-family:inherit;
		left: 0px;
	}
	html>body #big_pic_container {
		left: 200px;
		/* ie5win fudge ends */
	}
	#big_pic {
		position: fixed;
		float: right;
		padding: 5px;
		margin-top: 5px;
		background: #666;
		border: 5px solid #ccc;
		margin-left: auto;
		margin-right: auto;
		text-align: center;
		/*
		width: 550px;
		*/
		height: 550px;
		/* ie5win fudge begins */
		voice-family: "\"}\"";
		voice-family:inherit;
		width: 550px;
	}
	html>body #big_pic {
		width: 550px; 
		/* ie5win fudge ends */
	}
	img.big
	{
		padding: 0px;
		margin: 0px;
		border: 1px solid #ccc;
	}
	a.arrow
	{
		color: #FFFFFF;
		font-family: Arial, Verdana, Helvetica, sans-serif;
		font-size: 10px;
		font-style: normal;
		font-weight: bold;
		font-variant: normal;
		text-decoration: none;
	}
	a.arrow:hover
	{
		color: #000000;
	}
	p
	{
		border: 1px solid orange;
		padding: 10 0 10 0;
		margin: 10 0 10 0;
	}
}
</style>

	<!--[if IE]>
	<style type="text/css">
	#big_pic { position:absolute; }
	</style>
	<script type="text/javascript">
	window.onscroll = function() {
	var root = (document.compatMode == "CSS1Compat"?
	document.documentElement: document.body);
	var elem = document.all["big_pic"];
        //elem.style.left = root.scrollLeft + 50 + "px";
	elem.style.top = root.scrollTop + 10 + "px";
	};
	</script>
	<![endif]-->
</head>
<body style="margin-left: auto; margin-right: auto; text-align: center; background-color: #444444;" onLoad="MM_preloadImages(<?php
   for($i = 0; $i < sizeof($photos); $i++)
   {
      echo("'" . $photos[$i] . "'");
      if(($i+1) < sizeof($photos))
			echo(", ");
   }
?>);">
<div style="margin-left: auto; margin-right: auto;width: 775px; text-align: left; height: 500px; border: 0px solid red">
	<div id="small_pics">
	<?php
		$dir = "images/big";
                echo("<div class=\"photo_album\">\n");
		if ($dh = opendir($dir)) {
			 while (($file = readdir($dh)) !== false) {
				if(strpos($file, ".jpg"))
					echo("<img class=\"mini\" src=\"create_thumbnail.php?pict=$file&size=50\" onmouseover=\"document.bigpic.src='" . $dir . "/" . $file . "'\">\n");
			 }
			 closedir($dh);
		}
               echo("</div>");
	?>
	</div>
        	
	<div id="big_pic_container">
         <div id="big_pic">
						<div style="position: absolute; left: 110px;width:320px; border: 0px solid green;  ">
							<h2>Novi Orion Sandlin</h2>
							Please be patient while all these photos download.<br>
							Just go get a cup of coffee and come back.<br>
							Once the photos are finished loading, you can roll your cursor over each photo on the left, or click the prev/next below.<br>
                 </div>
                 <div style="margin-left: auto; margin-right: auto; position: relative;width: 500px; height: 500px;">
                    <img name="bigpic" class="big" src="<?=$photos[0]?>">
                 </div>
                 <div>
                     <a class="arrow" href="#" onclick="prevPhoto();"><< PREV</a>&nbsp;&nbsp;<a class="arrow" href="#" onclick="nextPhoto();">NEXT >></a>
                 </div>
         </div>
        </div>
</div>
</body>