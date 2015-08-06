<?php
require_once("Secretary.inc");
require_once("Settings.inc");
class Schema
{
   var $id;
   var $box;
   var $port;
   var $db;
   var $uid;
   var $pwd;
   var $version;
   var $descr;
   var $all_versions;
   var $settings;
   var $url;
   
   function Schema()
   {
      $this->log = new Secretary();
      $this->all_versions = array();
      $this->settings = new Settings();
   }
   function to_string()
   {
      $thistr = "\r\n-------------------------------------------\r\n";
      $thistr .= "id => " . $this->id . "\r\n";
      $thistr .= "box => " . $this->box . "\r\n";
      $thistr .= "port => " . $this->port . "\r\n";
      $thistr .= "db => " . $this->db . "\r\n";
      $thistr .= "uid => " . $this->uid . "\r\n";
      $thistr .= "version => " . $this->version . "\r\n";
      $thistr .= "-------------------------------------------\r\n";
      return($thistr);
   }
   function db_update_mysql($mysql_conn)
   {
      $this->log->write("Schema->db_update_mysql() START");
      $stmt = "SELECT ID, BOX, PORT, PWD, URL FROM `SCHEMA` "
             . " WHERE DB LIKE '" . $this->db . "' "
             . " AND UID LIKE '" . $this->uid . "' ";
      $this->log->write($stmt);
      $mysql_conn->query($stmt);
      $num_rows = $mysql_conn->get_num_rows();
      $this->log->write("num_rows = $num_rows");
      if($num_rows == 0)
      {
         //INSERT
         $stmt = "INSERT INTO `SCHEMA` "
               . "(ID, BOX, PORT, DB, UID, PWD, URL) "
               . "VALUES ("
               . $this->id . ", "
               . "'" . trim($this->box) . "', "
               . $this->port . ", "
               . "'" . trim($this->db) . "', "
               . "'" . trim($this->uid) . "', "
               . "'" . trim($this->pwd) . "', "
               . "'" . addslashes(trim($this->url)) . "');";
         $this->log->write($stmt);
         $mysql_conn->query($stmt);
      }
      else
      {
         $row = $mysql_conn->fetch_assoc_array();
         if(
            ($this->id != $row["ID"]) 
            || (strcmp($this->box, trim($row["BOX"])) != 0)
            || ($this->port != $row["PORT"])
            || (strcmp($this->pwd, trim($row["PWD"])) != 0)
            || (strcmp($this->url, trim($row["URL"])) != 0)
            )
         {
            //UPDATE
            $stmt = "UPDATE `SCHEMA` SET"
                  . " BOX = '" . trim($this->box) . "', "
                  . " PORT = " . $this->port . ", "
                  . " DB = '" . trim($this->db) . "', "
                  . " UID = '" . trim($this->uid) . "', "
                  . " PWD = '" . trim($this->pwd) . "', "
                  . " URL = '" . addslashes(trim($this->url)) . "'"
                  . " WHERE"
                  . " ID = " . $this->id;
            $this->log->write($stmt);
            $mysql_conn->query($stmt);
         }
      }
      $this->log->write("Schema->db_update_mysql() END");
   }
   function set_via_xml($user, $password, $url)
   {
      //$this->log->write("Schema->set_via_xml($user, $password, $url) START");
      $this->url = $url; //jdbc:oracle:thin:@iedadu004:1521:TRDEV
      $this->uid = strtoupper($user);
      $this->pwd = strtoupper($password);
      if(substr_count($this->url, "HOST") > 1)
      {
         // A CLUSTERED DB. 
         // EX:
         // (DESCRIPTION =(ENABLE=BROKEN)(LOAD_BALANCE=ON)(ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = iedadu001)(PORT = 1525))(ADDRESS = (PROTOCOL = TCP)(HOST = iedadu002)(PORT = 1525)))(CONNECT_DATA = (SERVICE_NAME = TRTSTC1.txaccess.net)))
         $arg_array = array();
         preg_match_all("(\s*\w+\s*=\s*\w+\s*)", $this->url, $arg_array);
         $arg_array = $arg_array[0];
         foreach($arg_array AS $id=>$val)
         {
            //foreach($val as $subid=>$subval)
            //{
               #echo("$val<BR>");
               $val = str_replace(" ", "", $val);
               $temp = explode("=", $val);
               if(strcmp($temp[0], "HOST") == 0)
               {
                  $this->box = $temp[1];
               }
               else if(strcmp($temp[0], "PORT") == 0)
               {
                  $this->port = $temp[1];
               }
               else if(strcmp($temp[0], "SERVICE_NAME") == 0)
               {
                  $this->db = strtoupper($temp[1]);
               }
               //echo("name(" . $temp[0] . ") => val(" . $temp[1] . ")<br>");
               //$val = preg_replace("\s+", "", $val);
               //echo("$id => $val <BR>");
            //}
         }
      }
      else
      {
         $var_array = explode(":", $url);
         $this->box = substr($var_array[3], 1);
         $this->port = $var_array[4];
         $this->db = strtoupper($var_array[5]);
      }
      //$this->log->write("Schema->set_via_xml($user, $password, $url) END");
   }
   /*
   function db_load_id_via_db_and_user($dbmgr)
   {
      $this->log->write("Schema->db_load_id(dbmgr)) START");
      $query = "SELECT a.ENV_ID"
               . " FROM v_ENVIRONMENTs a"
               . " WHERE a.HOST_STRING like '$this->db'"
               . " AND a.CONNECT_ACCOUNT like '$this->uid'";
      $this->log->write($query);
      $dbmgr->query($query);
      if($row = $dbmgr->fetch_assoc_array())
      {
         $this->id = $row["ENV_ID"];
      }
      else
      {
         $this->log->write("That Envt Does not exist!!!!");
         $this->id = "XXX";
      }
      $this->log->write("Schema->db_load_id(dbmgr)) END");
   }
   */
   function db_load_tiers_db_versions($dbmgr)
   {
      $this->log->write("Schema->db_load_db_release_nums() START");
      $query = "SELECT a.BUILD_NUM from v_ENVIRONMENTs a"
               . " where a.DISPLAY_SW = 'Y' and a.ENV_ID in (";
      $envs_to_display = $this->settings->app_schemas["TIERS"];
      foreach($envs_to_display as $key=>$val)
      {
         $query .= $val . ", ";
      }
      $query = substr($query, 0, (strlen($query) - 2));
      $query .= ")"
             . " ORDER BY BUILD_NUM";
      $this->log->write($query);
      $dbmgr->query($query);
      while($row = $dbmgr->fetch_assoc_array())
      {
         $bn = trim($row["BUILD_NUM"]);
         $inarray = in_array($bn, $this->all_versions);
         if(!$inarray)
         {
            $this->log->write("push " . $bn);
            array_push($this->all_versions, $bn);
         }
      }
      $this->log->write("Envt_Mgr->db_load_db_release_nums() END");
   }
   
   function db_load_info($dbmgr)
   {
      $this->log->write("Schema->db_load_info($dbmgr) START");
      $query = "SELECT a.ENV_ID,a.BUILD_NUM,a.NAME,a.HOST_STRING,c.HOST_NAME,a.CONNECT_ACCOUNT"
         . " from v_ENVIRONMENTs a, v_ad_instances b, ad_hosts c"
         . " where a.HOST_STRING = b.INSTANCE"
         . " and b.HOST_ID = c.HOST_ID"
         . " and a.ENV_ID = " . $this->id;
      $this->log->write($query);
      if($row = $dbmgr->fetch_assoc_array())
      {
         $this->id = $row["ENV_ID"];
         $this->descr = $row["NAME"];
         $this->box= $row["HOST_NAME"];
         $this->port= 0000;
         $this->db= $row["HOST_STRING"];
         $this->uid= $row["CONNECT_ACCOUNT"];
         $this->version= $row["BUILD_NUM"];
      }
      $this->log->write("Schema->db_load_info($dbmgr) END");
   }
}


?>

