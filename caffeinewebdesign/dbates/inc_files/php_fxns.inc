<?php
$state_array = array("OR"=>"Oregon", "WA"=>"Washington", "ID"=>"Idaho", "WY"=>"Wyoming", "CA"=>"California", "CO"=>"Colorado");

function get_first_n_cons($str, $n)
{
    $temp = preg_replace("/[AEIOU]+/", "", $str);
    $temp = substr($temp, 0, $n);
    return $temp;
}

/*
* These 2 functions are used to display the contents of any array.
* This can be single or multidimensional.
*/
function view_array($arr){
    $toReturn = "\t<TABLE CELLPADDING=\"0\" CELLSPACING=\"0\" BORDER=\"1\">\n";
	foreach ($arr as $key1 => $elem1) 
	{
		$toReturn .= "\t\t<TR>\n";
		$toReturn .= "\t\t\t<TD>$key1&nbsp;</TD>\n";
		if (is_array($elem1))  
			extArray($elem1);
      else if (is_object($elem1))
        $toReturn .= "\t\t\t<TD>An Object&nbsp;</TD>\n"; 
		else  
			$toReturn .= "\t\t\t<TD>". stripslashes($elem1)."&nbsp;</TD>\n"; 
		$toReturn .= "\t\t</TR>\n";
	}
	$toReturn .= "\t</TABLE>\n";
   return $toReturn;
}
	
function email($sender, $subject, $message)
{
    $toAddress = "info@dbates.com";
	$toName = "Information";
	//$toAddress = "james@caffeinewebdesign.com";
	$recipient = $toName." <".$toAddress.">";   
	
    require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
    $log = new Secretary();
    $log->write("email($recipient, $sender, $subject, $message)");
    
    $headers  = "MIME-Version: 1.0\r\n";
    $headers .= "Content-type: text/html; charset=iso-8859-1\r\n";
    $headers .= "From: $sender\r\nReply-To: $sender\r\nX-Mailer: PHP/" . phpversion() . "\r\n";
    
    /* To send HTML mail, you can set the Content-type header. */
    $toReturn = mail("$recipient", "$subject", $message,
        "From: $sender\r\nReply-To: $sender\r\n" .
        "Content-Type: text/html; charset=iso-8859-1\r\n" .
        "X-Mailer: PHP/" . phpversion());
    $log->write("php_fxns email() returning $toReturn");
    return($toReturn);
}
//This function is called from view_array to take care of multi-dimensional arrays
function extArray($arr){
	echo("\t\t\t<TD>\n");
	echo "\t<TABLE CELLPADDING=\"0\" CELLSPACING=\"0\" BORDER=\"1\">\n";
	foreach ($arr as $key => $elem) 
	{
		echo("\t\t<TR>\n");
		echo("\t\t\t<TD>$key&nbsp;</TD>\n");
		if (is_array($elem)) 
			extArray($elem);
		else 
			echo("\t\t\t<TD>". stripslashes($elem)."&nbsp;</TD>\n");
		echo("\t\t</TR>\n");
	}
	echo("\t</TABLE>\n");
	echo("</TD>\n");
}



function addArray(&$array, $key, $val)
{
   $tempArray = array($key => $val);
   $array = array_merge ($array, $tempArray);
} 

?>