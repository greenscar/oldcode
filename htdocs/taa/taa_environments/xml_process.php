<?php
/*
* xml_process.php processes the xml file created by propxmlgen.pl
* This xml file has data read from the build script's 
* online.properties & batch.properties
* AND
* the properties 
*/
require_once("./objects/XML_Parser.inc");
require_once("./objects/XML_Envt.inc");
require_once("./objects/Envt_Mgr.inc");
require_once("./objects/MQ.inc");
require_once("./objects/Schema.inc");
require_once("./objects/App_Server.inc");
require_once("./objects/Settings.inc");
require_once("./objects/Batch_App.inc");

$var_list = Array();
$xml_envts = Array();
$em = new Envt_Mgr();
/**********************************************************
* THE CODE IN THIS SECTION IS TO READ FROM A LOCAL XML
***********************************************************/
/*
$xml_loc = "c:/scripts/envts.xml";
if (!($fp=@fopen($xml_loc, "r")))
   die("<h1>Couldn't open XML");
$filesize = filesize($xml_loc);
display("filesize  = $filesize");
$data = fread($fp, $filesize);
fclose($fp);
printf("\n\n\n\n");
//printf($data);
printf("\n\n\n\n");
$xml_parser = new Simple_Parser();
$return = $xml_parser->parse($data);
display($return);
display("sizeof data => " . sizeof($xml_parser->data));
$envts = $xml_parser->data["ENVTS"][0]["child"];
echo(print_array($xml_parser->data));
*/
/**********************************************************
* END THE CODE IN THIS SECTION IS TO READ FROM A LOCAL XML
***********************************************************/

/**********************************************************
* READ ANT'S ONLINE.PROPERTIES FROM A WEB XML
***********************************************************/
$xml_loc = "http://iedaau019/envts_online.xml";
$data=read_xml_from_http($xml_loc);
$xml_parser = new XML_Parser();
$return = $xml_parser->parse($data);
$envts_build = $xml_parser->data["ENVTS"][0]["child"];
/**********************************************************
* END READ ANT'S ONLINE.PROPERTIES FROM A WEB XML
***********************************************************/

/**********************************************************
* READ THE ENVIRONMENT'S PROPERTIES FILES FROM A WEB XML
***********************************************************/
//$xml_loc = "http://iedaau019/envts_online.xml";
$xml_loc = "http://localhost/xml_test/app_properties.xml";
$data=read_xml_from_http($xml_loc);
$xml_parser = new XML_Parser();
$return = $xml_parser->parse($data);
//display($return);
//display("sizeof data => " . sizeof($xml_parser->data));
$envts_all = $xml_parser->data["ENVTS"][0]["child"];
$envts_online = $envts_all["ONLINE"][0]["child"];
$envts_batch = $envts_all["BATCH"][0]["child"];
//echo(print_r($envts_online));
/**********************************************************
* END READ THE ENVIRONMENT'S PROPERTIES FILES FROM A WEB XML
***********************************************************/

/**********************************************************
* CONVERT ANT'S ONLINE.PROPERTIES XML FILE TO XML_Envt OBJECTS
***********************************************************/
foreach($envts_build["ENVT"] as $id=>$var)
{
   $envt = new XML_Envt();
   $var = $var["child"];
   $envt->envt_name = get_var($var, "NAME");
   $envt->clusterserver_name = get_var($var, "ONLINE" . $envt->envt_name . "CLUSTERSSERVER.NAME");
   $envt->appserver_list = get_var($var, "ONLINE" . $envt->envt_name . "APPSERVER.LIST");
   $envt->dns_name = get_var($var, "ONLINE" . $envt->envt_name . "DNS.NAME"); //tiers-ast01
   $envt->user_name = get_var($var, "ONLINE" . $envt->envt_name . "USER.NAME"); //wastest
   $envt->cell_name = get_var($var, "ONLINE" . $envt->envt_name . "CELL.NAME"); //tiers_ast_Network
   $envt->clustermembers_list = get_var($var, "ONLINE" . $envt->envt_name . "CLUSTERMEMBERS.LIST"); //ast01-server2
   $envt->ws_app_name = get_var($var, "ONLINE" . $envt->envt_name . "APP.NAME"); //tiersast01
   //var $pf_dir; ///home/wastest/WebContent/AST01/properties
   //var $was_home; ///export/ENV/TIERS/ast/WebSphere/AppServer
   //var $templatedest; ///home/wastest/WebContent/AST01/bin
   //var $webserver_dir; ///home/wastest/WebContent/AST01/web
   $envt->server_name = get_var($var, "ONLINE" . $envt->envt_name . "SERVER.NAME"); //ast01-server2
   $envt->cluster_name = get_var($var, "ONLINE" . $envt->envt_name . "CLUSTER.NAME"); //ast01-cluster
   $envt->node_name = get_var($var, "ONLINE" . $envt->envt_name . "NODE.NAME"); //iedaau002
   $xml_envts["$envt->envt_name"] = $envt;
}
/**********************************************************
* END CONVERT ANT'S ONLINE.PROPERTIES XML FILE TO XML_Envt OBJECTS
***********************************************************/

