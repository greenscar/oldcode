       
         </td>
        </tr>
        <tr>
        <td align="center" colspan="2" style="background-color:#<?php echo($bgcolor); ?>; border-top: 1px #006390 solid; border-bottom: 2px #006390 solid; top: 0px;left: 0px;padding: 0px;">
        <?php
            if(empty($color))
            {
                $color = "black";
            }
        ?>
         <a href="./index.php" class="menuBottom" style="color:<?php echo($color);?>">Home</a>
         <a href="mailto:info@dbates.com" class="menuBottom" style="color:<?php echo($color);?>">Contact Us</a>
         <a href="./site_map.php" class="menuBottom" style="color:<?php echo($color);?>">Site Map</a>
         <a href="./search.php" class="menuBottom" style="color:<?php echo($color);?>">Search Site</a>
         <a href="./privacy.php" class="menuBottom" style="color:<?php echo($color);?>">Privacy Policy</a>
         <a href="http://www.caffeinewebdesign.com" class="menuBottom"  target="_BLANK" style="color:<?php echo($color);?>">Site by Caffeine Web Design</a>
      
      <?php //include("menu_bottom.inc");?>
      </td>
      </tr>
   </table>
</body>