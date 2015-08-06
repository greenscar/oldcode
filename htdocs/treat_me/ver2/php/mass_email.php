<?php


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
while($row = mysql_fetch_row($html))
{
    //echo($row[1] . " " . $row[2] . " - " . $row[0] ."<br>");
    //addArray($htmlToArray, $row[0], $row[1]);
}
addArray($htmlToArray, "james", "laptop@caffeinewebdesign.com");
echo("socketmail");
echo("socketmail = " . socketmail($htmlToArray, "treats@treatbeauty.com", "Treat Beauty", "text/html", "test", "TEST"));
/*
if(!empty($htmlToArray) && !empty($topic) && !empty($htmlBody))
{
    if (send_mail("Treat Beauty", "treats@treatbeauty.com", "James Sandlin", "laptop@caffeinewebdesign.com", $topic, $htmlBody))
    {
        echo("<html><header><title>Your email was successful.</title>");
        echo("<meta http-equiv=\"refresh\" content=\"3;URL=http://www.treat-me.biz/php/admin\">");
        echo("</header><body><h1 align=\"center\">Your email was successful.</h1>");
        echo("<h3 align=\"center\">You will be forwarded to your menu in 1 second.</h3>");
        echo("</body></html>");
    }
    else
    {
        echo("Error. Please go <a href=\"massMail.htm\">HERE</a> and enter your mail information.<BR>");
    }
}
else
{
    echo("Error. Please go <a href=\"massMail.htm\">HERE</a> and enter your mail information.<BR>");
}
*/
/*
 * END Mail the HTML format group.
 */


function addArray(&$array, $key, $val)
{
   $tempArray = array($key => $val);
   $array = array_merge ($array, $tempArray);
} 
function send_mail($myname, $myemail, $contactname, $contactemail, $subject, $message)
{
// Report all PHP errors (bitwise 63 may be used in PHP 3)
error_reporting(E_ALL);
   $headers = "MIME-Version: 1.0\n";
   $headers .= "Content-type: text/html; charset=iso-8859-1\n";
   $headers .= "From: \"".$myname."\" <".$myemail.">\n";
       
   if ($bcc != "")
       $headers .= "Bcc: ".$bcc."\n";    
   $output = $message;                $output = wordwrap($output, 72);
   return(mail("\"".$contactname."\" <".$contactemail.">", $subject, $output, $headers));
}

/*
 * $mailFormat should be text/plain or text/html
 */
function socketmail($toArray, $from, $senderName, $mailFormat, $subject, $message)
{
// Report all PHP errors (bitwise 63 may be used in PHP 3)
error_reporting(E_ALL);
    // $toArray format --> array("Name1" => "address1", "Name2" => "address2", ...)
    ini_set(sendmail_from, "$from");
    $connect = fsockopen ("localhost", 25, $errno, $errstr, 30) or die("Could not talk to the sendmail server!");
    $rcv = fgets($connect, 1024);
    fputs($connect, "HELO {$_SERVER['SERVER_NAME']}\r\n");
    $rcv = fgets($connect, 1024);
    while (list($toKey, $toValue) = each($toArray)) {
        fputs($connect, "MAIL FROM:$from\r\n");
        $rcv = fgets($connect, 1024);
        fputs($connect, "RCPT TO:$toValue\r\n");
        $rcv = fgets($connect, 1024);
        fputs($connect, "DATA\r\n");
        $rcv = fgets($connect, 1024);
        fputs($connect, "Subject: $subject\r\n");
        fputs($connect, "From: $senderName <$from>\r\n");
        fputs($connect, "To: $toKey  <$toValue>\r\n");
        fputs($connect, "X-Sender: <$from>\r\n");
        fputs($connect, "Return-Path: <$from>\r\n");
        fputs($connect, "Errors-To: <$from>\r\n");
        fputs($connect, "X-Mailer: PHP\r\n");
        fputs($connect, "X-Priority: 3\r\n");
        fputs($connect, "Content-Type: $mailFormat; charset=iso-8859-1\r\n");
        fputs($connect, "\r\n");
        fputs($connect, stripslashes($message)." \r\n");
        fputs($connect, ".\r\n");
        $rcv = fgets($connect, 1024);
        fputs($connect, "RSET\r\n");
        $rcv = fgets($connect, 1024);
    }
    fputs ($connect, "QUIT\r\n");
    $rcv = fgets ($connect, 1024);
    fclose($connect);
    ini_restore(sendmail_from);
}
 
?>