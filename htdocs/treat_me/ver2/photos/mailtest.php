<?php
$recipient = "laptop@caffeinewebdesign.com";
$subject = "work";
$message = "<HTML><H1 COLOR=\"red\">HELLO</H1></HTML>";
$sender = "Satan@hell.com";
mail("$recipient, james@caffeinewebdesign.com", "$subject", $message,
     "From: $sender\r\n"
    ."Reply-To: $sender\r\n"
         ."Content-Type: text/html; charset=iso-8859-1\r\n"
    ."X-Mailer: PHP/" . phpversion());
echo("Done");
?>

