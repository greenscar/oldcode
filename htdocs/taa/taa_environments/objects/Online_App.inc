<?php
require_once("Secretary.inc");
require_once("App.inc");
require_once("MQ.inc");
require_once("Schema.inc");
require_once("XML_Parser.inc");
class Online_App extends App
{
   var $ws_app_name;
   var $cluster;
   var $ws_cell_name;
   var $dns;
   var $source_stream;
   var $build_time;
   var $admin_panel;
   var $app_servers;
   var $date_start;
   var $date_end;
   var $xml_parser;
   
   function Online_App()
   {
      parent::App();
      $this->app_servers = array();
      $this->xml_parser = new XML_Parser();
      
   }
   function to_string()
   {
      $str = "\r\n-------------------------------------------\r\n";
      $str .= parent::to_string();
      $str .= "ws_app_name => " . $this->ws_app_name . "\r\n";
      $str .= "cluster => " . $this->cluster . "\r\n";
      $str .= "cell => " . $this->ws_cell_name . "\r\n";
      $str .= "dns => " . $this->dns . "\r\n";
      $str .= "admin_panel => " . $this->admin_panel . "\r\n";
      $str .= "sizeof(this->app_servers) => " . sizeof($this->app_servers) . "\r\n";
      $str .= "source_stream => " . $this->source_stream . "\r\n";
      $str .= "build_time => " . $this->build_time . "\r\n";
      $str .= "date_start => " . $this->date_start . "\r\n";
      $str .= "date_end => " . $this->date_end . "\r\n";
      $str .= "-------------------------------------------\r\n";
      return($str);
   }
   function add_server($server)
   {
      $this->log->write("OnlineApp->add_server($server) START");
      $already_there = false;
      for($i=0; $i< sizeof($this->app_servers); $i++)
      {
         $this->app_servers[0] = $this->app_servers[$i];
         $this->log->write("new = " . $server->server_name . " VS old = " . $this->app_servers[0]->server_name);
         if(strcmp($server->server_name, $this->app_servers[0]->server_name) == 0)
            $already_there = true;
         $this->log->write("already_there = $already_there");
      }
      if(!$already_there)
         array_push($this->app_servers, $server);
      $this->log->write("OnlineApp->add_server($server) END (" . count($this->app_servers) . " online servers loaded)");
   }
   function get_server_count()
   {
      return sizeof($this->app_servers);
   }
   function get_envt_test_link()
   {
      $str = "http://" . $this->dns . ".txaccess.net/jsp/utils/environmentTest.jsp";
      return($str);
   }
   function get_login_page()
   {
      $str = "http://" . $this->dns . ".txaccess.net/SELoginAccess.jsp";
      return($str);
   }
   
