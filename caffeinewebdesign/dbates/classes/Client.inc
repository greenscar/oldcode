<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Department.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Specialty.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/User.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Custom_Page.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/BFCP.inc");
//require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Batch_File_Custom_Page.inc");
class Client extends User
{
   var $contact;
   var $lead_producer;
   var $lead_csr;
   /*
    * REPS AND PRODUCERS ARE ARRAYS OF REP ID'S. THE ARRAY LOCATION IS THE ID OF THE ACCOUNT TYPE.
    *  
    */
   var $csrs;
   var $producers;
   var $custPage;
   var $bfCustPage;
   
   function Client()
   {
      User::User();
      $this->producers = Array();
      $this->csrs = Array();
      $this->sec_lvl_id = 1;
      $this->sec_lvl_name = "CLIENT";
   }
   
   function getUserType()
   {
      return $this->sec_lvl_name;
   }
   function logValues()
   {
   }
   function dbInsert($dbmgr)
   {
      $ins = "INSERT INTO USER "
           . "(USER_NAME, PASSWORD, NAME, CONTACT, PHONE, EMAIL, ACTIVE, SEC_LVL_ID)"
           . " VALUES "
           . "('"
           . $this->user_name . "', '"
           . $this->password . "', '"
           . $this->name . "', '"
           . $this->contact . "', '"
           . $this->phone . "', '"
           . $this->email . "', '"
           . $this->active . "', '"
           . $this->sec_lvl_id . "');";
      //return($ins);
      //return $dbmgr->query($ins) or mysql_error();
      if(!($dbmgr->query($ins)))
         return("ERROR in $ins<BR>");
      $this->id = $dbmgr->get_last_key();
      
      $toReturn = "";
      // INSERT CLIENT LEAD
      $ins = "INSERT INTO LEAD (USER_ID, PRODUCER_ID, CSR_ID) VALUES "
           . "(" . $this->id . ", " . $this->lead_producer . ", " .$this->lead_csr . ");";
      $toReturn .= $ins . "<BR>";
      if(!($dbmgr->query($ins)))
         return("ERROR in $ins<BR>");
           
      // INSERT CSRS
      foreach($this->csrs as $key => $elem)
      {
         $ins = "INSERT INTO CLIENT_REP (USER_ID, REP_ID, DEPT_ID) VALUES "
              . "(" . $this->id . ", " . $elem . ", " . $key . ")";
      $toReturn .= $ins . "<BR>";
      if(!($dbmgr->query($ins)))
            return("ERROR in $ins<BR>");
      }      
      // INSERT PRODUCERS
      foreach($this->producers as $key => $elem)
      {
         $ins = "INSERT INTO CLIENT_PRODUCER (USER_ID, REP_ID, DEPT_ID) VALUES "
              . "(" . $this->id . ", " . $elem . ", " . $key . ")";
      $toReturn .= $ins . "<BR>";
      if(!($dbmgr->query($ins)))
            return("ERROR in $ins<BR>");
      }
      return $toReturn;
      return $this->id;
   }
   
   function dbDelete($dbmgr)
   {
      $del = "DELETE FROM USER WHERE USER_ID = " . $this->id;
      $del_lead = "DELETE FROM LEAD WHERE USER_ID = " . $this->id;
      $del_rep = "DELETE FROM CLIENT_REP WHERE USER_ID = " . $this->id;
      $del_pro = "DELETE FROM CLIENT_PRODUCER WHERE USER_ID = " . $this->id;
      if(!($dbmgr->query($del)))
            return("ERROR in $del<BR>");
      if(!($dbmgr->query($del_lead)))
            return("ERROR in $del_lead<BR>");
      if(!($dbmgr->query($del_rep)))
            return("ERROR in $del_rep<BR>");
      if(!($dbmgr->query($del_pro)))
            return("ERROR in $del_pro<BR>");
      return true;
   }
   
