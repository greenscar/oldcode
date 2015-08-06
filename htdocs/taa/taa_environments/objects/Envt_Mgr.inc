<?php
require_once("Secretary.inc");
require_once("Db_Mgr_MySQL.inc");
require_once("Db_Mgr_Oracle.inc");
require_once("MQ.inc");
require_once("Schema.inc");
require_once("App_Server.inc");
require_once("Settings.inc");
require_once("Batch_App.inc");
require_once("XML_Envt.inc");
class Envt_Mgr
{
   var $db_mgr_mysql;
   var $db_mgr_ora;
   var $mqs;
   var $settings;
   var $Schemas;
   var $app_servers;
   var $batch_apps;
   var $apps_online;
   var $applications;
   var $environments;
   var $release_nums;
   var $db_order_by;
   var $release_num;
   var $db_app;
   
   function Envt_Mgr()
   {
      $this->log = new Secretary();
      $this->db_mgr_mysql = new Db_Mgr_MySQL();
      $this->db_mgr_ora = new Db_Mgr_Oracle();
      $this->settings = new Settings();
      $this->mqs = Array();
      $this->Schemas = Array();
      $this->app_servers = Array();
      $this->batch_apps = Array();
      $this->release_nums = Array();
      $this->applications = Array();
      $this->environments = Array();
      $this->db_order_by = "HOST_STRING";
      $this->db_release_num = "ALL";
      $this->db_app = "ALL";
   }
   function to_string()
   {
      $str = "\r\n-------------------------------------------\r\n";
      $str .= "-------------------------------------------\r\n";
      return($str);
   }
   function get_app_list()
   {
      return $this->settings->app_list;
   }
   /*******************************************************************
   *
   *******************************************************************/
   function db_load_mqs_all($orderBy = "MQ_ID")
   {
      $this->log->write("Envt_Mgr->db_load_mqs_all START");
      $this->mqs = Array();
      $query = "SELECT MQ_ID, HOST, PORT, MGW, CHANNEL, DATE_START, DATE_END";
      $mq = new MQ();
      //$now = date($this->settings->date_format, time());
      $now = $this->settings->get_time();
      $query .= " FROM MQ "
             . "WHERE "
             . "date_start <= '$now' "
             . "AND "
             . "(DATE_END is null or DATE_END > '$now')";
      $query .= " order by ";
      if(isset($orderBy)) $query .= $orderBy;
      else $query .= "HOST";
      $this->db_mgr_mysql->connect();
      $this->db_mgr_mysql->query($query);
      $this->log->write($query);
      while($row = $this->db_mgr_mysql->fetch_assoc_array())
      {
         $mq = new MQ();
         $mq->id = $row["MQ_ID"];
         $mq->host = $row["HOST"];
         $mq->port = $row["PORT"];
         $mq->mgw = $row["MGW"];
         $mq->channel = $row["CHANNEL"];
         $mq->date_start = $row["DATE_START"];
         $mq->date_end = $row["DATE_END"];
         if(empty($mq->date_end)) $mq->date_end = "N/A";
         array_push($this->mqs, $mq);
      }
      $this->db_mgr_mysql->disconnect();
      $this->log->write("Envt_Mgr->db_load_mqs_all END (" . count($this->mqs) . " MQ's loaded)");
      return(count($this->mqs));
   }
      
