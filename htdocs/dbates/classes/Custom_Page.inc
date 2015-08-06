<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Rep.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Link.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Service_Team.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Coverage.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Form.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/FAQ.inc");

class Custom_Page
{
   function Custom_Page()
   {
      $this->client = new Client();
      $this->log = new Secretary();
      $this->service_team = new Service_Team();
      $this->link_list = Array();
      $this->form_list = Array();
      $this->faq_list = Array();
      $this->coverage_list = Array();
   }
   var $log;
   var $client;
   var $logo;
   var $coverage_list;
   var $news;
   var $link_list;
   var $form_list;
   var $faq_list;
   var $forms;
   var $leaders;
   var $service_team;
   var $active;
   
   function faqIsInList($faq_id)
   {
      foreach($this->faq_list AS $id=>$faq)
      {
         if($faq->id == $faq_id)
            return(true);
      }
      return(false);
   }
   function linkIsInList($link_id)
   {

      //for($i=0; $i<sizeof($this->link_list); $i++)
      foreach($this->link_list AS $id=>$link)
      {
         //if($this->link_list[$i]->id == $link_id)
         if($link->id == $link_id)
         {

            return(true);
         }
      }

      return(false);
   }
   
   function formIsInList($form_id)
   {

      //for($i=0; $i<sizeof($this->form_list); $i++)
      foreach($this->form_list AS $id=>$form)
      {

         //if($this->form_list[$i]->id == $form_id)
         if($form->id == $form_id)
         {

            return(true);
         }
      }

      return(false);
   }
   
   
   function dbLoadFAQList($dbmgr)
   {
      $this->log->write("Custom_Page->dbLoadFAQList(dbmgr)");
      $sel = "SELECT F.QUESTION, F.SOLUTION, F.FAQ_ID "
           . "FROM FAQ F, CP_FAQ CF "
           . " WHERE F.FAQ_ID = CF.FAQ_ID"
           . " AND CF.USER_ID = " . $this->client->id;

      if(!($dbmgr->query($sel)))
      {

         return(false);
      }
      $this->faq_list = Array();
      while($row = $dbmgr->fetch_array())
      {
         $faq = new FAQ;
         $faq->id = $row["FAQ_ID"];
         $faq->question = $row["QUESTION"];
         $faq->solution = $row["SOLUTION"];
         array_push($this->faq_list, $faq);
      }
      return(true);
   }
   function dbLoadLinkList($dbmgr)
   {
      $this->log->write("Custom_Page->dbLoadLinkList(dbmgr)");
      $sel = "SELECT L.TITLE, L.LINK_ID, L.ADDRESS "
           . "FROM LINK L, CP_LINK CL "
           . " WHERE L.LINK_ID = CL.LINK_ID"
           . " AND CL.USER_ID = " . $this->client->id;

      if(!($dbmgr->query($sel)))
      {

         return(false);
      }
      $this->link_list = Array();
      while($row = $dbmgr->fetch_array())
      {
         $link = new Link;
         $link->title = $row["TITLE"];
         $link->address = $row["ADDRESS"];
         $link->id = $row["LINK_ID"];
         array_push($this->link_list, $link);
      }
      return(true);
   }
   function dbLoadFormList($dbmgr)
   {
      $this->log->write("Custom_Page->dbLoadFormList(dbmgr)");
      $sel = "SELECT F.TITLE, F.FORM_ID, F.FILE_NAME "
           . "FROM FORM F, CP_FORM CF "
           . " WHERE F.FORM_ID = CF.FORM_ID"
           . " AND CF.USER_ID = " . $this->client->id;

      if(!($dbmgr->query($sel)))
      {

         return(false);
      }
      $this->form_list = Array();
      while($row = $dbmgr->fetch_array())
      {
         $form = new Form;
         $form->title = $row["TITLE"];
         $form->id = $row["FORM_ID"];
         $form->file_name = $row["FILE_NAME"];
         array_push($this->form_list, $form);
      }
      return(true);
   }
   