   function get_build_report_link()
   {
      $str = "http://" . $this->dns . "/build_report.xml";
      return($str);
      //http://tiers-ipt/build_report.xml
   }
   function db_update($dbMgrMySQL)
   {
      $this->log->write("Online_App->db_update(dbMgrMySQL)");
      // UPDATE THE MQ IN MYSQL
      $this->mq->db_update_mysql($dbMgrMySQL);
      // UPDATE THE SCHEMA IN MYSQL
      $this->schema->db_update_mysql($dbMgrMySQL);
      
      // UPDATE THE WEBSPHERE APPLICATION
      $check_ws_application = "SELECT WS_APP_NAME, CLUSTER, WS_CELL_NAME, DNS, MQ_ID, DB_ID FROM WS_APPLICATION "
            . " WHERE ENV_ID = " . $this->environment->id
            . " AND APP_ID = " . $this->application->id;
      $this->log->write($check_ws_application);
      $dbMgrMySQL->query($check_ws_application);
      $num_rows = $dbMgrMySQL->get_num_rows();
      if($num_rows > 0)
      {
         // CHECK TO SEE IF WE SHOULD UPDATE
         $row = $dbMgrMySQL->fetch_assoc_array();
         //foreach($row as $id=>$val)
         //   echo("$id => $val<BR>");
         /*
         $this->log->write("'" . $this->ws_app_name . "' vs '" . trim($row["WS_APP_NAME"]) . "' = " . strcmp($this->ws_app_name, trim($row["WS_APP_NAME"])) . "\n");
         $this->log->write("'" . $this->cluster . "' vs '" . trim($row["CLUSTER"]) . "' = " . strcmp($this->cluster, trim($row["CLUSTER"])) . "\n");
         $this->log->write("'" . $this->ws_cell_name . "' vs '" . trim($row["WS_CELL_NAME"]) . "' = " . strcmp($this->ws_cell_name, trim($row["WS_CELL_NAME"])) . "\n");
         $this->log->write("'" . $this->dns . "' vs '" . trim($row["DNS"]) . "' = " . strcmp($this->dns, trim($row["DNS"])) . "\n");
         $this->log->write("'" . $this->mq->id . "' vs '" . trim($row["MQ_ID"]) . "' = " . strcmp($this->mq->id, trim($row["MQ_ID"])) . "\n");
         if($this->schema->id != $row["DB_ID"])
            $this->log->write("'" . $this->schema->id . "' vs '" . trim($row["DB_ID"]) . "' = false\n");
         else
            $this->log->write("'" . $this->schema->id . "' vs '" . trim($row["DB_ID"]) . "' = true\n");
            */
         if(
            (strcmp($this->ws_app_name, trim($row["WS_APP_NAME"]) != 0))
            ||
            (strcmp($this->cluster, trim($row["CLUSTER"]) != 0))
            ||
            (strcmp($this->ws_cell_name, trim($row["WS_CELL_NAME"]) != 0))
            ||
            (strcmp($this->dns, trim($row["DNS"]) != 0))
            ||
            (strcmp($this->mq->id, trim($row["MQ_ID"]) != 0))
            ||
            ($this->schema->id != $row["DB_ID"])
            )
         {
            // UPDATE
            $ws_app_stmt = "UPDATE WS_APPLICATION SET "
                  . " WS_APP_NAME = '" . $this->ws_app_name . "', "
                  . " CLUSTER = '" . $this->cluster . "', "
                  . " WS_CELL_NAME = '" . $this->ws_cell_name . "', "
                  . " DNS = '" . $this->dns . "', "
                  . " MQ_ID = '" . $this->mq->id . "', "
                  . " DB_ID = " . $this->schema->id . ", "
                  . " DATE_START = '" . $this->date_start . "' "
                  . " WHERE"
                  . " ENV_ID = " . $this->environment->id 
                  . " AND "
                  . " APP_ID = " . $this->application->id;
            $this->log->write($ws_app_stmt);
            $dbMgrMySQL->query($ws_app_stmt);
         }
      }  
      else
      {
         // INSERT
         $ws_app_stmt = "INSERT INTO WS_APPLICATION "
               . " (ENV_ID, APP_ID, WS_APP_NAME, CLUSTER, WS_CELL_NAME, DNS, MQ_ID, DB_ID, DATE_START)"
               . " VALUES"
               . " ("
               . $this->environment->id . ", "
               . $this->application->id . ", "
               . "'" . $this->ws_app_name . "', "
               . "'" . $this->cluster . "', "
               . "'" . $this->ws_cell_name . "', "
               . "'" . $this->dns . "', "
               . "'" . $this->mq->id . "', "
               . $this->schema->id . ", "
               . "'" . $this->date_start . "'"
               . ")";
         $this->log->write($ws_app_stmt);
         $dbMgrMySQL->query($ws_app_stmt);
      }
      
      /*
      * TAKE CARE OF THE WEBSPHERE APP SERVERS.
      */
      foreach($this->app_servers AS $id => $server)
      {
         // CHECK TO SEE IF WE NEED TO UPDATE THE WEBSPHERE APPLICATION SERVER
         $check_ws_app_server = "SELECT NODE, PORT, WS_APP_NAME FROM WS_APPSERVER "
               . " WHERE SERVER_NAME LIKE '" . $server->server_name . "'";
         $dbMgrMySQL->query($check_ws_app_server);
         $num_rows = $dbMgrMySQL->get_num_rows();
         if($num_rows > 0)
         {
            // CHECK TO SEE IF WE SHOULD UPDATE
            $row = $dbMgrMySQL->fetch_assoc_array();
            if(
               (strcmp($server->node, trim($row["NODE"]) != 0))
               ||
               ($server->port != $row["PORT"])
               ||
               (strcmp($this->ws_app_name, trim($row["WS_APP_NAME"]) != 0))
               )
            {
               $stmt = "UPDATE WS_APPSERVER SET "
                     . " NODE = '" . $server->node . "', ";
               if($server->port != 0) $stmt .= " PORT = " . $server->port . ", ";
               $stmt .= " WS_APP_NAME = '" . $this->ws_app_name . "', "
                     . " DATE_START = '" . $server->date_start . "'"
                     . " WHERE SERVER_NAME LIKE '" . $server->server_name . "'";
               echo($stmt . "<BR>");
               $this->log->write($stmt);
               $dbMgrMySQL->query($stmt);
            }
         }
         else
         {
            // INSERT THIS APPSERVER INTO THE DB AS IT DOES NOT EXIST
            $stmt = "INSERT INTO WS_APPSERVER (SERVER_NAME, NODE, ";
            if($server->port != 0)
               $stmt .= " PORT, ";
            $stmt .= " WS_APP_NAME, DATE_START)"
                  . " VALUES"
                  . " ("
                  . "'" . $server->server_name . "', "
                  . "'" . $server->node . "', ";
            if($server->port != 0)
                  $stmt .= $server->port . ", ";
            $stmt .= "'" . $this->ws_app_name . "', "
                  . "'" . $server->date_start . "'"
                  . ")";
            echo($stmt);
            $this->log->write($stmt);
            $dbMgrMySQL->query($stmt);
         }
      }
      
      
         
   }
   
