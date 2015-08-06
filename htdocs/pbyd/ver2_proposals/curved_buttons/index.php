<?php
include("./get_browser_type.inc");
$body_width = 750;
$base_body_height = 550;
$background_color = "000000";

if(strcmp($browser_agent, "ie") == 0)
{
   $body_height = $base_body_height;
   $main_button_padding_top=4;
   $main_button_padding_bottom=1;
   $button_height = $body_height / 20;
   $sub_menu_top = -111;
}
else
{
   $body_height = $base_body_height - 4;
   $main_button_padding_top=2;
   $main_button_padding_bottom=0;
   $button_height = $body_height / 17;
   $sub_menu_top = -113;
}
$button_height = $button_height - 8;
$button_height = 25;
$button_width = $body_width / 5;

?>
<html>
<head>
<title><?=$browser_agent?></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<?php include("style.inc");?>
<script language="JavaScript1.2" src='js_menu_fxns.js' type="text/javascript"></script>
<script language="Javascript1.2">
   subMenus = new Array("subMenuGallery", "subMenuAbout");
</script>
</head>
<body onload="init();">
<div class="body">
   <div class="button_bar_top">
      <div class="main_button" style="background-image:url(top_left.jpg); left: 0px; top:0px;z-index:10;" onMouseOver="this.className='main_button_over';" onMouseOut="this.className='main_button';">
         <span class="main_button">HOME</span>
      </div>
      <div class="main_button" style="background-image:url(top_right.jpg); right: 0px; top: 0px;z-index:10;" onMouseOver="this.className='main_button_over';showLayer('subMenuGallery');" onMouseOut="this.className='main_button';">
         <span class="main_button">GALLERY</span>
      </div>
   </div>
   <div class="button_bar_bottom">
      <div class="main_button" style="left: 0px; top: 0px;" onMouseOver="this.className='main_button_over';" onMouseOut="this.className='main_button';">
         <span class="main_button">
            EVENTS
         </span>
      </div>
      <div class="main_button" style="right: -1px; top: -1px;z-index:10;" onclick="self.location='about_us.php'" onMouseOver="this.className='main_button_over';/*showLayer('subMenuAbout');*/" onMouseOut="this.className='main_button';">
         <span class="main_button" >
            ABOUT
         </span>
      </div>
   </div>
   <div name="subMenuGallery" id="subMenuGallery" class="mmSubMenu" style="z-index: 2; right: -1px;top:<?=$sub_menu_top?>px; height:135px;" onMouseOver="showLayer('subMenuGallery'); ">
      <div class="mmSubMenuCell"><a href="weddings.php" class="mmSubMenuCell">Weddings</a></div>
      <div class="mmSubMenuCell"><a href="portraits.php" class="mmSubMenuCell">Portraits</a></div>
      <div class="mmSubMenuCell"><a href="seniors.php" class="mmSubMenuCell">Seniors</a></div>
      <div class="mmSubMenuCell"><a href="children.php" class="mmSubMenuCell">Children</a></div>
      <div class="mmSubMenuCell"><a href="brides.php" class="mmSubMenuCell">Brides</a></div>
   </div>
   <!--
   <div name="subMenuAbout" id="subMenuAbout" class="main_button" style="z-index: 3; right: -1px;bottom:33px; height:50px;" onMouseOver="showLayer('subMenuAbout'); ">
      <div class="mmSubMenuCell"><a href="aboutus.php" class="mmSubMenuCell">About Us</a></div>
      <div class="mmSubMenuCell"><a href="contactus.php" class="mmSubMenuCell">Contact Us</a></div>
   </div>
   -->
   <div id="fxn_hide_layer" class="hideMenu" style="position: absolute; left: -40px; top:0; width: <?=($body_width + 80)?>; height: <?=($body_height + 40)?>; z-index:1;border: 0px solid red;"  onMouseOver="hideLayers();">
      <a  href="javascript:void(0)" >
         <img src="transparent.gif" width="634" height="200" border="0">
      </a>
   </div>
   <div id="hideAll" class="hideMenu" style="
   position: absolute; top:-132; z-index:2;
      margin-left: auto;
      margin-right: auto;
      text-align: center;background-image: url(brushed_metal.jpg); background-repeat: repeat-x; width: <?=($body_width + 20)?>; height: 130px;" onMouseOver="hideLayers();">
   </div>
</div>
   
</body>
</html>
