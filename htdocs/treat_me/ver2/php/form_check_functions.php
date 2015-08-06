<?php
############################################################# 
# This function checks email for validity5: 
# check for '@', '.' characters and bad characters that you 
# can define yourself. 
# Contact us at: webmaster@php.inc.ru 
# Welcome to our Web site at http://php.inc.ru 
############################################################# 
function check_email($email) 
{ 
	$emailArray = preg_split('//', $email); 
    $atSign = false; 
    $dotSign = false; 
    $badCharacter = false; 
    $validEmail = true; 
	if (in_array ("@", $emailArray)) 
	{ 
    	$atSign = true; 
    } 
    if (in_array (".", $emailArray)) 
	{ 
    	$dotSign = true; 
    } 
	$badCharactersArray = array('#', '$', '%', '(', ')', '&', '!');    // Add your own bad 
	for ($i = 0; $i < sizeof($badCharactersArray); $i++) 
	{ 
		if (in_array ($badCharactersArray[$i], $emailArray)) 
    	{ 
    		$badCharacter = true; 
    	} 
	} 
	if ((!$atSign) or (!$dotSign) or ($badCharacter)) 
    	$validEmail = false; 
}


/*
* This is a prebuilt combobox of states and provinces with the ability to easily preset the combobox to a preferred value. 
* The next line is an example of how the code would be called 
*
* <? 
*	echo CB_STATES("CA"); 
* ?> 
*
* This should give you the combobox with California already selected. 
*/

function CB_STATES($vState = NULL) 
{ 
	$dataSet=""; 
	$DBconn=""; 
	$stateRS=""; 
	$lb=""; 
	$statearr=GetAllStates(); 
	$lb="<select name='textState' size='1'>"; 
	while(list($key,$val)=each($statearr)){ 
		$lb=$lb . "<option value='$key'"; 
		if (!is_null($vState)) 
			if (trim($vState)==trim($key)) $lb=$lb . " Selected "; 
            	$lb=$lb . ">$val</option>"; 
	} //end while 
	$lb = $lb . "</Select>"; 
	return $lb; 
} //end function CB_STATES 

function GetAllStates() 
{ 
	$thisarr=array("AL"=>"Alabama", 
				"AK"=>"Alaska", 
				"AB"=>"Alberta, Canada", 
				"AS"=>"American Samoa", 
				"AZ"=>"Arizona", 
				"AR"=>"Arkansas", 
				"BC"=>"British Columbia, Canada", 
				"CA"=>"California", 
				"CO"=>"Colorado", 
				"CT"=>"Connecticut", 
				"DE"=>"Delaware", 
				"DC"=>"District of Columbia", 
				"FM"=>"Federated Micronesia", 
				"FL"=>"Florida", 
				"GA"=>"Georgia", 
				"GU"=>"Guam", 
				"HI"=>"Hawaii", 
				"ID"=>"Idaho", 
				"IL"=>"Illinois", 
				"IN"=>"Indiana", 
				"IA"=>"Iowa", 
				"KS"=>"Kansas", 
				"KY"=>"Kentucky", 
				"LA"=>"Louisiana", 
				"ME"=>"Maine", 
				"MB"=>"Manitoba, Canada", 
				"MH"=>"Marshall Islands", 
				"MD"=>"Maryland", 
				"MA"=>"Massachusetts", 
				"MI"=>"Michigan", 
				"MN"=>"Minnesota", 
				"MS"=>"Mississippi", 
				"MO"=>"Missouri", 
				"MT"=>"Montana", 
				"NE"=>"Nebraska", 
				"NV"=>"Nevada", 
				"NB"=>"New Brunswick, Canada", 
				"NH"=>"New Hampshire", 
				"NJ"=>"New Jersey", 
				"NM"=>"New Mexico", 
				"NY"=>"New York", 
				"NF"=>"Newfoundland, Canada", 
				"NC"=>"North Carolina", 
				"ND"=>"North Dakota", 
				"NT"=>"North West Territory, Canada", 
				"MP"=>"Northern Marianas", 
				"NS"=>"Nova Scotia, Canada", 
				"OH"=>"Ohio", 
				"OK"=>"Oklahoma", 
				"ON"=>"Ontario, Canada", 
				"OR"=>"Oregon", 
				"PW"=>"Palau", 
				"PA"=>"Pennsylvania", 
				"PE"=>"Prince Edward Island, Canada", 
				"PR"=>"Puerto Rico", 
				"PQ"=>"Quebeq, Canada", 
				"RI"=>"Rhode Island", 
				"SK"=>"Saskatchewan, Canada", 
				"SC"=>"South Carolina", 
				"SD"=>"South Dakota", 
				"TN"=>"Tennessee", 
				"TX"=>"Texas", 
				"UT"=>"Utah", 
				"VT"=>"Vermont", 
				"VI"=>"Virgin Islands", 
				"VA"=>"Virginia", 
				"WA"=>"Washington", 
				"WV"=>"West Virginia", 
				"WI"=>"Wisconsin", 
				"WY"=>"Wyoming", 
				"YT"=>"Yukon Territories, Canada"); 
	return $thisarr; 
} //end function 

//phone number check
if(eregi("^\([0-9]{3}\)[[:space:]][0-9]{3}\-[0-9]{4}$", $num)) // Heart of it all. This expression is what checks the validity. 
    echo "$num is valid."; // If the input matches the regular expression, it is valid, thus the script echoing so. 

?>