   function dbLoadCoverageList($dbmgr)
   {
      $this->log->write("Custom_Page->dbLoadCoverageList()");
      $sel = "SELECT C.COV_ID, C.FILE_ID, C.TITLE, F.FILE_NAME "
           . "FROM CP_COVERAGE C, FILE F "
           . "WHERE C.USER_ID = " . $this->client->id
           . " AND C.FILE_ID = F.FILE_ID"
           . " ORDER BY C.COV_ID";

      if(!($dbmgr->query($sel)))
      {

         return(false);
      }
      $this->coverage_list = Array();
      while($row = $dbmgr->fetch_array())
      {
         $cov = new Coverage();
         $cov->cov_id = $row["COV_ID"];
         $cov->file_id = $row["FILE_ID"];
         $cov->title = $row["TITLE"];
         $cov->file_name = $row["FILE_NAME"];
         array_push($this->coverage_list, $cov);
      }
   }
      
   
   
   
   function dbAddFAQ($dbmgr, $faq)
   {
      array_push($this->faq_list, $faq);
      $ins = "INSERT INTO CP_FAQ (USER_ID, FAQ_ID)"
           . " VALUES ("
           . $this->client->id . ", "
           . $faq->id . ");";
      if(!($dbmgr->query($ins)))
      {

         return(false);
      }
      return(sizeof($this->faq_list));
   }
   function dbAddLink($dbmgr, $link)
   {
      array_push($this->link_list, $link);
      $ins = "INSERT INTO CP_LINK (USER_ID, LINK_ID)"
           . " VALUES ("
           . $this->client->id . ", "
           . $link->id . ");";
      if(!($dbmgr->query($ins)))
      {

         return(false);
      }
      return(sizeof($this->link_list));
   }
   function dbAddForm($dbmgr, $form)
   {
      array_push($this->form_list, $form);
      $ins = "INSERT INTO CP_FORM (USER_ID, FORM_ID)"
           . " VALUES ("
           . $this->client->id . ", "
           . $form->id . ");";

      if(!($dbmgr->query($ins)))
      {

         return(false);
      }
      return(sizeof($this->form_list));
   }
   
   
   function dbRemoveFAQ($dbmgr, $faq)
   {
      $del = "DELETE FROM CP_FAQ WHERE"
           . " USER_ID = " . $this->client->id
           . " AND FAQ_ID = " . $faq->id;
      if(!($dbmgr->query($del)))
      {

         return(false);
      }
      return(true);
   }
   function dbRemoveLink($dbmgr, $link)
   {
      $del = "DELETE FROM CP_LINK WHERE"
           . " USER_ID = " . $this->client->id
           . " AND LINK_ID = " . $link->id;
      if(!($dbmgr->query($del)))
      {

         return(false);
      }
      return(true);
   }
   function dbRemoveForm($dbmgr, $form)
   {

      $del = "DELETE FROM CP_FORM WHERE"
           . " USER_ID = " . $this->client->id
           . " AND FORM_ID = " . $form->id;
     
      if(!($dbmgr->query($del)))
      {

         return(false);
      }
      return(true);
   }
   
   
   function setClient($dbmgr, $clientId)
   {

      $this->client->id = $clientId;
      $this->client->dbLoadName($dbmgr);

   }
   
   function dbInsertMain($dbmgr)
   {
      $this->log->write("Custom_Page->dbInsertMain(dbmgr)");
      $ins = "INSERT INTO CP_INDEX VALUES (" . $this->client->id . ", '" . $this->logo . "', '1')";

      if(!($dbmgr->query($ins)))
      {

         return(false);
      }
      return(true);
   }
   function dbUpdateLogo($dbmgr)
   {
      $this->log->write("Custom_Page->dbUpdateLogo(dbmgr)");
      $upd = "UPDATE CP_INDEX SET LOGO = '" . $this->logo . "' WHERE USER_ID = " . $this->client->id;

      if(!($dbmgr->query($upd)))
      {

         return(false);
      }
      return(true);
   }
      
   function dbLoad($dbmgr)
   {
      $this->log->write("Custom_Page->dbLoad(dbmgr)");
      $sel = "SELECT LOGO, ACTIVE FROM CP_INDEX WHERE USER_ID = " . $this->client->id;

      if(!($dbmgr->query($sel)))
      {

         return(false);
      }
      $row = $dbmgr->fetch_row();
      $this->logo = $row[0];
      $this->active = $row[1];

      $this->service_team->dbLoad($dbmgr, $this->client->id);
      $this->dbLoadCoverageList($dbmgr);
      $this->dbLoadLinkList($dbmgr);
      $this->dbLoadFormList($dbmgr);
      $this->dbLoadFAQList($dbmgr);
   }
   
   
   function isActive()
   {
      if($this->active) $toReturn = "ACTIVE";
      else $toReturn = "INACTIVE";

      return $toReturn;
   }
   function dbDeactivate($dbmgr)
   {
      $this->log->write("Custom_Page->DbDelete(dbmgr)");
      $del = "UPDATE CP_INDEX SET ACTIVE = '0' WHERE USER_ID = " . $this->client->id;
      if(!($dbmgr->query($del)))
      {

         return(mysql_error() . " IN $del");
      }
      return(true);
   }
   
   function dbActivate($dbmgr)
   {
      $this->log->write("Custom_Page->DbDelete(dbmgr)");
      $del = "UPDATE CP_INDEX SET ACTIVE = '1' WHERE USER_ID = " . $this->client->id;
      if(!($dbmgr->query($del)))
      {

         return(mysql_error() . " IN $del");
      }
      return(true);
   }
}   
?>