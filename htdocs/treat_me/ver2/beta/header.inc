<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<style type="text/css">@import "css_template.css"; </style>
<script language="JavaScript" type="text/javascript" src="./javascript.js"></script>
<title>
<?php
echo($title);
if(empty($page_height)) $page_height = 700;
?>
</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="margin-top:10px;padding:0px;text-align:center;"<?php if(!empty($on_load)) echo(" onload=\"javascript:" . $on_load . "\""); ?>>
    <!-- ENTIRE BODY DIV -->
    <div style="width:765px;height:<?php echo($page_height); ?>px;border:#EE2D68 1px solid;background-color:#F8DEEB;margin-left: auto; margin-right: auto;"> 
        <!-- LOGO -->
        <a href="index.php">
            <img src="images/treat_logo.gif" border="0" style="position:relative; z-index:2; left:22px;top:7px; border-color:white;"> 
        </a>
        <!-- END LOGO -->
        <!-- PAGE TITLE -->
        <?php if(!empty($page_header)){?>
        <img src="<?php echo($page_header); ?>" style="position:relative;left:5px; top:-5px;"> 
        <?php } ?>
        <!-- END PAGE TITLE -->
        <img src="images/bar.gif" style="position:relative; z-index:1; left:2px; top:-10px;">
        <!-- START MENU FRAME -->
        <div class="menuframe">
            <a href="index.php" class="button" style="margin-top:15px;"> 
                <div class="arialfourteen">Home</div> 
            </a>
            <a href="delicious_news_press.php" class="button"> 
                <div class="arialfourteen">Delicous News</div>
                <div class="arialtwleve">press</div>
            </a>
            <a href="treats_story.php" class="button"> 
                <div class="arialfourteen">Baked Idea</div>
                <div class="arialtwleve">Treat's story</div>
            </a>
            <a href="treat_menu.php" class="button"> 
                <div class="arialfourteen">Treat Menu</div>
                <div class="arialtwleve">shop online</div>
            </a>
            <a href="treat_shops.php" class="button"> 
                <div class="arialfourteen">Treat Shops</div>
                <div class="arialtwleve">where to buy Treat</div>
            </a>
            <a href="treat_recipes.php" class="button"> 
                <div class="arialfourteen">Treat Recipes</div>
            </a>
            <a href="contact.php" class="button"> 
                <div class="arialfourteen">Contact</div>
            </a>
            <a href="customer_care.php" class="button"> 
                <div class="arialfourteen">Customer care</div>
            </a>
            <a href=# class="button" style="border-width:0px;">
                <img style="border-width:0px;" src="images/shopping_bag.gif">
            </a>
        <div>
        <!-- FINISHED MENU FRAME -->