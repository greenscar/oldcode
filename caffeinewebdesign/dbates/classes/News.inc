<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
class News{
   
   var $log;
   var $id;
   var $title;
   var $description;
   var $post_date;
   var $expire_date;
   var $never_expire;
   
   function News()
   {
      $this->log = new Secretary();
   }
   
   function dbUpdate($dbmgr)
   {
      $this->log->write("News->dbUpdate(dbmgr)");
      $upd = "UPDATE NEWS SET "
           . "TITLE = '" . $this->title
           . "', DESCRIPTION = '" . $this->description . "', POST_DATE = " . $this->post_date;
      if($this->never_expire)
         $upd .= ", EXPIRE_DATE = null"
              . ", NEVER_EXPIRE = '1'";
      else
         $upd .= ", EXPIRE_DATE = " . $this->expire_date
              . ", NEVER_EXPIRE = '0'";
      $upd .= " WHERE NEWS_ID = " . $this->id;
//.*write(.*$.*);
      $rs = $dbmgr->query($upd);
      if(!$rs)
      {
//.*write(.*$.*);
         return(false);
      }
      return(true);
   }
   function dbInsert($dbmgr)
   {
      $this->log->write("News->dbInsert(dbmgr)");
      $ins = "INSERT INTO NEWS (TITLE, DESCRIPTION, POST_DATE, ";
      if(!$this->never_expire)
         $ins .= "EXPIRE_DATE, ";
      $ins .= "NEVER_EXPIRE) "
           . "VALUES "
           . "('" . $this->title . "', '" . $this->description . "', " . time() . ", ";
      if($this->never_expire)
         $ins .= " '1')";
      else
         $ins .= $this->expire_date
              . ", '0')";
//.*write(.*$.*);
      if(!($dbmgr->query($ins)))
      {
//.*write(.*$.*);
         return(false);
      }
      $this->id = $dbmgr->get_last_key();
      return $this->id;
   }
   function dbDelete($dbmgr)
   {
      $this->log->write("News->dbDelete(dbmgr)");
      $del = "DELETE FROM NEWS WHERE NEWS_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($del)))
      {
//.*write(.*$.*);
         return(false);
      }
   }
   function dbLoad($dbmgr)
   {
      $this->log->write("News->dbLoad(dbmgr)");
      $load = "SELECT TITLE, DESCRIPTION, POST_DATE, EXPIRE_DATE, NEVER_EXPIRE FROM NEWS "
            . "WHERE NEWS_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($load)))
      {
//.*write(.*$.*);
         return(false);
      }
      $row = $dbmgr->fetch_row();
      $this->title = $row[0];
      $this->description = $row[1];
      $this->post_date = $row[2];
      if($row[4]) $this->never_expire = true;
      else $this->expire_date = date("m/d/Y", $row[3]);
      return $this->id;
   }
   function getPostDate()
   {
      //return($this->post_date);
      return date("m/d/Y", $this->post_date);
   }
}
?>