   /*******************************************************************
   * We do not want to try to insert an app with a WS_APP_NAME that already 
   * exists. Thus, before inserting, this will be called to check.
   *******************************************************************/
   function WS_APP_NAME_exists($dbMgrMySQL)
   {
      $this->log->write("WS_APP_NAME_exists()");
      $sel = "SELECT count(WS_APP_NAME) as count FROM WS_APPLICATION WHERE WS_APP_NAME LIKE '" . $this->ws_app_name . "'";
      $this->log->write($sel);
      $rs = $dbMgrMySQL->query($sel);
      $row = $dbMgrMySQL->fetch_assoc_array();
      $count = $row['count'];
      $this->log->write("count = $count");
      if($count > 0) $toReturn = true;
      else $toReturn = false;
      $this->log->write("WS_APP_NAME_exists() => $toReturn");
      return($toReturn);
   }
   

   function url_validate($link)
   {    
       $this->log->write("Online_App->url_validate($link) START");
       $url_parts = @parse_url($link);
       if ( empty( $url_parts["host"] ) ) return( false );
       if ( !empty( $url_parts["path"] ) )
       {
           $documentpath = $url_parts["path"];
       }
       else
       {
           $documentpath = "/";
       }

       if ( !empty( $url_parts["query"] ) )
       {
           $documentpath .= "?" . $url_parts["query"];
       }

       $host = $url_parts["host"];
       $port = @$url_parts["port"];
       // Now (HTTP-)GET $documentpath at $host";

       if (empty( $port ) ) $port = "80";
       $socket = @fsockopen( $host, $port, $errno, $errstr, 1 );
       if (!$socket)
       {
           return(false);
       }
       else
       {
           fwrite ($socket, "HEAD ".$documentpath." HTTP/1.0\r\nHost: $host\r\n\r\n");
           $http_response = fgets( $socket, 22 );
           if ( ereg("200 OK", $http_response, $regs ) )
           {
               $this->log->write("Online_App->url_validate() => true");
               return(true);
               fclose( $socket );
           } else
           {
//                echo "HTTP-Response: $http_response<br>";
               $this->log->write("Online_App->url_validate() => false");
               return(false);
           }
       }
   }
   
   
   function load_build_info_xml()
   {
      $link = $this->get_build_report_link();
      if($this->url_validate($link))
      {
         $this->xml_parser = new XML_Parser();
         $data = $this->xml_parser->read_xml_from_http($link);
         $return = $this->xml_parser->parse($data);
         $build_info = $this->xml_parser->data;
         $build_info = @$build_info["BUILD"][0]["child"];
         $this->release_num = @$build_info["NUMBER"][0]["data"];
         $this->source_stream = @$build_info["STREAM"][0]["data"];
         $this->build_time = @$build_info["TIME"][0]["data"];
         $this->baseline_num = @$build_info["BASELINE"][0]["data"];
      }
      else
      {
         $this->release_num = "N/A";
         $this->source_stream = "N/A";
         $this->build_time = "N/A";
         $this->baseline_num = "N/A";
         $this->load_build_info_envt_test();
      }
   }
   
   
   function arraytostring($array)
   {
      @$text.="array(";
      $count=count($array);
      foreach ($array as $key=>$value)
      {
          @$x++;
          if (is_array($value))
          {
              if(substr($text,-1,1)==')')    $text .= ',';
              $text.='"'.$key.'"'."=>".$this->arraytostring($value);
              continue;
          }
          $text.="\"$key\"=>\"$value\"";
          if ($count!=$x) $text.=",";
      }
      $text.=")";
      if(substr($text, -4, 4)=='),),')$text.='))';
      return $text;
   }
   