   /*******************************************************************
   *
   *******************************************************************/
   function db_load_batch_apps()
   {
      $this->log->write("Envt_Mgr->db_load_App_Servers_apps START");
      $this->batch_apps = Array();
      $now = time();
      $query = "SELECT env.NAME as ENV_NAME, b.BOX, b.PATH, b.MQ_ID, b.DB_ID, b.DATE_START, b.DATE_END"
             . " FROM BATCH b, ENVIRONMENT env  ";
      $now = $this->settings->get_time();
      $query .= "WHERE "
             . "DATE_START <= '$now' "
             . "AND "
             . "(DATE_END is null or DATE_END > '$now')"
             . " AND"
             . " env.ENV_ID = b.ENV_ID";
      $this->log->write($query);
      $this->db_mgr_mysql->connect();
      $this->db_mgr_mysql->query($query);
      while($row = $this->db_mgr_mysql->fetch_assoc_array())
      {
         $ba = new Batch_App();
         $ba->env_name = $row["ENV_NAME"];
         $ba->box = $row["BOX"];
         $ba->path = $row["PATH"];
         $ba->mq->id = $row["MQ_ID"];
         $ba->schema->id = $row["DB_ID"];
         $ba->date_start = $row["DATE_START"];
         $ba->date_end = $row["DATE_END"];
         if(empty($ba->date_end)) $ba->date_end = "N/A";
         $this->batch_apps[$ba->env_name] = $ba;
      }
      $this->db_mgr_mysql->disconnect();
      $this->log->write("Envt_Mgr->db_load_batch_apps END (" . count($this->batch_apps) . " batch apps loaded)");
      return(count($this->batch_apps));
   }   
   /*******************************************************************
   *
   *******************************************************************/
   function db_load_tiers_apps()
   {
      $this->log->write("Envt_Mgr->db_load_tiers_apps START");
      $numba = $this->db_load_batch_apps();
      $numoa = $this->db_load_apps_online();
      $this->log->write("Envt_Mgr->db_load_tiers_apps END ($numba batch apps & $numoa online apps loaded)");
   }
   /*******************************************************************
   *
   *******************************************************************/
   function db_load_apps_online($order_by = "ENV_ID")
   {
      $this->log->write("Envt_Mgr->db_load_apps_online START");
      $this->apps_online = Array();
      /*
      * EACH ONLINE APP CAN HAVE MULTIPLE APPSERVERS. THUS, LOAD THE APP FIRST
      * THEN LOAD THE APP SERVERS.
      */
      $now = $this->settings->get_time();
      $query = "SELECT env.NAME as ENV_NAME, env.ENV_ID as ENV_ID, ap.NAME as APP_NAME, ap.APP_ID as APP_ID,a.WS_APP_NAME, a.CLUSTER, a.WS_CELL_NAME, a.DNS, a.MQ_ID, a.DB_ID, a.DATE_START as aDateStart, a.DATE_END as aDateEnd, "
             . " ad.ADMIN_HTTP"
             . " FROM WS_APPLICATION a, WS_CELL ad, ENVIRONMENT env, APPLICATION ap WHERE "
             . " ad.WS_CELL_NAME = a.WS_CELL_NAME"
             . " AND"
             . " env.ENV_ID = a.ENV_ID"
             . " AND"
             . " ap.APP_ID = a.APP_ID";
      if(isset($envtid))
      {
         $query .= " AND a.ID like '" . $envtid . "'";
      }
      $query .= " AND"
             . " a.DATE_START <= '$now'"
             . " AND"
             . " (a.DATE_END is null or a.DATE_END > '$now')";
      $this->log->write($query);
      $this->db_mgr_mysql->connect();
      $this->db_mgr_mysql->query($query);
      $dbmgr2 = new Db_Mgr_MySQL();
      $dbmgr2->connect();
      $this->db_load_schemas_all();
      while($row = $this->db_mgr_mysql->fetch_assoc_array())
      {
         $oa = new Online_App();
         $oa->environment->name = $row["ENV_NAME"];
         $oa->environment->id = $row["ENV_ID"];
         $oa->application->name = $row["APP_NAME"];
         $oa->application->id = $row["APP_ID"];
         //$oa->env_name = $row["env_name"];
         $this->log->write($oa->environment->name);
         $oa->ws_app_name = $row["WS_APP_NAME"];
         $oa->cluster = $row["CLUSTER"];
         $oa->cell = $row["WS_CELL_NAME"];
         $oa->admin_panel = $row["ADMIN_HTTP"];
         $oa->dns = $row["DNS"];
         $oa->mq->id = $row["MQ_ID"];
         $oa->schema = $this->Schemas[$row["DB_ID"]];
         //$oa->schema->id = $row["DB_ID"];
         $oa->date_start = $row["aDateStart"];
         $oa->date_end = $row["aDateEnd"];
         // Get information from ENVIRONMENTTest.jsp
         $oa->load_build_info_xml();
         if(empty($oa->date_end)) $oa->date_end = "N/A";
         //$this->log->write($oa->to_string());
         // Load Servers for this app
         $query = "SELECT SERVER_NAME, NODE, PORT, DATE_START, DATE_END"
                . " FROM WS_APPSERVER WHERE"
                . " WS_APP_NAME LIKE '" . $oa->ws_app_name . "'"
                . " AND DATE_START <= '$now'"
                . " AND"
                . " (DATE_END is null or DATE_END > '$now')";
         $dbmgr2->query($query);
         $this->log->write($query);
         while($row = $dbmgr2->fetch_assoc_array())
         {
            $as = new App_Server();
            $as->server_name = $row["SERVER_NAME"];
            $as->node = $row["NODE"];
            $as->port = $row["PORT"];
            $as->date_start = $row["DATE_START"];
            $as->date_end = $row["DATE_END"];
            if(empty($as->date_end)) $as->date_end = "N/A";
            $oa->add_server($as);
         }
         //array_push($this->apps_online, $oa);
         $this->apps_online[$oa->environment->name] = $oa;
         //$this->log->write($oa->to_string());
      }
      $dbmgr2->disconnect();
      $this->db_mgr_mysql->disconnect();
      //$this->db_sort_envts("source_stream");
      $this->log->write("Envt_Mgr->db_load_apps_online END (" . count($this->apps_online) . " online apps loaded)");
      return(count($this->apps_online));
   }
   
