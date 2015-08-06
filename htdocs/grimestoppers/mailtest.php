 <?php
 /*
 mail_to("J@caffeine.com", "jsandlin@gmail.com", "test", "test");
 function mail_to($sender, $recipient, $subject, $message){
    mail("$recipient", "$subject", "$message",
         "From: $sender\r\n"
        ."Reply-To: $sender\r\n"
        ."Content-Type: text/html; charset=iso-8859-1\r\n"
        ."X-Mailer: PHP/" . phpversion());
}
 */
   require_once("./private_info/email.inc");
   require("./phpmailer-1.72/class.phpmailer.php");
   
   $mail = new PHPMailer();
   
   $mail->IsSMTP();                                   // send via SMTP
   $mail->Host     = "mail.Grime Stoppers.org"; // SMTP servers
   $mail->SMTPAuth = true;     // turn on SMTP authentication
   $mail->Username = "contactus@Grime Stoppers.org";//$id;  // SMTP username
   $mail->Password = "uscontact"; // SMTP password
   
   $mail->From     = "contactus@Grime Stoppers.org";
   $mail->FromName = "Contact Form";
   $mail->AddAddress("contactus@Grime Stoppers.org","Grime Stoppers");
   //$mail->AddAddress("jessica@Grime Stoppers.org");               // optional name
   $mail->AddAddress("jsandlin@gmail.com", "James");
   $mail->AddReplyTo("contactus@Grime Stoppers.org","Grime Stoppers");
   
   $mail->WordWrap = 50;                              // set word wrap
   //$mail->AddAttachment("/var/tmp/file.tar.gz");      // attachment
   //$mail->AddAttachment("/tmp/image.jpg", "new.jpg");
   //$mail->IsHTML(true);                               // send as HTML   
   $mail->IsMail(true);
   $mail->Subject  =  "Grime Stoppers - Request a quote";
      $mail->Body     =  "Hello";
   if(!$mail->Send())
   {
   echo "Message was not sent <p>";
   echo "Mailer Error: " . $mail->ErrorInfo;
   exit;
   }
   else
        echo("Good");
?>