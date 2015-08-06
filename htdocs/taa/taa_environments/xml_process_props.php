<?php
//display("<html>");
//display("<header><title>Online.properties XML</title></header>");
//display("<body>");
require_once("./objects/XML_Parser.inc");
require_once("./objects/XML_Envt.inc");

$var_list = Array();
$xml_envts = Array();

/**********************************************************
* READ FROM A WEB XML
***********************************************************/
//$xml_loc = "http://iedaau019/envts_online.xml";
$xml_loc = "http://localhost/xml_test/app_properties.xml";
$data=read_xml_from_http($xml_loc);
$xml_parser = new XML_Parser();
$return = $xml_parser->parse($data);
//display($return);
//display("sizeof data => " . sizeof($xml_parser->data));
$envts = $xml_parser->data["ENVTS"][0]["child"];
$envts_online = $envts["ONLINE"][0]["child"];
$envts_batch = $envts["BATCH"][0]["child"];
//echo(print_r($envts_online));
/**********************************************************
* END READ FROM A WEB XML
***********************************************************/


/**********************************************************
* CONVERT XML FILE TO XML_Envt OBJECTS
***********************************************************/
foreach($envts_online as $id=>$var)
{
   $envt->name = $id;
   $var = $var[0]["child"];
   
   $envt = new XML_Envt();
   //$envt->set_db($var["USER"][0]["data"], $var["PASSWORD"][0]["data"], $var["URL"][0]["data"]);
   $envt->db_user = get_var($var, "USER");
   $envt->db_password = get_var($var, "PASSWORD");
   $envt->db_url = get_var($var, "URL");  
   
   $envt->ssa_host_name = get_var($var, "IDS_HOST_NAME"); //IDS_HOST_NAME => iedadu004
   $envt->ssa_host_port = get_var($var, "IDS_HOST_PORT"); // 1666
   $envt->ssa_rule_base = get_var($var, "IDS_RULE_BASE"); // ssa:trdev-trdev3
   $envt->ssa_file_clearance = get_var($var, "SSA_CLEARANCE"); // Y    
   
   $envt->uc_host = get_var($var, "UNIVERSAL_SERVER_HOST"); // iedaau002
   $envt->uc_port = get_var($var, "UNIVERSAL_SERVER_PORT"); // 8080
   $envt->uc_acct_id = get_var($var, "UNIVERSAL_SERVER_ACCOUNT_ID"); // tiersuser
   $envt->uc_server_path = get_var($var, "UNIVERSAL_SERVER_PATH"); // dcg/gateway
   
   $envt->ws_alerts = get_var($var, "ALERTS.WEBSERVICE"); // iedaau011.txaccess.net:9080
   $envt->ws_alerts_user_id = get_var($var, "APPT_SCHEDULER_GENERIC_USER_ID"); // user1983
   $envt->ws_alerts_emp_id = get_var($var, "APPT_SCHEDULER_GENERIC_USER_EMP_ID"); // 5683
   $envt->ws_deprovision = get_var($var, "DEPROVISION.WEBSERVICE"); // http://tiers-ast01.txaccess.net/tiersWSWeb/services/UserProvisioningServic
   
   $envt->mq_port = get_var($var, "QUEUEPORT"); // 1420
   $envt->mq_channel = get_var($var, "QUEUECHANNEL"); // TIERS.SVRCONN.CHL
   $envt->mq_manager = get_var($var, "QUEUEMANAGER"); // TIERS.QM6
   $envt->mq_host = get_var($var, "QUEUEHOST"); // iedaau006
   
   /*
   echo("db_user = " . $envt->db_user . "<br>");
   foreach($var as $id=>$var)
   {
      $value = $var[0]["data"];
      echo(strtolower($id) . "  => $value<br>\n");
   }
   echo("<hr>");
   $envt = new XML_Envt();
   $var = $var["child"];
   foreach($var as $id=>$var)
   {
      $value = $var[0]["data"];
      $envt->add_var($id, $value);
   }
*/
   $xml_envts["$envt->name"] = $envt;
   //array_push($xml_envts, $envt);
}
/**********************************************************
* END CONVERT XML FILE TO XML_Envt OBJECTS
***********************************************************/

/**********************************************************
* TURN XML_Envt OBJECTS INTO Online_App & App_Server objects.
***********************************************************/
foreach($xml_envts AS $id=>$envt)
{
   echo("<h4>" . $envt->name . "</h4>");
}
/**********************************************************
* END TURN XML_Envt OBJECTS INTO Online_App & App_Server objects.
***********************************************************/


function get_var($xml, $var_name)
{
   if(isset($xml["$var_name"][0]["data"]))
      return($xml["$var_name"][0]["data"]);
   else
      return("n/a");
}
/*
// CREATE LIST OF VARIABLES
foreach($xml_envts as $id=>$envt)
{
   $env_id = $envt->get_id();
   foreach($envt->vars as $id=>$var)
   {
      //echo(strtolower($id) . " = " . $envt->$id . "<BR>");
      display("var \$" . strtolower($id) . "; //"  . $var);
      //echo(getVarName($id, $env_id) . "<br>");
   }
   echo("<hr>");
}
*/
function read_xml_from_http($url)
{
   $ary_header = get_headers($url, 1);       
   $filesize = $ary_header['Content-Length'];
   // Fake the browser type
   ini_set('user_agent','MSIE 4\.0b2;');
   $result = "";
   $dh = fopen("$url",'r');
   while(!feof($dh))
   {
      $result .= fread($dh,$filesize);
   }
   return $result;
} 
function display($string)
{
   echo("$string<br>\n");
}
function print_array($ar)
{
   $to_return = "";
   foreach($ar as $id=>$val)
   {
      $to_return .= "$id = $val<br>\n";
   }
   return($to_return);
   /*
   echo("<h4>" . $envt->get_id() . "</h4>");
   echo("<ul>");
   foreach($envt->vars as $id=>$val)
   {
      echo("<li>$id = $val</li>\n");
   }
   echo("</ul>");
   */
}
function getVarNames($var, $envt)
{
   $sub_var_to_remove = "ONLINE" . $envt;
   $substrlen = strlen($sub_var_to_remove);
   $toreturn = substr($var, $substrlen);
   return($toreturn);
}
//display("</body>");
?>

