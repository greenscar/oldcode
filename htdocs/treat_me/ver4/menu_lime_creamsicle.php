<?php
$title = "Treat Lime Creamsicle Whipped Cream Scrub";
include("header.inc");
?>
<table style="width: 700px; margin-top: 30px;" border=0>
<tr>
   <td width=350px;>
      <table>
         <tr>
            <td>
               <div class="itemNameLarge">Lime Creamsicle</div>
            </td>
         </tr>
         <tr>
            <td>
               <div class="itemNameSmall">whipped cream scrub<br>with<br>papaya & honey</div>
            </td>
         </tr>
         <tr>
            <td class="itemDescription">
               To make this smoothing confection we mixed up decadent whipped cream with shea butter and healing jojoba. We added almond meal to exfoliate and drizzled on soothing honey and papaya for extra nourishment. Finally we sweetened the recipe with refreshing lime and vanilla. For sweet and smooth skin scrub with Lime Creamsicle 2-3 times a week.<br>
               <p align="center">8 oz&nbsp;&nbsp;&nbsp;$20.00</p>
            </td>
         </tr>
         <tr>
            <td align="center">
               <a href="./php/add_cart.php?UID=<?php echo($UID); ?>&itemID=367" class="button">
                  <div class="button">
                     Add to Treat Bag
                  </div>
               </a>
            </td>
         </tr>
         <tr>
            <td align="center">
               <a href="treat_menu.php?UID=<?php echo($UID); ?>" class="button">
                  <div class="button" style="float:left;">
                     Back to Treat Menu
                  </div>
               </a>
               <a href="./php/view_cart.php?UID=<?php echo($UID); ?>" class="button">
                  <div class="button" style="float:right;">
                     Checkout
                  </div>
               </a>
            </td>
         </tr>
      </table>
   </td>
   <td style="width: 30px;">
      &nbsp;
   </td>
   <td>
      <table>
         <tr>
            <td>
               <img src="./images/menu_limecreamsicle.jpg">
            </td>
         </tr>
      </table>
   </td>
</table>
<table style="width: 650px; margin-top: 30px;" border=0>
</table>
<?
include("footer.inc");
?>
