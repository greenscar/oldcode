<?php
if (!empty($_SERVER['HTTP_USER_AGENT'])) 
{ 
   $HTTP_USER_AGENT = $_SERVER['HTTP_USER_AGENT']; 
} 
else if (!empty($HTTP_SERVER_VARS['HTTP_USER_AGENT'])) 
{ 
   $HTTP_USER_AGENT = $HTTP_SERVER_VARS['HTTP_USER_AGENT']; 
} 
else if (!isset($HTTP_USER_AGENT)) 
{ 
   $HTTP_USER_AGENT = ''; 
} 
if (ereg('Opera(/| )([0-9].[0-9]{1,2})', $HTTP_USER_AGENT, $log_version)) 
{ 
   $browser_version = $log_version[2]; 
   $browser_agent = 'opera'; 
} 
else if (ereg('MSIE ([0-9].[0-9]{1,2})', $HTTP_USER_AGENT, $log_version)) 
{ 
   $browser_version = $log_version[1]; 
   $browser_agent = 'ie'; 
} 
else if (ereg('OmniWeb/([0-9].[0-9]{1,2})', $HTTP_USER_AGENT, $log_version)) 
{ 
   $browser_version = $log_version[1]; 
   $browser_agent = 'omniweb'; 
} 
else if (ereg('Netscape([0-9]{1})', $HTTP_USER_AGENT, $log_version)) 
{ 
   $browser_version = $log_version[1]; 
   $browser_agent = 'netscape'; 
} 
else if (ereg('Mozilla/([0-9].[0-9]{1,2})', $HTTP_USER_AGENT, $log_version)) 
{ 
   $browser_version = $log_version[1]; 
   $browser_agent = 'mozilla'; 
} 
else if (ereg('Konqueror/([0-9].[0-9]{1,2})', $HTTP_USER_AGENT, $log_version)) 
{ 
   $browser_version = $log_version[1]; 
   $browser_agent = 'konqueror'; 
} 
else 
{ 
   $browser_version = 0; 
   $browser_agent = 'other'; 
}
/*
echo '<HR WIDTH="100%" COLOR="black"/>';
print '<B>Browser Type:</B> ' . $browser_agent; 
echo '<BR />';
print '<B>Browser Version #:</B> ' . $browser_version;
echo '<HR WIDTH="100%" COLOR="black"/><PRE><B>Full Details:</B> ';
print_r( $HTTP_USER_AGENT );
echo '</PRE><HR WIDTH="100%" COLOR="black"/>';
*/
?>