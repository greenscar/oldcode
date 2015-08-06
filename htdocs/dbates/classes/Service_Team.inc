<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Service_Member.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
class Service_Team
{
   var $log;
   var $member_array;
   
   function Service_Team()
   {
      $this->log = new Secretary();
      $this->member_array = Array();
   }
   function get_size()
   {
      return sizeof($this->member_array);
   }
   function get_member($array_loc)
   {
      return $this->member_array[$array_loc];
   }
   
   function addMember($dbmgr, $empid, $title, $type)
   {
      $sm = new Service_Member();
      $sm->rep = new Rep();
      $sm->rep->id = $empid;
      $sm->rep->dbLoad($dbmgr);
      $sm->title = $title;
      $sm->type = $type;

      array_push($this->member_array, $sm);

   }
   function getServiceMemberViaId($id)
   {


      for($i=0; $i<sizeof($this->member_array);$i++)
      {

         if(strcmp($member_array[$i]->rep->id, $id) == 0)
         {

            return($member_array[$i]);
         }
      }
      $this->log->write("return false");
      return(false);
   }
   function repIsOnServiceTeam($empid)
   {

      for($i = 0; $i < sizeof($this->member_array); $i++)
      {
         $aRep = $this->member_array[$i]->rep;
         if(strcmp($aRep->id, $empid) == 0)
            return(true);
      }
      return(false);
   }
   
   function createServiceMember($dbmgr, $empid, $title, $acct_type)
   {
      $this->addServiceMember($dbmgr, $empid, $title, $acct_type);
      $lastSM = sizeof($this->member_array);
      if($this->member_array[$lastSM - 1]->dbInsert($dbmgr, $this->client->id))
      {
         return(true);
      }
      return(false);
   }
   function dbDeleteServiceMember($dbmgr, $rep_id, $client_id)
   {

      $sm = new Service_Member();
      $sm->rep->id = $rep_id;
      return $sm->dbDelete($dbmgr, $client_id);
   }
   function dbLoad($dbmgr, $client_id)
   {
      $this->log->write("Service_Team->dbLoadServiceTeam(dbmgr)");
      // LOAD SERVICE TEAM LEADERS
      $sel = "SELECT REP_ID, TITLE, TYPE FROM CP_SERVICE_TEAM WHERE USER_ID = " . $client_id;
      $this->log->write($sel);
      if(!($dbmgr->query($sel)))
      {
         return(false);
      }
      while($row = $dbmgr->fetch_array())
      {
         $sm = new Service_Member();
         $rep = new Rep();
         $rep->id = $row["REP_ID"];
	 $this->log->write("rep id = " . $rep->id);
         $sm->rep = $rep;
         $sm->title = $row["TITLE"];
         $sm->type = $row["TYPE"];

         array_push($this->member_array, $sm);
      }
      foreach($this->member_array as $id=>$sm)
      {
	$sm->rep->dbLoad($dbmgr);
      }
      // END LOAD SERVICE TEAM LEADERS

   }
   
}
?>