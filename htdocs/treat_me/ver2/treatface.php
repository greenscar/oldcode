<?php
    require_once("./php/session_header.php");
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>TreatBeauty.com - Treat Face</title>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<link href="text.css" rel="stylesheet" type="text/css">
<style>
<!--
div.Section1
	{page:Section1;}
span.SpellE
	{}
-->
</style>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">
<form name="form1" method="post" action="">
  <table width="1" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td height="135" align="left" valign="top" background="images/top_yellowbg.gif" width="1104"><table width="741" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="29" rowspan="2" align="left"><img src="images/spacer.gif" width="29" height="20"></td>
            <td align="left" valign="top"><table width="712" border="0" cellpadding="0" cellspacing="0" background="images/top_bg.gif">
                <tr> 
                  <td width="8" align="left"><img src="images/top_cor01.gif" width="8" height="36"></td>
                  <td width="695" align="center">&nbsp;</td>
                  <td width="9" align="right"><img src="images/top_cor02.gif" width="9" height="36"></td>
                </tr>
              </table></td>
          </tr>
          <tr> 
            <td><table width="712" border="0" cellpadding="0" cellspacing="0" class="text">
                <tr class="text"> 
                  <td width="246" align="left">
                  <?php
                    echo("<a target=\"_top\" href=\"index.php?UID=" . $_GET["UID"] . "\">");
                  ?>
                  <img src="images/logo.gif" border="0" alt="TreatBeauty.com Home" width="246" height="99"></a></td>
                  <td width="286" align="left"><img src="images/toppic.jpg" width="286" height="99"></td>
                  <td width="180" align="center" valign="top" background="images/top01.gif">
                    <font color="#FFFFFF">&nbsp; </font></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td height="63" align="left" valign="top" width="1104"><table width="741" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="29" align="left"><img src="images/spacer.gif" width="29" height="20"></td>
            <td width="33" align="left"><img src="images/top_cor03.gif" width="33" height="63"></td>
            <td width="137" align="left" valign="bottom" bgcolor="FF74D6">
            <img src="images/shop.gif" width="177" height="40"></td>
            <td width="280" align="left"><img src="images/toppic02.gif" width="280" height="63"></td>
            <td width="197" align="center" background="images/top02.gif">&nbsp;</td>
            <td width="25" align="right"><img src="images/top_cor04.gif" width="25" height="63"></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td align="left" valign="top" width="1104">
      <table width="720" height="103" border="0" cellpadding="0" cellspacing="0">
          <tr> 
            <td width="62" align="left" height="103"><img src="images/spacer.gif" width="62" height="20"></td>
            <td width="177" align="left" valign="top" height="103">
            <table width="177" height="842" border="0" cellpadding="0" cellspacing="0" background="images/button_bg.gif">
                <?php include("cat_menu.php"); ?>
            </table></td>
            <td align="center" valign="top" height="103"><br>
              <table width="456" border="0" cellspacing="0" cellpadding="0" height="45">
                <tr>
                  <td width="1" align="left" height="27">
                  <img border="0" src="images/treatfacehead.gif" width="115" height="31"></td>
                  <td width="460" align="left" height="27">
                  <p align="right">
                  <?php
                    echo("<a href=\"./php/view_cart.php?UID=$UID\">\n");
                  ?> 
                  <img border="0" src="images/view.jpg" alt="View Cart / Check Out" width="221" height="29">
                  </a>
                  </p>
                  </td>
                </tr>
                <tr>
                  <td width="456" align="left" height="18" colspan="2">
                  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
                    <tr>
                      <td width="100%" colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="27%" align="center" valign="top">
                        <?php
                            echo("<a href=\"./php/index.php?categoryID=3&itemID=306&UID=" . $_GET["UID"] . "\">");
                        ?>
                        <img border="0" src="images/tfbeauteafulfacescrub.jpg" alt="Beauteaful Face Scrub" width="75" height="100"></a>
                          <p>
                        <?php
                            echo("<a href=\"./php/index.php?categoryID=3&itemID=306&UID=" . $_GET["UID"] . "\">");
                        ?>
                        <img border="0" src="images/buynow.jpg" alt="Buy Now" width="69" height="26"></a>
                        </td>
                      <td width="2%">&nbsp;</td>
                      <td width="71%" align="left" valign="top"><b>
                      <font color="#F0364D" face="Arial" size="2">Beauteaful 
                      Face Scrub</font></b><p class="DESCRIPTION">
                      <font face="Arial" style="font-size: 9pt">Treat's 
                      antioxidant rich Beauteaful Face Scrub contains organic 
                      polyphenols of Green Tea and White Tea to protect while it 
                      removes dead skin cells. Known to be nature's most 
                      powerful antioxidant, green tea extract provides 
                      protection against free radicals and DNA damage. Aloe vera, 
                      olive butter, avocado butter and vitamin E soothe the 
                      newly revealed glowing skin. Price: $28.00</font></td>
                    </tr>
                    <tr>
                      <td width="27%" align="center" valign="top">
                      <p align="center">&nbsp;</td>
                      <td width="2%">&nbsp;</td>
                      <td width="71%" align="left">&nbsp;</td>
                    </tr>
                    <tr>
                      <td width="27%" align="center" valign="top">
                        <p align="center">
                        <?php
                            echo("<a href=\"./php/index.php?categoryID=3&itemID=328&UID=" . $_GET["UID"] . "\">");
                        ?>
                        <img border="0" src="images/tfsavingface.jpg" alt="Saving Face" width="75" height="100"></a></p>
                        <p align="center">
                        <?php
                            echo("<a href=\"./php/index.php?categoryID=3&itemID=328&UID=" . $_GET["UID"] . "\">");
                        ?>
                        <img border="0" src="images/buynow.jpg" alt="Buy Now" width="69" height="26"></a>
                        </td>
                      <td width="2%">&nbsp;</td>
                      <td width="71%" align="left" valign="top"><b>
                      <font color="#F0364D" face="Arial" size="2">Saving Face</font></b><p class="DESCRIPTION">
                      <font face="Arial" style="font-size: 9pt">A moisturizing 
                      Treat to protect, smooth and heal. Contains soothing shea 
                      butter, sweet almond and camellia oil. Alpha lipoic acid 
                      helps to smooth fine lines, diminish discoloration of the 
                      skin and encourage cell renewal. Protects and prevents 
                      with vitamins A, C and E as well as antioxidant rich green 
                      tea and white tea.</font>
                      <font face="Arial" style="font-size: 9pt">Price: $26.00</font></p>
                      </td>
                    </tr>
                    <tr>
                      <td width="27%" align="center" valign="top">&nbsp;</td>
                      <td width="2%">&nbsp;</td>
                      <td width="71%" align="left" valign="top">&nbsp;</td>
                    </tr>
                    <tr>
                      <td width="27%" align="center" valign="top">
                          <p align="center"><p align="center">
                        <?php
                            echo("<a href=\"./php/index.php?categoryID=3&itemID=329&UID=" . $_GET["UID"] . "\">");
                        ?>
                        <img border="0" src="images/tfsweetfacecleansingmilk.jpg" alt="Sweet Face Cleansing Milk" width="75" height="100"></a></p>
                          <p align="center"><p align="center">
                        <?php
                            echo("<a href=\"./php/index.php?categoryID=3&itemID=329&UID=" . $_GET["UID"] . "\">");
                        ?>
                        <img border="0" src="images/buynow.jpg" alt="Buy Now" width="69" height="26"></a>
                        </td>
                      <td width="2%">&nbsp;</td>
                      <td width="71%" align="left" valign="top">
                      <font face="Arial" size="2" color="#F0364D">
                      <span style="font-size: 10pt; font-family: Arial; font-weight: 700">
                      Sweet Face Cleansing Milk</span></font><p class="DESCRIPTION">
                      <font face="Arial" style="font-size: 9pt">Gentle cleansing 
                      for sensitive or mature skin. This soothing Treat gently 
                      cleans and protects with orange peel tincture, shea butter 
                      and lavender. Removes makeup without stripping the skin 
                      and leaves skin smooth and moist. Price: $18.00</font></td>
                    </tr>
                    <tr>
                      <td width="27%" align="center" valign="top">&nbsp;</td>
                      <td width="2%">&nbsp;</td>
                      <td width="71%" align="left" valign="top">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="27%" align="center" valign="top"><p align="center">
                        <?php
                            echo("<a href=\"./php/index.php?categoryID=3&itemID=321&UID=" . $_GET["UID"] . "\">");
                        ?>
                        <img border="0" src="images/tfclearlysweetblemishgel.jpg" alt="Clearly Sweet Blemish Gel" width="75" height="100"></a>
                        <p>
                        <?php
                            echo("<a href=\"./php/index.php?categoryID=3&itemID=321&UID=" . $_GET["UID"] . "\">");
                        ?>
                        <img border="0" src="images/buynow.jpg" alt="Buy Now" width="69" height="26"></a>
                        </td>
                      <td width="2%">&nbsp;</td>
                      <td width="71%" align="left" valign="top">
                      <font size="2" color="#F0364D">
                      <span style="font-family: Arial; font-weight: 700">Clearly 
                      Sweet Blemish Gel</span></font><p class="DESCRIPTION">
                      <font face="Arial" style="font-size: 9pt">Heal and prevent 
                      blemishes with Treat's antiseptic and antioxidant 
                      treatment serum containing cucumber extract and calendula. 
                      Rich in antioxidants green tea, white tea and vitamins A, 
                      C and E to prevent scarring. Can be used as a spot 
                      treatment or lightly layered on the face. <br>
                      Price: $38.00</font></td>
                    </tr>
                    <tr>
                      <td width="27%" align="center" valign="top">&nbsp;</td>
                      <td width="2%">&nbsp;</td>
                      <td width="71%" align="left" valign="top">&nbsp;</td>
                    </tr>
                  </table>
                  </td>
                </tr>
              </table>
              </td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td height="27" valign="bottom" width="1104"><table width="741" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="29" align="left"><img src="images/spacer.gif" width="29" height="20"></td>
            <td width="33" align="left"><img src="images/bottom_cor01.gif" width="33" height="27"></td>
            <td width="177" align="left" valign="bottom">
            <img src="images/bottom_yellow.gif" width="177" height="27"></td>
            <td width="502" align="left" valign="bottom">
            <img src="images/bottom_cor.gif" width="502" height="27"></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td height="89" valign="top" width="1104">
      <table width="819" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="29" align="left" background="images/btmred.gif">&nbsp;</td>
            <td width="10" align="left"><img src="images/pinkcor.gif" width="10" height="89"></td>
            <td width="693" valign="bottom"><table width="693" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="35" align="center" bgcolor="#FF74D7">
                  <table width="680" border="0" cellpadding="0" cellspacing="0" class="text" height="90">
                      <tr class="text">
                        <td width="10" align="left" bgcolor="#FF74D7" height="90"><img src="images/spacer.gif" width="10" height="35"></td>
                        <td align="center" height="90" valign="top">
                        <font color="#FFFFFF"><br>
                        <font face="Arial" size="2">© 2003 TreatBeauty.com All rights reserved.</font></font></td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
            <td width="9" align="right"><img src="images/pinkcor02.gif" width="9" height="89"></td>
            <td width="78" align="right" background="images/btmred.gif">&nbsp;</td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
</body>
</html>