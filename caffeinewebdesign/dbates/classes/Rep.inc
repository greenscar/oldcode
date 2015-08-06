<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Department.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Specialty.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
class Rep
{
   var $id;
   var $first_name;
   var $last_name;
   var $phone;
   var $fax;
   var $email;
   var $active;
   var $dept;
   var $specialties;
   var $role_1;
   var $role_2;
   var $role_3;
   var $vcard;
   var $log;
   function logValues()
   {
      $this->log->write("Rep->logValues()");
      $toLog = "----Rep----\n"
                       ."id=" . $this->id . "\n"
                       ."first_name=" . $this->first_name . "\n"
                       ."last_name=" . $this->last_name . "\n"
                       ."phone=" . $this->phone . "\n"
                       ."fax=" . $this->fax . "\n"
                       ."email=" . $this->email . "\n"
                       ."active=" . $this->active . "\n"
                       ."dept=" . $this->dept->name . "\n"
                       ."role_1=" . $this->role_1 . "\n"
                       ."role_2=" . $this->role_2 . "\n"
                       ."role_3=" . $this->role_3 . "\n";
      foreach($this->specialties AS $key=>$val)
      {
         $toLog .= "specialty \n" . $val->logValues();
         //$toLog .= "specialty $key = " . $val->id . " \n";
      }
      $toLog .= "---------------\n";
//.*write(.*$.*); 
   }
   function Rep(){
      $this->dept = new Department();
      $spec = new Specialty();
      $spec->name = "None";
      $spec->id = 1;
      $this->specialties = Array();
      array_push($this->specialties, $spec);
      $this->log = new Secretary();
   }
   
   // REQUIRE id SET BEFORE CALLING THIS FUNCTION.
   function dbLoad($dbmgr)
   {
      $this->log->write("Rep->dbLoad(dbmgr)");
      if(empty($this->id)) return false;
      $sel = "SELECT FIRST_NAME, LAST_NAME, EMAIL, FAX, PHONE, DEPT_ID, ACTIVE"
           . " FROM REP WHERE REP_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      $row = $dbmgr->fetch_array();
      $this->first_name = $row["FIRST_NAME"];
      $this->last_name = $row["LAST_NAME"];
      $this->email = $row["EMAIL"];
      $this->fax = $row["FAX"];
      $this->phone = $row["PHONE"];
      $this->dept->id = $row["DEPT_ID"];
      $this->active = $row["ACTIVE"];
      //$this->logValues();
      
      // LOAD SPECIALTIES
      $sel2 = "SELECT SPECIALTY_ID FROM REP_SPECIALTY WHERE REP_ID = " . $this->id . " AND SPECIALTY_ID != 1";
      $this->log->write($sel2);
      if(!($dbmgr->query($sel2)))
      {
         return(false);
      }
      $this->log->write("COUNT = " . $dbmgr->get_num_rows());
      while($row = $dbmgr->fetch_array())
      {
	 $sp = new Specialty();
         $sp->id = $row["SPECIALTY_ID"];
         $this->log->write("------------------id = " . $sp->id);
         //$sp->dbLoad($dbmgr);
         array_push($this->specialties, $sp);
      }
      foreach($this->specialties as $id=>$spel)
      {
	 $spel->dbLoad($dbmgr);
      }
      $this->log->write("DONE");
      // LOAD DEPT
      $this->dept->dbLoad($dbmgr);
      
      // LOAD ROLES
      $sel = "SELECT ROLE_1, ROLE_2, ROLE_3 FROM REP_ROLE WHERE REP_ID = " . $this->id;
      if(!($dbmgr->query($sel)))
         return("ERROR in $sel<BR>");
      if($row = $dbmgr->fetch_row())
      {
         $this->role_1 = $row[0];
         $this->role_2 = $row[1];
         $this->role_3 = $row[2];
      }
      return($this->id);
   }
   
