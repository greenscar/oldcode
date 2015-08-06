<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/User.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Rep.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/News.inc");
class User_Public extends User
{
   var $rep_list;
   var $dbmgr;
   var $log;
   var $news_list;
   function User_Public()
   {
      $this->log = new Secretary();
      $this->dbmgr = new DB_Mgr("dbates");
      User::User();
   }
   function dbLoadNewsList()
   {
      $this->log->write("User_Public->dbLoadNewsList()");
      $this->news_list = Array();
      $sel = "SELECT NEWS_ID, TITLE, DESCRIPTION, POST_DATE FROM NEWS WHERE NEVER_EXPIRE = '1' OR EXPIRE_DATE > " . time() . " ORDER BY POST_DATE";
//.*write(.*$.*);
      if(!($this->dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      while($row = $this->dbmgr->fetch_row())
      {
         $news = new News();
         $news->id = $row[0];
         $news->title = $row[1];
         $news->description = $row[2];
         $news->post_date = $row[3];
         array_push($this->news_list, $news);
      }
   }
   function dbLoadRepList()
   {
      $this->log->write("User_Public->dbLoadRepList() START");
      //$this->log->write("test");
      $sel = "SELECT REP_ID FROM REP WHERE ACTIVE = '1' ORDER BY LAST_NAME";
      //$this->log->write("test2");
//.*write(.*$.*);
      //return $sel;
      if(!($this->dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      $this->rep_list = Array();
      $dbmgr2 = new DB_Mgr("dbates");
      while($row = $this->dbmgr->fetch_array())
      {
         $rep = new Rep();
         $rep->id = $row[0];
         $rep->dbLoad($dbmgr2);
         $rep->logValues();
         array_push($this->rep_list, $rep);
      }
//.*write(.*$.*);
   }
}

?>