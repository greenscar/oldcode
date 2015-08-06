<?php

class XML_Envt
{
   var $name; //AST01
   var $webserver_list; //iedaau002
   var $clustersserver_name; //iedaau002
   var $host_port; //14511
   var $hostxml_dir; ///home/wastest/WebContent/AST01/XML
   var $dmgr_home; ///export/ENV/TIERS/ast/WebSphere/DeploymentManager
   var $host_name; //iedaau018
   var $appserver_list; //AST01
   var $dns_name; //tiers-ast01
   var $user_name; //wastest
   var $cell_name; //tiers_ast_Network
   var $svr_login; //wastest@iedaau018
   var $webserver_secure; //false
   var $clustermembers_list; //ast01-server2
   var $app_name; //tiersast01
   var $pf_dir; ///home/wastest/WebContent/AST01/properties
   var $webserver_switch; //true
   var $cluster_switch; //Yes
   var $was_home; ///export/ENV/TIERS/ast/WebSphere/AppServer
   var $appserver1_list; //
   var $pf_pullfromstream; //true
   var $templatedest; ///home/wastest/WebContent/AST01/bin
   var $server_secure; //false
   var $webserver_dir; ///home/wastest/WebContent/AST01/web
   var $server_name; //ast01-server2
   var $vh_name; //ast01-cluster
   var $cluster_name; //ast01-cluster
   var $node_name; //iedaau002
   var $conn_type; //SOAP
   

   function add_var($key, $val)
   {
      $key = trim($key);
      $key = str_replace(".", "_", $key);
      $id = $this->get_id();
      if(!empty($id))
         $key = str_replace("ONLINE" . $id, "", $key);
      $this->$key = $val;
   }
   
   function get_var($key)
   {
      return($this->$key);
   }
   
   function get_id()
   {
      if(isset($this->name))
         return($this->name);
   }
}
?>
