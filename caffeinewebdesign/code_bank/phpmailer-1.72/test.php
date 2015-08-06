<?
require("class.phpmailer.php");

$mail = new PHPMailer();

$mail->IsSMTP();                                   // send via SMTP
$mail->Host     = "smtp.1and1.com"; // SMTP servers
$mail->SMTPAuth = true;     // turn on SMTP authentication
$mail->Username = "m36686653-1";  // SMTP username
$mail->Password = "Z00l0069"; // SMTP password

$mail->From     = "from@email.com";
$mail->FromName = "Mailer";
$mail->AddAddress("james@caffeinewebdesign.com","James Sandlin");
$mail->AddAddress("jsandlin@gmail.com");               // optional name
$mail->AddReplyTo("info@site.com","Information");

$mail->WordWrap = 50;                              // set word wrap
//$mail->AddAttachment("/var/tmp/file.tar.gz");      // attachment
//$mail->AddAttachment("/tmp/image.jpg", "new.jpg");
$mail->IsHTML(true);                               // send as HTML

$mail->Subject  =  "Here is the subject";
$mail->Body     =  "This is the <b>HTML body</b>";
$mail->AltBody  =  "This is the text-only body";

if(!$mail->Send())
{
   echo "Message was not sent <p>";
   echo "Mailer Error: " . $mail->ErrorInfo;
   exit;
}

echo "Message has been sent";

?>