   function dbUpdate($dbmgr)
   {
      $this->log->write("Rep->dbUpdate(dbmgr)");
      if(empty($this->id)) return false;
      $upd = "UPDATE REP SET "
           . " FIRST_NAME = '" . $this->first_name
           . "', LAST_NAME = '" . $this->last_name
           . "', EMAIL = '" . $this->email
           . "', FAX = '" . $this->fax
           . "', PHONE = '" . $this->phone
           . "', DEPT_ID = " . $this->dept->id
           . ", ACTIVE = '" . $this->active
           . "' WHERE REP_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($upd)))
      {
//.*write(.*$.*);
         return(false);
      }
      // DELETE SPECIALTIES FROM DB
      $del = "DELETE FROM REP_SPECIALTY WHERE REP_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($del)))
      {
//.*write(.*$.*);
         return(false);
      }
      // INSERT NEW SPECIALTIES.
      if(sizeof($this->specialties) == 0)
      {
         // SET NONE AS SPECIALTY
         $s = new Specialty;
         $s->name="None";
         $s->id = 1;
         array_push($this->specialties, $s);
      }
      foreach($this->specialties AS $id=>$object)
      {
         $ins = "INSERT INTO REP_SPECIALTY (REP_ID, SPECIALTY_ID) VALUES (" . $this->id . ", " . $object->id . ")";
//.*write(.*$.*);
         if(!($dbmgr->query($ins)))
         {
//.*write(.*$.*);
            return(false);
         }
      }
      
      
      $count = "SELECT * FROM REP_ROLE WHERE REP_ID = " . $this->id;
      $dbmgr->query($count);
      $upd = "NOTHING";
      if($dbmgr->get_num_rows() == 0)
      {
         $upd = "INSERT INTO REP_ROLE (REP_ID, ROLE_1, ROLE_2, ROLE_3) VALUES("
            . $this->id . ", '"
            . $this->role_1 . "', '"
            . $this->role_2 . "', '"
            . $this->role_3 . "');";
      }
      else
      {
         $upd = "UPDATE REP_ROLE SET"
           . " ROLE_1 = '" . $this->role_1
           . "', ROLE_2 = '" . $this->role_2
           . "', ROLE_3 = '" . $this->role_3
           . "' WHERE REP_ID = " . $this->id;
      }
//.*write(.*$.*);
      //return $upd;
      if(!($dbmgr->query($upd)))
      {
//.*write(.*$.*);
         return(false);
      }
      $this->log->write("Rep->dbUpdate(dbmgr) => TRUE");
      return true;
   }
   function dbDelete($dbmgr)
   {
      $del = Array();
      $del[0] = "DELETE FROM CLIENT_REP WHERE REP_ID = " . $this->id;
      $del[1] = "DELETE FROM REP_SPECIALTY WHERE REP_ID = " . $this->id;
      $del[2] = "DELETE FROM REP_ROLE WHERE REP_ID = " . $this->id;
      $del[3] = "DELETE FROM REP WHERE REP_ID = " . $this->id;
      for($i=0; $i < 4; $i++)
      {
//.*write(.*$.*);
         if(!($dbmgr->query($del[$i])))
         {
//.*write(.*$.*);
            return(false);
         }
      }
      return(true);
   }
   function dbInsert($dbmgr)
   {
      $this->log->write("Rep->dbInsert(dbmgr)");
      $ins = "INSERT INTO REP "
           . "(FIRST_NAME, LAST_NAME, EMAIL, FAX, PHONE, DEPT_ID, ACTIVE) "
           . "VALUES "
           . "('"
           . $this->first_name . "', '"
           . $this->last_name . "', '"
           . $this->email . "', '"
           . $this->fax . "', '"
           . $this->phone . "', "
           . $this->dept->id . ", '"
           . $this->active . "');";
//.*write(.*$.*);
      if(!($dbmgr->query($ins)))
      {
//.*write(.*$.*);
         return(false);
      }
      
      $this->id = $dbmgr->get_last_key();
      // DELETE SPECIALTIES FROM DB
      $del = "DELETE FROM REP_SPECIALTY WHERE REP_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($del)))
      {
//.*write(.*$.*);
         return(false);
      }
      // INSERT NEW SPECIALTIES.
      foreach($this->specialties AS $id=>$object)
      {
         $ins = "INSERT INTO REP_SPECIALTY (REP_ID, SPECIALTY_ID) VALUES (" . $this->id . ", " . $object->id . ")";
//.*write(.*$.*);
         if(!($dbmgr->query($ins)))
         {
//.*write(.*$.*);
            return(false);
         }
      }
      
      $ins = "INSERT INTO REP_ROLE (REP_ID, ROLE_1, ROLE_2, ROLE_3) VALUES("
            . $this->id . ", '"
            . $this->role_1 . "', '"
            . $this->role_2 . "', '"
            . $this->role_3 . "');";
//.*write(.*$.*);
      if(!($dbmgr->query($ins)))
      {
//.*write(.*$.*);
         return(false);
      }
      $this->log->write("Rep->dbInsert(dbmgr) => TRUE");
      return true;
   }
   function addSpecialty($sid)
   {
//.*write(.*$.*);
      //$v = strcmp($this->specialties[0]->name, "None");
//.*write(.*$.*);
      if(sizeof($this->specialties) == 0)
      {
         $this->specialties = Array();
      }
      else if((sizeof($this->specialties) == 1) && (strcmp($this->specialties[0]->name, "None") == 0))
      {
         $this->specialties = Array();
      }
      if(!($this->hasSpecialty($sid)))
      {
         $aSpec = new Specialty();
         $aSpec->id = $sid;
         array_push($this->specialties, $aSpec);
      }
      return(sizeof($this->specialties));
   }
   function hasSpecialty($sid)
   {
      foreach($this->specialties AS $id=>$spec)
      {
         if($spec->id == $sid)
            return(true);
      }
      return(false);
   }
   function setDeptViaId($dbmgr, $id)
   {
//.*write(.*$.*);
      $this->dept->id = $id;
      $this->dept->dbLoad($dbmgr);
   }
   
   function setSpecialtyViaId($dbmgr, $id)
   {
//.*write(.*$.*);
      $this->specialty->id = $id;
      $this->specialty->dbLoad($dbmgr);
   }
   
   function getVcardPath()
   {
	   return ($_SERVER["DOCUMENT_ROOT"] . "/vcards/" . $this->first_name . "_" . $this->last_name . ".vcf");
   }
   function getVcardLink()
   {
      return ($_SERVER["SERVER_NAME"] . "/vcards/" . $this->first_name . "_" . $this->last_name . ".vcf");
   }
   function vCardExists()
   {
      if(file_exists($this->getVcardPath()))
		{
			return(true);
		}
		else
		{
			return(false);
		}
   }
   function get_full_name()
   {
      return $this->first_name . " " . $this->last_name;
   }
}
?>