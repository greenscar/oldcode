<?php
$title = "Treat Maraschino Milk Whipped Cream";
include("header.inc");
?>
<table style="width: 700px; margin-top: 30px;" border=0>
<tr>
   <td width=350px;>
      <table>
         <tr>
            <td>
               <div class="itemNameLarge">Maraschino Milk</div>
            </td>
         </tr>
         <tr>
            <td>
               <div class="itemNameSmall">whipped cream<br>with<br>white tea & cherries</div>
            </td>
         </tr>
         <tr>
            <td class="itemDescription">
               To make this soothing body confection we started with a decadent whipped cream mixed with shea butter, aloe and milk. We added sweet cherry extract known for its anti-inflammatory properties and drizzled on deliciously soothing honey and white tea to heal and protect. Spread this mouth-watering recipe from head to toe to soothe and protect dry skin.<br>
               <p align="center">8 oz&nbsp;&nbsp;&nbsp;$20.00</p>
            </td>
         </tr>
         <tr>
            <td align="center">
               <a href="./php/add_cart.php?UID=<?php echo($UID); ?>&itemID=369" class="button">
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
               <img src="./images/menu_maraschinomilk.jpg">
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