<?php
$title = "Treat Menu";
include("header.inc");
?>
<div style="position: relative;height: 720px;">
   <span style="position: absolute; top: 40px; left: -70px;">
      <img src="images/menu_treat_favorites.gif">
   </span>
   <span style="position: absolute; top: 75px; left: -100px;">
      <img src="images/menu_when_life_gives_you_lemons.gif">
   </span>
   <span style="position: absolute; top: 240px; left: -100px;">
      <img src="images/menu_tropical_treat.gif">
   </span>
   <span style="position: absolute; top: 390px; left: -100px;">
      <img src="images/menu_treat_truffles.gif">
   </span>
   <span style="position: absolute; top: 20px; left: 130px; border: 0px dashed green; align: right; width: 440px;">
      <div style="font-size:30px; font-family:arial; font-weight:bold;color:#F2E5D9;">
         Fresh from Treat
      </div>
      <div style="font-size:29px; font-family:arial; font-weight:normal; color:#F5AAC8; position: relative; left: 180px;">
         Melt away dry skin
      </div>
      <div class="menuTitle">
         Truffles & Melts
      </div>
      <div class="menuSubTitle">
         Bath
      </div>
      <div class="menuItems">
        <a href="menu_hot_chocolate.php?UID=<?php echo($_GET["UID"]); ?>">Hot Chocolate Bath Melts</a><br>
        <a href="menu_cocoa_truffles.php?UID=<?php echo($_GET["UID"]); ?>">Cocoa Truffle Bath Melts</a><br>
        <a href="menu_trouble_melts.php?UID=<?php echo($_GET["UID"]); ?>">Trouble Melt Bath Truffles</a><br>
        <a href="menu_cordial_cherry.php?UID=<?php echo($_GET["UID"]); ?>">Cordial Cherry Cocoa Sorbet Bath Truffles</a><br>
        <a href="menu_blueberry_bliss.php?UID=<?php echo($_GET["UID"]); ?>">Blueberry Bliss Cocoa Sorbet Bath Truffles</a>
      </div>
      <div class="menuSubTitle">
         Body
      </div>
      <div class="menuItems">
        <a href="menu_shea_body_butter_melts.php?UID=<?php echo($_GET["UID"]); ?>">Shea Body Butter Melts</a>
      </div>
      <div class="menuTitle">
         Bath & Shower Treats
      </div>  
      <div class="menuSubTitle">
         Cleanser
      </div>
      <div class="menuItems">
        <a href="menu_lemon_drop.php?UID=<?php echo($_GET["UID"]); ?>">Treat Lemon Drop</a> 
      </div>
      <div class="menuSubTitle">
         Bubble Bath
      </div>    
      <div class="menuItems">
        <a href="menu_gum_drop.php?UID=<?php echo($_GET["UID"]); ?>">Treat Gum Drop</a> 
      </div>
      <div class="menuTitle">
         Body Glaze
      </div>
      <div class="menuItems">
        <a href="menu_sweet_on_you.php?UID=<?php echo($_GET["UID"]); ?>">Sweet on You</a>
      </div>
      <div class="menuTitle">
         Body Creams
      </div>
      <div class="menuItems">
        <a href="menu_banana_pudding.php?UID=<?php echo($_GET["UID"]); ?>">Treat Banana Pudding</a><br>
        <a href="menu_maraschino_milk.php?UID=<?php echo($_GET["UID"]); ?>">Treat Maraschino Milk</a><br> 
        <a href="menu_luscious_lemon.php?UID=<?php echo($_GET["UID"]); ?>">Treat Luscious Lemon</a>
      </div>
      <div class="menuTitle">
         Face Treats
      </div>
      <div class="menuItems">
        <a href="menu_apple_butter.php?UID=<?php echo($_GET["UID"]); ?>">Treat Apple Butter</a> 
      </div>
      <div class="menuTitle">
         Hand Treats
      </div>
      <div class="menuItems">
        <a href="menu_handy_candy.php?UID=<?php echo($_GET["UID"]); ?>">Treat Handy Candy</a> 
      </div>
      <div class="menuTitle">
         Body Scrubs & Treatments
      </div>
      <div class="menuSubTitle">
         Scrubs
      </div>
      <div class="menuItems">
          <a href="menu_lime_creamsicle.php?UID=<?php echo($_GET["UID"]); ?>">Treat Lime Creamsicle</a><br>
          <a href="menu_peppermint_patty.php?UID=<?php echo($_GET["UID"]); ?>">Treat Peppermint Patty</a><br>
          <a href="menu_brown_sugar_smoothie.php?UID=<?php echo($_GET["UID"]); ?>">Brown Sugar Smoothie</a>
      </div>
      <div class="menuSubTitle">
         Mud
      </div>
      <div class="menuItems">
          <a href="menu_blueberry_mud_pie.php?UID=<?php echo($_GET["UID"]); ?>">Blueberry Mud Pie</a>
      </div>
   </span>
   <span style="position: absolute; top: 0px; left: 370px; border: 0px dashed #00FFFF; align: right; width: 200px;">
      <div style="position: absolute; top: 30px;left: 220px; z-index: 1;">
         <img src="images/menu_hot_chocolate_bath_melts.gif">
      </div>
      <div style="position: absolute; top: 200px; left: 10px; z-index: 5;">
         <img src="images/menu_shea_body_butter_melts.gif">
      </div>
      <div style="position: absolute; top: 330px; left: 200px; z-index: 1;">
         <img src="images/menu_bottom_right.gif">
      </div>
   </span>
   <!--
   <span style="position: absolute; top: 10px; left: 465px; border: 0px dashed green; align: right; width: 490px;">
      <div style="font-size:30px; font-family:arial; font-weight:bold;color:#F2E5D9;">
         Fresh from Treat
      </div>
      <div style="position: relative; padding-top: 10px;left: 100px;">
         
      </div>
   </span>
   -->
</div>
<?php
include("footer.inc");
?>