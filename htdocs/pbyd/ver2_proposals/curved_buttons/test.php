<?php
$body_width = 750;
$body_height = 550;
$button_width = $body_width / 4;
$button_height = $body_height / 15;
?>
<html>
<head>
<title>
<?php
echo("Hello");
if(empty($page_height)) $page_height = 700;
?>
</title>
</head>
<body style="">
<!-- START BODY DIV -->
   <div style="margin-top:10px;padding:0px;height:<?php echo($page_height); ?>px;width:765px;border:#E73C5E 1px solid;background-color:#F8DEEB;margin-left: 0px; margin-right: auto;">
   <!-- START MAIN DIV -->
      <div style="position: relative; left: -1px; top: -1px; width: <?php echo($button_width); ?>; height: <?php echo($button_height); ?>px; border: 1px solid #000000">
         top_left
      </div>
      <div style="position: relative; left: <?php echo($body_width - $button_width - 2);?>px; top: -<?php echo($button_height + 1); ?>px; width: <?php echo($button_width); ?>px; height: <?php echo($button_height); ?>px; border: 1px solid #000000">
         top_right
      </div>
      <div style="position: relative; left: -1px; top: <?php echo($body_height - ($button_height * 3) - 4); ?>px; width: <?php echo($button_width); ?>; height: <?php echo($button_height); ?>px; border: 1px solid #000000">
         bottom_left
      </div>
      <div style="position: relative; left: <?php echo($body_width - $button_width - 2);?>px; top: <?php echo($body_height - ($button_height * 4) - 6); ?>px; width: <?php echo($button_width); ?>; height: <?php echo($button_height); ?>px; border: 1px solid #000000">
         bottom_right
      </div>
   </div>
</body>
</html>
