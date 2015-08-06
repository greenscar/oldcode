
<style type="text/css">
   div.main_button
   {
      position: absolute;
      text-align: center;
      position: absolute;
      width: <?=$button_width?>;
      height: <?php echo($button_height); ?>px;
      border: 2px solid #CCCCCC;
      background-color: #444444;
      color: #000000;
      padding-top: <?=$main_button_padding_top?>px;
      padding-bottom: <?=$main_button_padding_bottom?>px;
      /*background-image: url(black.bmp);*/
      background-image: url(metal_tube.jpg);
      background-repeat: repeat;
      margin: 0px;
   }
   div.main_button_over
   {
      position: absolute;
      text-align: center;
      position: absolute;
      width: <?php echo($button_width); ?>;px;
      height: <?php echo($button_height); ?>px;
      border: 2px solid #FFFFFF;
      background-color: #FFFFFF;
      color: #000000;
      padding-top: <?=$main_button_padding_top?>px;
      padding-bottom: <?=$main_button_padding_bottom?>px;
      background-image: url(white.bmp);
   }
   span.main_button
   {
      font: bold 17px georgia, courier,helvetica;
      border: 0px solid orange;
      width: <?php echo($button_width - 4); ?>;
      height: <?php echo($button_height - 8); ?>px;
      text-decoration:none;
      padding: 0px;
      margin: 0px;
      z-index:15;
   }
   div.button_bar_top
   {
      left: 0px;
      top: <?php
         if(strcmp($browser_agent, "ie") == 0)
            echo("1");
         else
            echo("-2");
      ?>px;
      width: <?php echo($body_width);?>px;
      height: <?php echo($button_height); ?>px;
      border: 0px solid #00FF00;
      z-index: 4;
   }
   div.button_bar_bottom
   {
      position: relative;
      left: 0px;
      top: <?php
         if(strcmp($browser_agent, "ie") == 0)
            echo($body_height - ($button_height * 2) - 10);
         else
            echo($body_height - ($button_height * 2) - 3);
         ?>px;
      width: <?php echo($body_width);?>px;
      height: <?php echo($button_height); ?>px;
      border: 0px solid #FF0000;
      z-index: 4;
   }
   div.body
   {
      width: <?=$body_width?>px;
      height: <?=$body_height?>px;
      border: 2px solid #DDDDDD;
      margin-left: auto;
      margin-right: auto;
      text-align: left;
      position: relative;
      padding:0px;
      z-index:1;
      /*background-image: url(black.bmp);*/
      background-color: #222222;
   }
   
   div.mmSubMenu
   {
      position: absolute;
      text-align: center;
      position: absolute;
      width: <?=$button_width?>;
      height: <?php echo($button_height - 8); ?>px;
      border: 2px solid #DDDDDD;
      padding-top: <?=$main_button_padding_top?>px;
      padding-bottom: <?=$main_button_padding_bottom?>px;
      background-image: url(black.bmp);
      margin: 0px;
      color:#FFFFFF;
   }
   div.mmSubMenuCell
   {
      height: 25px;
      /*
      width: <?php echo($button_width); ?>px;
      border-width: 0px;
      border-color: #000000;
      background-color: #999999;
      border-style: solid;
      padding: 0px;
      */
   }
   a.mmSubMenuCell:link{color:#FFFFFF;text-decoration:none;font: bold 15px georgia, courier,helvetica;}
   a.mmSubMenuCell:visited{color:#00FF00;text-decoration:none;font: bold 15px georgia, courier,helvetica;}
   a.mmSubMenuCell:hover{color:#FF0000;text-decoration:none;font: bold 15px georgia, courier,helvetica;}

</style>