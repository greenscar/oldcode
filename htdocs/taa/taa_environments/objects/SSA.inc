<?php
require_once("Secretary.inc");
require_once("Settings.inc");
class SSA
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
         $this->host = $row["HOST"];
         $this->port = $row["PORT"];
         $this->mgw = $row["MGW"];
         $this->channel = $row["CHANNEL"];
         $this->date_start = $row["DATE_START"];
         $this->date_end = $row["DATE_END"];
         $to_return = true;
      }
      $dbmgr->disconnect();
      $this->log->write("id->db_load($dbmgr, $id)) END -> $to_return");
      return($to_return);
   }
   
     
}
?>