   /*******************************************************************
   *
   *******************************************************************/
   function db_load_schemas_all($orderBy="ENV_ID")
   {
      $this->log->write("Envt_Mgr->db_load_schemas_all START");
      $this->Schemas = Array();
      $this->db_mgr_ora->connect();
      $temp_schemas = Array();
      /*
      $query = "SELECT ID, PORT, PWD FROM `SCHEMA`";
      $this->db_mgr_mysql->connect();
      $this->db_mgr_mysql->query($query);
      while($row = $this->db_mgr_mysql->fetch_assoc_array())
      {
         $s = new Schema();
         $s->id = $row["ID"];
         $s->port = $row["PORT"];
         $s->pwd = $row["PWD"];
         $temp_schemas[$s->id] = $s;
      }
      $this->db_mgr_mysql->disconnect();
      */
      $query = "SELECT a.ENV_ID,a.BUILD_NUM,a.NAME,a.HOST_STRING,c.HOST_NAME,a.CONNECT_ACCOUNT"
         . " from v_ENVIRONMENTs a, v_ad_instances b, ad_hosts c"
         . " where a.HOST_STRING = b.INSTANCE_NAME"
         . " and b.HOST_ID = c.HOST_ID"
         . " and a.DISPLAY_SW = 'Y'";
      $this->log->write($query);
      $this->db_mgr_ora->query($query);
      while($row = $this->db_mgr_ora->fetch_assoc_array())
      {
         $s = new Schema();
         $s->id = $row["ENV_ID"];
         $s->descr = $row["NAME"];
         $s->box= $row["HOST_NAME"];
         $s->port= 0000;
         $s->db= $row["HOST_STRING"];
         $s->uid= $row["CONNECT_ACCOUNT"];
         $s->version= $row["BUILD_NUM"];
         /*
         if(array_key_exists ($s->id,$temp_schemas))
         {
            $s->port = $temp_schemas[$s->id]->port;
            $s->pwd = $temp_schemas[$s->id]->pwd;
         }
         */
         $this->Schemas[$s->id] = $s;
         //array_push($this->Schemas, $s);
      }
      $this->db_mgr_ora->disconnect();
      $this->log->write("Envt_Mgr->db_load_schemas_all END (" . count($this->Schemas) . " Schemas loaded)");
      return(count($this->Schemas));
   }
   /*******************************************************************
   *
   *******************************************************************/
   function get_db_list()
   {
      $this->log->write("Envt_Mgr->get_db_list()");
      $this->Schemas = Array();
      if(!isset($this->db_app))
      {
         $this->db_app = "TIERS";
      }
      $count = sizeof($this->settings->app_schemas[$this->db_app]);
      $this->log->write("END Envt_Mgr->get_db_list() => $count schemas");
      return $this->settings->app_schemas[$this->db_app];      
   }
   /*******************************************************************
   *
   *******************************************************************/
   function db_load_schemas()
   {
      $this->log->write("Envt_Mgr->db_load_schemas() START");
      $this->Schemas = Array();
      $temp_schemas = Array();
      $query = "SELECT ID, PORT, PWD FROM `SCHEMA`";
      $this->db_mgr_mysql->connect();
      $this->db_mgr_mysql->query($query);
      while($row = $this->db_mgr_mysql->fetch_assoc_array())
      {
         $s = new Schema();
         $s->id = $row["ID"];
         $s->port = $row["PORT"];
         $s->pwd = $row["PWD"];
         $temp_schemas[$s->id] = $s;
      }
      $this->db_mgr_mysql->disconnect();
      $this->log->write($this->db_mgr_ora->connect($this->log));
      $query = "SELECT a.ENV_ID,a.BUILD_NUM,a.NAME,a.HOST_STRING,c.HOST_NAME,a.CONNECT_ACCOUNT"
               . " from v_ENVIRONMENTs a, v_ad_instances b, ad_hosts c"
               . " where a.HOST_STRING = b.INSTANCE_NAME"
               . " and b.HOST_ID = c.HOST_ID"
               . " and a.DISPLAY_SW = 'Y'";
      if(strcmp($this->db_app, "ALL") != 0)
      {
         $envts_to_display = $this->settings->app_schemas[$this->db_app];
         $query .= " and a.ENV_ID in (";
         //$envs_to_display = $this->settings->tiers_schemas;
         foreach($envts_to_display as $key=>$val)
         {
            $query .= $val . ", ";
         }
         $query = substr($query, 0, (strlen($query) - 2));
         $query .= ") ";
      }
      
      if(strcmp($this->db_release_num, "ALL") != 0)
      {
         $query .= "AND a.BUILD_NUM LIKE '" . $this->db_release_num * 10 . "%' ";
      }
      $query .= "order by ";
      if(strcmp($this->db_order_by, "HOST_NAME") == 0)
         $query .= "c." . $this->db_order_by;
      else
         $query .= "a." . $this->db_order_by;
      
      $this->log->write($query);
      $this->db_mgr_ora->query($query);
      while($row = $this->db_mgr_ora->fetch_assoc_array())
      {
         $s = new Schema();
         $s->id = $row["ENV_ID"];
         $s->descr = $row["NAME"];
         $s->box= $row["HOST_NAME"];
         $s->port= 0000;
         $s->db= $row["HOST_STRING"];
         $s->uid= $row["CONNECT_ACCOUNT"];
         $s->version= $row["BUILD_NUM"];
         if(array_key_exists ($s->id,$temp_schemas))
         {
            $s->port = $temp_schemas[$s->id]->port;
            $s->pwd = $temp_schemas[$s->id]->pwd;
         }
         $this->Schemas[$s->id] = $s;
         //array_push($this->Schemas, $s);
      }
      $this->db_mgr_ora->disconnect();
      $this->log->write("Envt_Mgr->db_load_schemas() END (" . count($this->Schemas) . " Schemas loaded)");
      return(count($this->Schemas));
   }   
      