   function load_build_info_envt_test()
   {
      $pagefile = Array();
      if($this->url_validate($this->get_envt_test_link()))
      {
         $lines = Array();
         $timeout = 30;
         //$old = ini_set('default_socket_timeout', $timeout);
         //$file = fopen('http://example.com', 'r');
         $fd = @fopen ($this->get_envt_test_link(), "r");
         //ini_set('default_socket_timeout', $old);
         //stream_set_timeout($fd, $timeout);
         //stream_set_blocking($fd, 0);
         if($fd)
         {
            while (!feof ($fd))
            {
               $buffer = fgets($fd, 4096);
               $lines[] = $buffer;
            }
            fclose ($fd);
            if(strcmp("</td>", trim($lines[62])) != 0)
            {
               $this->build_time = trim($lines[68]); 
               $this->source_stream = trim($lines[62]);
            }
            else
            {
               $this->build_time = "N/A";
               $this->source_stream = "N/A";
            }
         }
         else
         {
            $this->build_time = "N/A";
            $this->source_stream = "N/A";
         }
         $this->log->write("num lines = " . sizeof($lines));
      }
      else
      {
         $this->build_time = "N/A";
         $this->source_stream = "N/A";
      }
      /*
      if((sizeof($pagefile) > 100) && (strpos($pagefile[68], "<td>") == false))
      {
         $this->build_time = trim($pagefile[68]); 
         $this->source_stream = trim($pagefile[62]);
      }
      else
      {
         $this->build_time = "N/A";
         $this->source_stream = "N/A";
      }
      */
   }
   function site_up()
   {
      $fp = @fsockopen($this->dns, 80);
      if (!$fp) {
         $this->log->write("site_up() for $this->dns => FALSE");
         return(false);
      }
      else
      {
         $this->log->write("site_up() for $this->dns => TRUE");
         return(true);
      }
   }
}
?>