   function dbUpdate($dbmgr)
   {
      $this->log->write("Client->dbUpdate(dbmgr)");
      if(empty($this->id)) return false;
      $upd = "UPDATE USER SET "
           . " USER_NAME = '" . $this->user_name;
           if($this->password != '')
           $upd .= "', PASSWORD = '" . $this->password;
           $upd .= "', NAME = '" . $this->name
           . "', CONTACT = '" . $this->contact
           . "', PHONE = '" . $this->phone
           . "', EMAIL = '" . $this->email
           . "', ACTIVE = '" . $this->active
           . "', SEC_LVL_ID = '" . $this->sec_lvl_id
           . "' WHERE USER_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($upd)))
      {
//.*write(.*$.*);
         return(false);
      }
      $del = "DELETE FROM LEAD WHERE USER_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($del)))
      {
//.*write(.*$.*);
         return(false);
      }
      // UPDATE CLIENT LEAD
      if($this->lead_producer != 0)
      {
         $upd = "INSERT INTO LEAD (PRODUCER_ID, CSR_ID, USER_ID) VALUES ("
              . $this->lead_producer . ", "
              . $this->lead_csr . ", "
              . $this->id . ");";
//.*write(.*$.*);
         if(!($dbmgr->query($upd)))
         {
//.*write(.*$.*);
            return(false);
         }
      }
      //$toReturn = $upd . "<BR>";
      $del = "DELETE FROM CLIENT_REP WHERE USER_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($del)))
      {
//.*write(.*$.*);
         return(false);
      }
      //$toReturn .= $del . "<BR>";
      $del = "DELETE FROM CLIENT_PRODUCER WHERE USER_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($del)))
      {
//.*write(.*$.*);
         return(false);
      }
      //$toReturn .= $del . "<BR>";
      // UPDATE CSRS
      foreach($this->csrs as $key => $elem)
      {
         $ins = "INSERT INTO CLIENT_REP (USER_ID, REP_ID, DEPT_ID) VALUES "
              . "(" . $this->id . ", " . $elem . ", " . $key . ")";
//.*write(.*$.*);
         if(!($dbmgr->query($ins)))
         {
//.*write(.*$.*);
            return(false);
         }
      //   $toReturn .= $ins . "<BR>";
      }      
      // UPDATE PRODUCERS
      foreach($this->producers as $key => $elem)
      {
         $ins = "INSERT INTO CLIENT_PRODUCER (USER_ID, REP_ID, DEPT_ID) VALUES "
              . "(" . $this->id . ", " . $elem . ", " . $key . ")";
//.*write(.*$.*);
         if(!($dbmgr->query($ins)))
         {
//.*write(.*$.*);
            return(false);
         }
      }
      return $this->id;
      //return $toReturn;
   }
   
   
   function dbUpdateContactInfo($dbmgr)
   {
      $this->log->write("Client->dbUpdateContactInfo(dbmgr)");
      if(empty($this->id)) return false;
      $upd = "UPDATE USER SET "
           . " USER_NAME = '" . $this->user_name
           . "', PASSWORD = '" . $this->password
           . "', NAME = '" . $this->name
           . "', CONTACT = '" . $this->contact
           . "', PHONE = '" . $this->phone
           . "', EMAIL = '" . $this->email
           . "', ACTIVE = '" . $this->active
           . "' WHERE USER_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($upd)))
      {
//.*write(.*$.*);
         return(false);
      }
   }
   function dbLoad($dbmgr)
   {
      $this->log->write("Client->dbLoad(dbmgr)");
      $sel = "SELECT USER_NAME, PASSWORD, NAME, CONTACT, PHONE, EMAIL, ACTIVE "
           . "FROM USER WHERE USER_ID = " . $this->id;
//.*write(.*$.*);
      //return($dbmgr->query($sel));
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      $row = $dbmgr->fetch_row();
      $this->user_name = $row[0];
      $this->password = $row[1];
      $this->name = $row[2];
      $this->contact = $row[3];
      $this->phone = $row[4];
      $this->email = $row[5];
      $this->active = $row[6];
      
      // LOAD CLIENT LEAD
      $sel = "SELECT PRODUCER_ID, CSR_ID FROM LEAD WHERE USER_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      $row = $dbmgr->fetch_row();
      $this->lead_producer = $row[0];
      $this->lead_csr = $row[1];
//.*write(.*$.*);
//.*write(.*$.*);
      // LOAD CSRS
      $this->csrs = Array();
      $sel = "SELECT DEPT_ID, REP_ID FROM CLIENT_REP WHERE USER_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      while($row = $dbmgr->fetch_row())
      {
         $this->csrs[$row[0]] = $row[1];
//.*write(.*$.*);
      }
      // LOAD PRODUCERS
      $this->producers = Array();
      $sel = "SELECT DEPT_ID, REP_ID FROM CLIENT_PRODUCER WHERE USER_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      while($row = $dbmgr->fetch_row())
      {
         $this->producers[$row[0]] = $row[1];
//.*write(.*$.*);
      }
      //$this->log_values();
//.*write(.*$.*);
      return $this->id;
   }
   function dbLoadCustomPages($dbmgr)
   {
//.*write(.*$.*);
      $selCP = "SELECT LOGO FROM CP_INDEX WHERE ACTIVE = '1' AND USER_ID = " . $this->id;
      //return $selCP;
//.*write(.*$.*);
      if(!($dbmgr->query($selCP)))
      {
//.*write(.*$.*);
         return(false);
      }
      if($row = $dbmgr->fetch_array())
      {
         $this->custPage = new Custom_Page();
         $this->custPage->logo = $row["LOGO"];
         $this->bfCustPage->client->id = $this->id;
         $this->bfCustPage->client->name = $this->name;
         $this->custPage->active = 1;
      }
      $selBFCP = "SELECT ACTIVE FROM BFCP_INDEX WHERE ACTIVE = '1' AND USER_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($selBFCP)))
      {
//.*write(.*$.*);
         return(false);
      }
      if($row = $dbmgr->fetch_row())
      {
         //$this->bfCustPage = new Batch_File_Custom_Page();
         $this->bfCustPage = new BFCP();
         $this->bfCustPage->client->id = $this->id;
         $this->bfCustPage->client->name = $this->name;
         $this->bfCustPage->active = 1;
      }
      return(true);
   }
   function hasCPage($dbmgr)
   {
      $selCP = "SELECT LOGO FROM CP_INDEX WHERE ACTIVE = '1' AND USER_ID = " . $this->id;
      //return $selCP;
//.*write(.*$.*);
      if(!($dbmgr->query($selCP)))
      {
//.*write(.*$.*);
         return(false);
      }
      if($dbmgr->get_num_rows() > 0)
      {
         return(true);
      }
      return(false);
   }
   function hasBFPage($dbmgr)
   {
      $selBFCP = "SELECT ACTIVE FROM BFCP_INDEX WHERE ACTIVE = '1' AND USER_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($selBFCP)))
      {
//.*write(.*$.*);
         return(false);
      }
      if($dbmgr->get_num_rows() > 0)
      {
         return(true);
      }
      return(false);
   }
}
?>