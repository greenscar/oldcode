<?php
require_once("Secretary.inc");
require_once("Settings.inc");
class MQ
{
   var $id;
   var $host;
   var $port;
   var $mgw;
   var $channel;
   var $apps;
   var $date_start;
   var $date_end;
   var $settings;
   
   function MQ()
   {
      $this->log = new Secretary();
      $this->settings = new Settings();
      $this->apps = Array();
   }
   function get_variables()
   {
      $vars = array("id", "host", "port", "mgw", "channel", "DATE_START", "DATE_END");
      return($vars);
   }
   function add_app($app_string)
   {
      array_push($this->apps, $app_string);
   }
   function to_string()
   {
      $str = "\r\n-------------------------------------------\r\n";
      $str .= "id => " . $this->id . "\r\n";
      $str .= "host => " . $this->host . "\r\n";
      $str .= "port => " . $this->port . "\r\n";
      $str .= "mgw => " . $this->mgw . "\r\n";
      $str .= "channel => " . $this->channel . "\r\n";
      $str .= "date_start => " . $this->date_start . "\r\n";
      $str .= "date_end => " . $this->date_end . "\r\n";
      $str .= "-------------------------------------------\r\n";
      return($str);
   }
   function db_load($dbmgr, $id)
   {
      $this->log->write("id->db_load($dbmgr, $id)) START");
      if(!isset($id))
      {
         $this->log->write("ERROR -> this->id == null");
         return false;
      }
      $to_return = false;
      $now = $this->settings->get_time();
      //SELECT * from id where trim(id) like 'TIERS.QM4' and DATE_START <= '2006-11-20' AND (DATE_END is null or DATE_END >= '2006-11-20')
      /*
      $sel = "SELECT host, port, mgw, channelDATE_STARTDATE_END "
           . "FROM mq "
           . "where trim(mq_id) like '" . strtoupper($id) . "' "
           . "AND "
           . "date_start <= '" . date("Y-m-d") . "' "
           . "AND "
           . "(DATE_END is null or DATE_END > '" . date("Y-m-d") . "')";
      */
      $sel = "SELECT HOST, PORT, MGQ, CHANNEL, DATE_START, DATE_END "
           . "FROM mq "
           . "where trim(MQ_ID) like '" . strtoupper($id) . "' "
           . "AND "
           . "DATE_START <= '$now' "
           . "AND "
           . "(DATE_END is null or DATE_END > '$now')";
      $this->log->write($sel);
      $dbmgr->connect();
      $dbmgr->query($sel);
      if($row = $dbmgr->fetch_assoc_array())
      {
         $this->id = $id;
         $this->host = trim($row["HOST"]);
         $this->port = trim($row["PORT"]);
         $this->mgw = trim($row["MGW"]);
         $this->channel = trim($row["CHANNEL"]);
         $this->date_start = trim($row["DATE_START"]);
         $this->date_end = trim($row["DATE_END"]);
         $to_return = true;
      }
      $dbmgr->disconnect();
      $this->log->write("id->db_load($dbmgr, $id)) END -> $to_return");
      return($to_return);
   }
 
   function db_update_mysql($mysql_conn)
   {
      $this->log->write("MQ->db_update_mysql() START");
      $stmt = "SELECT MQ_ID, HOST, PORT, MGW, CHANNEL"
            . " FROM MQ WHERE MQ_ID LIKE '" . $this->id . "'";
      $this->log->write($stmt);
      $mysql_conn->query($stmt);
      $num_rows = $mysql_conn->get_num_rows();
      $this->log->write("----------------------------num_rows = $num_rows----------------------------\n");
      if($num_rows == 0)
      {
         //INSERT
         $stmt = "INSERT INTO MQ (MQ_ID, HOST, PORT, MGW, CHANNEL, DATE_START)"
               . " VALUES ("
               . "'" . trim($this->id) . "', "
               . "'" . trim($this->host) . "', "
               . $this->port . ", "
               . "'" . trim($this->mgw) . "', "
               . "'" . trim($this->channel) . "', "
               . "'" . $this->date_start . "'"
               . ")";
         $this->log->write($stmt);
         $mysql_conn->query($stmt);
      }
      else
      {
         $row = $mysql_conn->fetch_assoc_array();
         if(
            ($this->id != $row["MQ_ID"]) 
            || (strcmp($this->host, trim($row["HOST"])) != 0)
            || ($this->port != $row["PORT"])
            || (strcmp($this->mgw, trim($row["MGW"])) != 0)
            || (strcmp($this->channel, trim($row["CHANNEL"])) != 0)
            )
         {
            //UPDATE
            $stmt = "UPDATE MQ SET"
                  . " HOST = '" . trim($this->host) . "', "
                  . " PORT = " . $this->port . ", "
                  . " MGW = '" . trim($this->mgw) . "', "
                  . " CHANNEL = '" . trim($this->channel) . "', "
                  . " DATE_START = '" . $this->date_start . "'"
                  . " WHERE"
                  . " MQ_ID LIKE '" . $this->id . "'";
            $this->log->write($stmt);
            $mysql_conn->query($stmt);
         }
      }
      $this->log->write("MQ->db_update_mysql() END");
   }
   
   
   
   
 // SELECT * FROM V_APP_MQ_SECURITY where Q_MANAGER
   
         // [18:16] ENV_ID = 219
         // $row["ENV_ID"];
         // NOT IN MQ OBJECT
         // This is the DB ENVT ID
         
         // [18:16] OWNER_ACCOUNT = TIERS3TRNTEST1OWN
         // $row["OWNER_ACCOUNT"];
         // NOT IN MQ OBJECT
         // This is the DB Owner Account
         
         // [18:16] HOST_STRING = TRTSTTRN
         // $row["HOST_STRING"];
         // NOT IN MQ OBJECT
         // This is the DATABASE
                  
         // NOT IN MQ OBJECT
         // [18:16] UMODE = O
         // NOT IN MQ OBJECT
         // [18:16] UMODE = O
         
         // [18:16] Q_MANAGER = TIERS.QM1
         // MQ->id
         // $row["Q_MANAGER"];
         // This is the MQ Queue Manager
         
         // [18:16] PORT = 1415
         // MQ->port
         // $row["PORT"];
         // This is the MQ Port
         
         // [18:16] GATEWAY_CHANNEL = GATEWAYS.SVRCONN.CHL
         // MQ->mgw
         // $row["GATEWAY_CHANNEL"];
         // This is the MQ Gateway Channel
         
         // [18:16] APPINST = iedaau018Network\iedaau001_1\apt2-batch-server1
         // [18:16] APPINST = iedadu002/TIERS/AGING02/props/TIERS.properties
         // [18:16] APPINST = tiers_aging_Network\iedaau002\aging02-server2
         // MQ->apps[]
         // $row["APPINST"];
         // This determines what app has permissions to connect to this MQ
         // Each query may return > 1 result based on what security is set for.
         
         
         // [18:16] IPADDRESS = iedaau006
         // MQ->host
         // $row["IPADDRESS"];
         // This is hte MQ Host name
         
         // [18:16] SERVER_NAME = 165.184.38.210
         // $row["SERVER_NAME"]
         // This is the MQ Host IP address
   
     
}
?>
