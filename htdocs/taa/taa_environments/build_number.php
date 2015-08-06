<?php
$pagefile = file('http://tiers-ast03/jsp/utils/environmentTest.jsp');
$buildstream = trim($pagefile[62]);
$buildtime = trim($pagefile[68]);
echo("stream = " . $buildstream . "<br>");
echo("time = " . $buildtime . "<br>");

foreach($pagefile as $id=>$val)
{
   //if((isset($val)))
     // echo("$id = <div style=\"color:red;\">$val</div>");
//   echo("<br>");
}
//print_r(http_parse_message(http_get(URL, array('redirect' => 3))));

?>
<?php
// Get a file into an array.  In this example we'll go through ADMIN_HTTP to get
// the HTML source of a URL.
$lines = file('http://tiers-ast02/jsp/utils/environmentTest.jsp');

// Loop through our array, show HTML source as HTML source; and line numbers too.
foreach ($lines as $line_num => $line) {
//   echo "Line #<b>{$line_num}</b> : " . htmlspecialchars($line) . "<br />\n";
}

// Another example, let's get a web page into a string.  See also file_get_contents().
$html = implode('', file('http://tiers-ast02/jsp/utils/environmentTest.jsp'));
?> 