   /*******************************************************************
   *
   *******************************************************************/
   function db_load_mq($DB_ID)
   {
      $this->log->write("Envt_Mgr->db_load_mqs() START");
      $this->Schemas = Array();
      $this->log->write($this->db_mgr_ora->connect($this->log));
      $query = "SELECT * FROM V_APP_MQ_SECURITY where ENV_ID = $DB_ID";
      $this->log->write($query);
      $this->db_mgr_ora->query($query);
      while($row = $this->db_mgr_ora->fetch_assoc_array())
      {
         foreach($row as $id=>$val)
         {
            $this->log->write("$id = $val");
         }
         $mq = new MQ();
         
         
         //PORT = 1431
         $mq->port = $row["PORT"];
         //GATEWAY_CHANNEL = GATEWAYS.SVRCONN.CHL
         $mq->channel = $row["GATEWAY_CHANNEL"];
         $this->log->write("$id = $val");
         //array_push($this->Schemas, $s);
      }
      $this->db_mgr_ora->disconnect();
      $this->log->write("Envt_Mgr->db_load_mqs() END (" . count($row) . " mqs loaded)");
      //return(count($this->Schemas));
   }   
   /*******************************************************************
   *
   *******************************************************************/
   function db_load_db_release_nums()
   {
      $s = new Schema();
      $this->db_mgr_ora->connect();
      $s->db_load_tiers_db_versions($this->db_mgr_ora, $this->settings);
      $this->db_mgr_ora->disconnect();
      for($i=0; $i<sizeof($s->all_versions); $i++)
      {
         $num = floor(($s->all_versions[$i] / 100));
         $num = round($num / 10, 1);
         if(!(in_array($num, $this->release_nums)))
         {
            $this->log->write("Adding Release Num $num");
            array_push($this->release_nums, $num);
         }
      }
   }
   /*******************************************************************
   *
   *******************************************************************/
   function db_load_app_list()
   {
      $this->log->write("Envt_Mgr->db_load_applications() START");
      $this->applications = Array();
      $this->db_mgr_mysql->connect();
      $query = "SELECT app_id, name FROM application";
      $this->log->write($query);
      $this->db_mgr_mysql->connect();
      $this->db_mgr_mysql->query($query);
      while($row = $this->db_mgr_mysql->fetch_assoc_array())
      {
         $an_app = new Application();
         $an_app->id = $row["app_id"];
         $an_app->name = $row["name"];
         $this->applications[$an_app->id] = $an_app;
      }
      $this->db_mgr_mysql->disconnect();
      $count = sizeof($this->applications);
      $this->log->write("Envt_Mgr->db_load_applications() END => $count app names loaded");
      return($count);
   }
   /*******************************************************************
   *
   *******************************************************************/
   function is_whole_number($var)
   {
      return $this->settings->is_whole_number($var);
   }
   /*******************************************************************
   *
   *******************************************************************/
   function db_load_envt_list()
   {
      $this->log->write("Envt_Mgr->db_load_envt_list() START");
      $this->Envts = Array();
      $this->db_mgr_mysql->connect();
      $query = "SELECT ENV_ID, NAME FROM ENVIRONMENT";
      $this->log->write($query);
      $this->db_mgr_mysql->connect();
      $this->db_mgr_mysql->query($query);
      while($row = $this->db_mgr_mysql->fetch_assoc_array())
      {
         $en = new Environment();
         $en->id = $row["ENV_ID"];
         $en->name = $row["NAME"];
         array_push($this->environments, $en);
      }
      $this->db_mgr_mysql->disconnect();
      $count = sizeof($this->environments);
      $this->log->write("Envt_Mgr->db_load_envt_list() END => $count ENVIRONMENTs loaded");
      return($count);
   }
   /*
   * db_update_all will go through all environments currently in memory and will check 
   *  the DB for those envts. 
   *  If they exist and data is different, they will be updated.
   *  If they don't exist they will be inserted. 
   *  If there is a property in the DB that is not in the XML it should be marked with current tiemstamp as end date.
   */
   function db_update_all()
   {
      $this->log->write("Envt_Mgr->db_update_all() START");
      // $oa = new Online_App();
      $this->db_mgr_mysql->connect(); 
      foreach($this->apps_online AS $envt_name=>$oa)
      {
         $oa->db_update($this->db_mgr_mysql);
      }
      $this->log->write("Envt_Mgr->db_update_all() END");
   }
   /*
   * Convert a XML_Envt object into the PHP Objects used in this application
   * REQUIRE: $this->db_load_schemas() was called before this method.
   *           this method is going to utilize $this->schemas
   */
   function xml_envt_to_app($xml_envt)
   {
      /*
      var $ssa_host_name; //IDS_HOST_NAME => iedadu004
      var $ssa_host_port; //IDS_HOST_PORT => 1666
      var $ssa_rule_base; //IDS_RULE_BASE => ssa:trdev-trdev3
      var $ssa_file_clearance; //SSA_CLEARANCE => Y
      var $uc_host; //UNIVERSAL_SERVER_HOST => iedaau002
      var $uc_port; //UNIVERSAL_SERVER_PORT => 8080
      var $uc_acct_id; //UNIVERSAL_SERVER_ACCOUNT_ID => tiersuser
      var $uc_server_path; //UNIVERSAL_SERVER_PATH => dcg/gateway
      var $ws_alerts; //ALERTS.WEBSERVICE => iedaau011.txaccess.net:9080
      var $ws_alerts_user_id; //APPT_SCHEDULER_GENERIC_USER_ID => user1983
      var $ws_alerts_emp_id; //APPT_SCHEDULER_GENERIC_USER_EMP_ID => 5683
      var $ws_deprovision; //DEPROVISION.WEBSERVICE => http://tiers-ast01.txaccess.net/tiersWSWeb/services/UserProvisioningServic
      */
      $toReturn = false;
      $now = $this->settings->get_time();
      $as = new App_Server();
      $oa = new Online_App();
      $oa->environment->name = $xml_envt->envt_name;
      $oa->ws_app_name = $xml_envt->ws_app_name; 
      $oa->cluster = $xml_envt->clusterserver_name;
      $oa->ws_cell_name = $xml_envt->cell_name;
      $oa->dns = $xml_envt->dns_name;
      $oa->user = $xml_envt->user_name;
      $oa->date_start = $now;
      //echo($oa->to_string());
      $as = new App_Server();
      $as->server_name = $xml_envt->server_name;
      $as->node = $xml_envt->node_name;
      $as->date_start = $now;
      $as->port = $xml_envt->app_port;
      $oa->add_server($as);
      
      $aMQ = new MQ();
      $aMQ->channel = $xml_envt->mq_channel;
      $aMQ->id = $xml_envt->mq_manager;
      $aMQ->host = $xml_envt->mq_host;
      $aMQ->port = $xml_envt->mq_port;
      $aMQ->date_start = $now;
      $oa->mq = $aMQ;
      
      
      $temp_schema = new Schema();
      $temp_schema->set_via_xml($xml_envt->db_user, $xml_envt->db_password, $xml_envt->db_url);
      //echo($xml_envt->db_user . ", " . $xml_envt->db_password . ", " . $xml_envt->db_url . "<br>\n");
      //$this->log->write($xml_envt->db_user . " @ " . $xml_envt->db_url);
      $match_found = false;
      foreach($this->Schemas as $id=>$a_schema)
      {
         #echo("strcmp($temp_schema->db, $a_schema->db) == " . strcmp($temp_schema->db, $a_schema->db) . "<br>");
         #echo("strcmp($temp_schema->uid, $a_schema->uid) == " . strcmp($temp_schema->uid, $a_schema->uid) . "<br>");
         if((strcmp($temp_schema->db, $a_schema->db) == 0) && (strcmp($temp_schema->uid, $a_schema->uid) == 0))
         {
            //$this->log->write($a_schema->uid . "@" . $a_schema->db . " => " . $a_schema->id);
            $a_schema->port = $temp_schema->port;
            $a_schema->url = $xml_envt->db_url;
            $a_schema->pwd = $xml_envt->db_password;
            $a_schema->date_start = $now;
            $oa->schema = $a_schema;
            $match_found = true;
         }
      }
      if(!$match_found)
      {
         $oa->schema = $temp_schema;
      }
      $envt_found = false;
      foreach($this->environments as $id=>$an_env)
      {
         //echo($an_env->name . " == " . $oa->environment->name . "<br>");
         if(strcmp($an_env->name, $xml_envt->envt_name) == 0)
         {
            $oa->environment = $an_env;
            $envt_found = true;
            //echo("<h3>envtname = " . $an_env->name . "</h3>\n");
         }
      }
      if(!$envt_found)
      {
         $this->db_mgr_mysql->connect();
         $oa->environment->db_insert($this->db_mgr_mysql);
         $this->db_mgr_mysql->disconnect();
      }
      foreach($this->applications as $id=>$an_app)
      {
         //echo($an_app->name . " == " . $oa->application->name . "<br>");
         if(strcmp($an_app->name, $xml_envt->app_name) == 0)
         {
            $oa->application = $an_app;
            //echo("appname = " . $an_app->name . "\n");
            //echo("appid = " . $an_app->id . "\n");
         }
      }
      $oa->date_start = $now;
      $this->apps_online[$oa->environment->name] = $oa;
      return($oa);
   }
   
   
   function app_mod($envid, $appid, $wsappname, $cluster, $cell, $dns, $dbid, $mqid, $appid, $appserver_name, $appserver_node, $appserver_port)
   {
      $this->log->write("Envt_Mgr->app_mod($envid, $appid, $wsappname, $cluster, $cell, $dns, $dbid, $mqid, $appid, $appserver_name, $appserver_node, $appserver_port) START");
      
      $this->log->write("Envt_Mgr->app_mod($envid, $appid, $wsappname, $cluster, $cell, $dns, $dbid, $mqid, $appid, $appserver_name, $appserver_node, $appserver_port) END");
      return(false);
   }
   function get_app_online_count()
   {
      return(sizeof($this->apps_online));
   }
}
?>
