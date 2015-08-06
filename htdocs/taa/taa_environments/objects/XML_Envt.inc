<?php
require_once("Envt_Mgr.inc");
require_once("Online_App.inc");
class XML_Envt
{
   var $em;
   var $app_name = "TIERS App";
   /************************************************************
    * The variables below are pulled from property files of
    * the build script (online.properties)
    ************************************************************/
   var $envt_name; //AST01
   var $clustersserver_name; //iedaau002
   var $appserver_list; //AST01
   var $dns_name; //tiers-ast01
   var $user_name; //wastest
   var $cell_name; //tiers_ast_Network
   var $clustermembers_list; //ast01-server2
   var $ws_app_name; //tiersast01
   //var $pf_dir; ///home/wastest/WebContent/AST01/properties
   //var $was_home; ///export/ENV/TIERS/ast/WebSphere/AppServer
   //var $templatedest; ///home/wastest/WebContent/AST01/bin
   //var $webserver_dir; ///home/wastest/WebContent/AST01/web
   var $server_name; //ast01-server2
   var $cluster_name; //ast01-cluster
   var $node_name; //iedaau002
   var $app_port = 0;
   
   /************************************************************
    * The variables below are pulled from property files of
    * the environment :
    *    1) TIERS.properties
    *    2) webservice.properties 
    *    3) messanging.properties
    ************************************************************/
    /* 
    * # This section contains the TIERS Database Connection Parameters
    * unused:
    * var $db_driver; //DRIVER => oracle.jdbc.driver.OracleDriver
    * var $db_datasource; //DATASOURCE => jdbc/tiers3DS
    * Schema->set_via_xml($user, $password, $url)
    */
    var $db_user; // USER => TIERS3ATRNTEST2CON
    var $db_password; //PASSWORD => TIERS3ATRNTEST2CON1C 
    var $db_url; //URL => jdbc:oracle:thin:@iedadu004:1521:TRDEV
    
    /*
    * SSA Software
    * unused:
    * IDS_MAX_CONNECTIONS => 5
    * IDS_INC_CONN => 3
    * IDS_SYSTEM => trdev3
    * IDS_VERBOSE => -vd0
    */
    var $ssa_host_name; //IDS_HOST_NAME => iedadu004
    var $ssa_host_port; //IDS_HOST_PORT => 1666
    var $ssa_rule_base; //IDS_RULE_BASE => ssa:trdev-trdev3
    var $ssa_file_clearance; //SSA_CLEARANCE => Y    
    
   
    /*
    * Universal Coder Constants
    * unused
    * UNIVERSAL_SERVER_ACCOUNT_PASSWORD => password
    */
    var $uc_host; //UNIVERSAL_SERVER_HOST => iedaau002
    var $uc_port; //UNIVERSAL_SERVER_PORT => 8080
    var $uc_acct_id; //UNIVERSAL_SERVER_ACCOUNT_ID => tiersuser
    var $uc_server_path; //UNIVERSAL_SERVER_PATH => dcg/gateway
   
   
    /*
     * webservice.properties
     */
    var $ws_alerts; //ALERTS.WEBSERVICE => iedaau011.txaccess.net:9080
    var $ws_alerts_user_id; //APPT_SCHEDULER_GENERIC_USER_ID => user1983
    var $ws_alerts_emp_id; //APPT_SCHEDULER_GENERIC_USER_EMP_ID => 5683
    var $ws_deprovision; //DEPROVISION.WEBSERVICE => http://tiers-ast01.txaccess.net/tiersWSWeb/services/UserProvisioningServic
   
    /*
    * messaging.properties
    * unused
    * QUEUECONNECTIONFACTORY => com.ibm.mq.jms.MQQueueConnectionFactory
    * QUEUETRANSPORT => JMSC.MQJMS_TP_CLIENT_MQ_TCPIP
    * QUEUECCSID => 819
    */
    var $mq_port; //QUEUEPORT => 1420
    var $mq_channel; //QUEUECHANNEL => TIERS.SVRCONN.CHL
    var $mq_manager; //QUEUEMANAGER => TIERS.QM6
    var $mq_host; //QUEUEHOST => iedaau006
    
   function XML_Envt()
   {
      $this->em = new Envt_Mgr();
   }
   
   function log_vars()
   {
   }
   
   function add_var($key, $val)
   {
      $key = trim($key);
      $key = str_replace(".", "_", $key);
      $id = $this->name;
      if(!empty($id))
         $key = str_replace("ONLINE" . $id, "", $key);
      $key = strtolower($key);
      $this->$key = $val;
   }
   
}
?>