/**********************************************************
* CONVERT XML FILE TO XML_Envt OBJECTS
***********************************************************/
foreach($envts_online as $id=>$var)
{
   $var = $var[0]["child"];
   $envt_name = $id;
   //if(substr_compare($envt_name, "CONV", 0, 3) != 0)
   //{
      $envt = $xml_envts["$id"];
      
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
      $xml_envts["$id"] = $envt;
   //}
}
/**********************************************************
* END CONVERT XML FILE TO XML_Envt OBJECTS
***********************************************************/

/**********************************************************
* TURN XML_Envt OBJECTS INTO Online_App & App_Server objects.
***********************************************************/
$em->db_load_schemas();
$em->db_load_envt_list();
$em->db_load_app_list();
echo("<table border=1>\n");
//echo("<tr><th>oa->ws_app_name</th><th>oa->dns</th><th>oa->mq->id</th><th>url</th><th>uid</th><th>pwd</th><th>db</th><th>box</th><th>port</th><th></th></tr>");
/*
echo("<tr>
   <th>oa->schema->id</th>
   <th>oa->schema->uid</th>
   <th>oa->schema->pwd</th>
   <th>oa->schema->box</th>
   <th>oa->schema->port</th>
   <th>oa->schema->db</th>
   <th>oa->schema->version</th>
   <th>oa->schema->descr</th>
   <th>oa->schema->url</th>
   </tr>");
*/
foreach($xml_envts AS $id=>$envt)
{
   $oa = $em->xml_envt_to_app($envt);
   /*
   echo("<td>\n");
   echo($oa->schema->id);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->schema->uid);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->schema->pwd);
   echo("</td>\n");   
   echo("<td>\n");
   echo($oa->schema->box);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->schema->port);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->schema->db);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->schema->version);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->schema->descr);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->schema->url);
   echo("</td>\n");
   echo("</tr>\n");
   */
   echo("<tr>\n");
   echo("<td>\n");
   echo($oa->get_server_count());
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->app_servers[0]->server_name);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->app_servers[0]->node);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->app_servers[0]->port);
   echo("</td>\n");
   /*
   echo("<td>\n");
   echo($oa->schema->url);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->schema->uid);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->schema->pwd);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->schema->db);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->schema->box);
   echo("</td>\n");
   echo("<td>\n");
   echo($oa->schema->port);
   echo("</td>\n");
   echo("</tr>\n");
   */
}
echo("</table>");


$em->db_update_all();

echo("num apps_online = " . $em->get_app_online_count() . "<BR>");
/**********************************************************
* END TURN XML_Envt OBJECTS INTO Online_App & App_Server objects.
***********************************************************/


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



function get_var($xml, $var_name)
{
   if(isset($xml["$var_name"][0]["data"]))
   {
      //echo("$var_name = " . $xml["$var_name"][0]["data"] . "<br>\n");
      $val = $xml["$var_name"][0]["data"];
      $val = trim($val);
      return($val);
   }
   else
      return("n/a");
}

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
function getVarName($var, $envt)
{
   $sub_var_to_remove = "ONLINE" . $envt;
   $substrlen = strlen($sub_var_to_remove);
   $toreturn = substr($var, $substrlen);
   return($toreturn);
}
//display("</body>");
?>

