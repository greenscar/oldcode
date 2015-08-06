<?php

function error_handler ($level, $message, $file, $line, $context) { 

   echo "<<<_END_ 
An error of level $level was generated in file $file on line $line. 
The error message was: $message 
The following variables were set in the scope that the error occurred in: 

<blockquote> 
_END_; ";

   print_r ($context); 
   print "\n</blockquote>"; 
} 

// Set the error handler to the error_handler() function 
set_error_handler ('error_handler');


include("header.inc");
// Report all PHP errors (bitwise 63 may be used in PHP 3)
error_reporting(E_ALL);
/*
 * Assign variables.
 */
$from = "marnie@treat-me.biz";
$senderName = "Treat.Inc";
$topic = $_POST["mailTopic"];
$htmlBody = $_POST["mailBody"];
require_once("header.inc");
/*
 * END Assign variables.
 */
/*
 * Connect to the Database.
 */
//$dbcnx = MYSQL_CONNECT($server,$id,$pwd) or DIE("<h1>DATABASE FAILED TO RESPOND.</h1>"); 
//if(!mysql_select_db("$db")){
//        echo("ERROR - Couldn't open $db");
//        exit();
//}
/*
 * END Connect to the Database.
 */


/*
 * Mail the HTML format group.
 */
$htmlToArray = array();
$htmlSelect = "SELECT DISTINCT Email, nameFirst, nameLast FROM buyers";
$html = mysql_query($htmlSelect) or die(mysql_error());
//echo($html);
if(!empty($topic) && !empty($htmlBody))
{
    while($row = mysql_fetch_row($html))
    {
        send_mail("Treat Beauty", "treats@treatbeauty.com", $row[1]. " " . $row[2], $row[0], $topic, $htmlBody)
        //echo($row[1] . " " . $row[2] . " - " . $row[0] ."<br>");
        //addArray($htmlToArray, $row[0], $row[1]);
    }
}
else
{
    echo("Error. Please go <a href=\"massMail.htm\">HERE</a> and enter your mail information.<BR>");
    exit();
}
echo("<html><header><title>Your email was successful.</title>");
echo("<meta http-equiv=\"refresh\" content=\"3;URL=http://www.treat-me.biz/php/admin\">");
echo("</header><body><h1 align=\"center\">Your email was successful.</h1>");
echo("<h3 align=\"center\">You will be forwarded to your menu in 1 second.</h3>");
echo("</body></html>");

/*
 * END Mail the HTML format group.
 */


function addArray(&$array, $key, $val)
{
   $tempArray = array($key => $val);
   $array = array_merge ($array, $tempArray);
} 
function send_mail($myname, $sender, $contactname, $recipient, $subject, $message)
{
    return(mail("$myname <$recipient>", "$subject", $message,
         "From: \"$contactname\" <$sender>\r\n"
        ."Reply-To: \"$contactname\" <$sender>\r\n"
             ."Content-Type: text/html; charset=iso-8859-1\r\n"
        ."X-Mailer: PHP/" . phpversion()));

}

?>