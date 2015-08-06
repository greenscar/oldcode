<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Specialty.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Department.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Rep.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/File.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Form.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Custom_Page.inc");
class Admin extends User
{
   function Admin()
   {
      User::User();
      $this->sec_lvl_id = 2;
      $this->sec_lvl_name = "ADMIN";
   }
   function getUserType()
   {
      return $this->sec_lvl_name;
   }
   function dbLoad($dbmgr)
   {
      $this->log->write("Admin->dbLoad(dbmgr)");
      $sel = "SELECT USER_NAME, PASSWORD, NAME, EMAIL, PHONE, ACTIVE "
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
      $this->email = $row[3];
      $this->phone = $row[4];
      $this->active = $row[5];
      return(true);
   }
   function dbInsert($dbmgr)
   {
      $ins = "INSERT INTO USER "
           . "(USER_NAME, PASSWORD, NAME, PHONE, EMAIL, ACTIVE, SEC_LVL_ID)"
           . " VALUES "
           . "('"
           . $this->user_name . "', '"
           . $this->encryptPassword($this->password) . "', '"
           . $this->name . "', '"
           . $this->phone . "', '"
           . $this->email . "', '"
           . $this->active . "', '"
           . $this->sec_lvl_id . "');";
      //return($ins);
      //return $dbmgr->query($ins) or mysql_error();
      if(!($dbmgr->query($ins)))
         return("ERROR in $ins<BR>");
      $this->id = $dbmgr->get_last_key();
      return $this->id;
   }
   
   function dbUpdate($dbmgr)
   {
      $this->log->write("Client->dbUpdate(dbmgr)");
      if(empty($this->id)) return false;
      $upd = "UPDATE USER SET "
           . " USER_NAME = '" . $this->user_name;
      //if(strcmp($this->password, "password") == 0)
      if($this->password != '')
           $upd .= "', PASSWORD = '" . $this->password;
      $upd .="', NAME = '" . $this->name
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
      return $this->id;
   }
   
   function dbLoadBFCPList($dbmgr)
   {
//.*write(.*$.*);
      $pages[] = Array();
      $sel = "SELECT C.USER_ID, C.NAME, I.ACTIVE "
           . "FROM USER C, BFCP_INDEX I "
           . "WHERE C.USER_ID = I.USER_ID";
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      for($num = 0; $row = $dbmgr->fetch_row(); $num++)
      {
         //$custPage = new Batch_File_Custom_Page();
         $custPage = new BFCP();
         $custPage->client->id = $row[0];
         $custPage->client->name = $row[1];
         $custPage->active = $row[2];
         $pages[$num] = $custPage;
      }
//.*write(.*$.*);
      if($num == 0) return null;
      else return($pages);
      
   }
   function dbLoadCustomPageList($dbmgr)
   {
//.*write(.*$.*);
      $pages[] = Array();
      $num = 0;
      $sel = "SELECT I.USER_ID, I.LOGO, "
           . " C.NAME, I.ACTIVE"
           . " FROM CP_INDEX I, USER C"
           . " WHERE I.USER_ID = C.USER_ID"
           . " AND C.ACTIVE = '1'";
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      while($row = $dbmgr->fetch_row())
      {
         $custPage = new Custom_Page();
         $custPage->client->id = $row[0];
         $custPage->logo = $row[1];
         $custPage->client->name = $row[2];
         $custPage->active = $row[3];
         array_push($pages, $custPage);
         $num++;
      }
//.*write(.*$.*);
      if($num == 0) return null;
      else return($pages);
      
   }
   function dbLoadDepts($dbmgr)
   {
      $deptArray[] = Array();
      $sel = "SELECT DEPT_ID, NAME, IS_INSURANCE, ACTIVE FROM DEPT_DEF";
      if(!($dbmgr->query($sel)))
         return("ERROR in $sel<BR>");
      for($i=0; $row = $dbmgr->fetch_row(); $i++)
      {
         $dept = new Department();
         $dept->id = $row[0];
         $dept->name = $row[1];
         $dept->insurance = $row[2];
         $dept->active = $row[3];
         $deptArray[$i] = $dept;
      }
      if($i == 0) return null;
      else return($deptArray);
   }
   
   function dbLoadInsuranceDepts($dbmgr)
   {
      $deptArray[] = Array();
      $sel = "SELECT DEPT_ID, NAME FROM DEPT_DEF WHERE IS_INSURANCE = '1'";
      if(!($dbmgr->query($sel)))
         return("ERROR in $sel<BR>");
      for($i=0; $row = $dbmgr->fetch_row(); $i++)
      {
         $dept = new Department();
         $dept->id = $row[0];
         $dept->name = $row[1];
         $deptArray[$i] = $dept;
      }
      if($i == 0) return null;
      else return $deptArray;
   }
   
   function dbLoadInsuranceDeptsActive($dbmgr)
   {
      $deptArray[] = Array();
      $sel = "SELECT DEPT_ID, NAME FROM DEPT_DEF WHERE IS_INSURANCE = '1' AND ACTIVE = '1'";
      if(!($dbmgr->query($sel)))
         return("ERROR in $sel<BR>");
      for($i=0; $row = $dbmgr->fetch_row(); $i++)
      {
         $dept = new Department();
         $dept->id = $row[0];
         $dept->name = $row[1];
         $deptArray[$i] = $dept;
      }
      if($i == 0) return null;
      else return $deptArray;
   }
   function dbLoadSpecialties($dbmgr)
   {
      $this->log->write("Admin.dbLoadSpecialties(dbmgr)");
      $spclArray[] = Array();
      $sel = "SELECT SPECIALTY_ID, NAME, ACTIVE FROM SPECIALTY_DEF";
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
//.*write(.*$.*);
      }
      for($i=0; $row = $dbmgr->fetch_row(); $i++)
      {
         $spcl = new Specialty();
         $spcl->id = $row[0];
         $spcl->name = $row[1];
         $spcl->active = $row[2];
         $spclArray[$i] = $spcl;
      }
//.*write(.*$.*);
      if($i == 0) return null;
      else return $spclArray;
   }
   function dbLoadLinkList($dbmgr)
   {
      $this->log->write("Admin->dbLoadLinkList(dbmgr)");
      $linkArray[] = Array();
      $sel = "SELECT LINK_ID, TITLE FROM LINK";
      if(!($dbmgr->query($sel)))
         return("ERROR in $sel<BR>");
      for($i=0; $row = $dbmgr->fetch_row(); $i++)
      {
         $link = new Link();
         $link->id = $row[0];
         $link->title = $row[1];
//.*write(.*$.*);
         $linkArray[$i] = $link;
      }
      if(empty($linkArray))
      {
         $this->log->write("Admin->dbLoadLinkList(dbmgr) => NULL");
         return null;
      }
      else
      {
//.*write(.*$.*);
         return $linkArray;
      }
   }
   
   function dbLoadFAQList($dbmgr)
   {
      $this->log->write("Admin->dbLoadFAQList(dbmgr)");
      $faqArray[] = Array();
      $sel = "SELECT FAQ_ID, QUESTION FROM FAQ";
      if(!($dbmgr->query($sel)))
         return("ERROR in $sel<BR>");
      for($i=0; $row = $dbmgr->fetch_row(); $i++)
      {
         $faq = new FAQ();
         $faq->id = $row[0];
         $faq->question = $row[1];
//.*write(.*$.*);
         $faqArray[$i] = $faq;
      }
      if(empty($faqArray))
      {
         $this->log->write("Admin->dbLoadFAQList(dbmgr) => NULL");
         return null;
      }
      else
      {
//.*write(.*$.*);
         return $faqArray;
      }
   }
   function dbLoadNewsList($dbmgr)
   {
      $newsArray[] = Array();
      $sel = "SELECT NEWS_ID, TITLE FROM NEWS WHERE NEVER_EXPIRE = '1' OR EXPIRE_DATE > " . time();
//.*write(.*$.*);
      $i = 0;
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      for($i=0; $row = $dbmgr->fetch_row(); $i++)
      {
         $news = new News();
         $news->id = $row[0];
         $news->name = $row[1];
         array_push($newsArray, $news);
      }
      if($i == 0) return null;
      else return $newsArray;
   }
   
   function dbLoadFormList($dbmgr)
   {
      $this->log->write("Admin->dbLoadFormList(dbmgr)");
      $formArray[] = Array();
      $sel = "SELECT FORM_ID, DESCRIPTION, TITLE, FILE_NAME FROM FORM";
      if(!($dbmgr->query($sel)))
         return("ERROR in $sel<BR>");
      for($i=0; $row = $dbmgr->fetch_row(); $i++)
      {
         $form = new Form();
         $form->id = $row[0];
         $form->description = $row[1];
         $form->title = $row[2];
         $form->file_name = $row[3];
         $formArray[$i] = $form;
         //echo("adding " . $form->title);
      }
      if($i == 0) return null;
      else return $formArray;
   }
   function dbLoadFileList($dbmgr)
   {
      $fileArray[] = Array();
      $sel = "SELECT FILE_ID, FILE_NAME, TITLE FROM FILE";
      if(!($dbmgr->query($sel)))
         return("ERROR in $sel<BR>");
      for($i=0; $row = $dbmgr->fetch_row(); $i++)
      {
         $file = new File();
         $file->id = $row[0];
         $file->file_name = $row[1];
         $file->title = $row[2];
         $fileArray[$i] = $file;
      }
      if($i == 0) return null;
      else return $fileArray;
   }
   function dbLoadEmpListBrief($dbmgr)
   {
      $repArray[] = Array();
      $sel = "SELECT REP_ID, FIRST_NAME, LAST_NAME FROM REP ORDER BY LAST_NAME";
      if(!($dbmgr->query($sel)))
         return("Error in $sel<BR>");
      for($i=0; $row = $dbmgr->fetch_row(); $i++)
      {
         $rep = new Rep();
         $rep->id = $row[0];
         $rep->first_name = $row[1];
         $rep->last_name = $row[2];
         $repArray[$i] = $rep;
      }
      if($i == 0) return null;
      else return $repArray;
   }
   function dbLoadRepListBrief($dbmgr)
   {
      $this->log->write("Admin->dbLoadRepListBrief(dbmgr)");
      $repArray[] = Array();
		$i = 0;
      $sel = "SELECT R.REP_ID, R.FIRST_NAME, R.LAST_NAME, DD.NAME"
           . " FROM REP R, DEPT_DEF DD"
           . " WHERE R.DEPT_ID = DD.DEPT_ID"
           . " AND DD.IS_INSURANCE = '1'"
           . " ORDER BY R.LAST_NAME";
	   $this->log->write($sel);
      //return $sel;
      if($dbmgr->query($sel))
		{
			for($i=0; $row = $dbmgr->fetch_row(); $i++)
			{
				$rep = new Rep();
				$rep->id = $row[0];
				$rep->first_name = $row[1];
				$rep->last_name = $row[2];
				$repArray[$i] = $rep;
			}
		}
      if($i == 0) return null;
      else return $repArray;
   }
   function dbLoadUserList($dbmgr)
   {
      $this->log->write("Admin.dbLoadUserListBriefAll(dbmgr)");
      $clientArray[] = Array();
      $sel = "SELECT usl.SEC_LVL_NAME, u.SEC_LVL_ID, u.USER_ID, u.USER_NAME, u.NAME, u.CONTACT, u.ACTIVE"
           . " FROM USER u, USER_SEC_LVL usl"
           . " WHERE u.SEC_LVL_ID = usl.SEC_LVL_ID"
           . " AND u.user_id > 0"
           . " AND u.user_id != 14";
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
         return("Error in $sel");
      array_pop(&$clientArray);
      for($i=0; $row = $dbmgr->fetch_row(); $i++)
      {
         $aUser = null;
         $sec_lvl_name = $row[0];
//.*write(.*$.*);
         if(strcmp($sec_lvl_name, "ADMIN") == 0)
         {
            $aUser = new Admin();
         }
         else if(strcmp($sec_lvl_name, "ROOT") == 0)
         {
            $aUser = new Root();
         }
         else if(strcmp($sec_lvl_name, "CLIENT") == 0)
         {
            $aUser = new Client();
         }
         else
         {
            $this->log->write("UNDEFINED");
         }
         $aUser->sec_lvl_name = $row[0];
         $aUser->sec_lvl_id = $row[1];
         $aUser->id = $row[2];
         $aUser->user_name = $row[3];
         $aUser->name = $row[4];
         $aUser->contact = $row[5];
         $aUser->active = $row[6];
//.*write(.*$.*);
         //$aUser->logValues();
         if($aUser != null)
            array_push($clientArray, $aUser);
      }
//.*write(.*$.*);
      if(sizeof($clientArray) == 0) return null;
      else return $clientArray;
   }
   function dbLoadClientListActiveBriefAll($dbmgr)
   {
      $this->log->write("Admin.dbLoadClientBrief(dbmgr)");
      $clientArray[] = Array();
      $sel = "SELECT USER_ID, NAME, CONTACT, ACTIVE FROM USER WHERE ACTIVE = '1' AND SEC_LVL_ID = '1'";
      if(!($dbmgr->query($sel)))
         return("Error in $sel");
      for($i=0; $row = $dbmgr->fetch_row(); $i++)
      {
         $client = new Client();
         $client->id = $row[0];
         $client->name = $row[1];
//.*write(.*$.*);
         $client->contact = $row[2];
         $client->active = $row[3];
         $clientArray[$i] = $client;
      }
//.*write(.*$.*);
      if($i == 0) return null;
      else return $clientArray;
   }
   function dbLoadClientListActiveWithoutBatchPages($dbmgr)
   {
      $this->log->write("Admin.dbLoadClientListWithoutBatchPages(dbmgr)");
      $allClients = $this->dbLoadClientListActiveBriefAll($dbmgr);
      $sel = "SELECT USER_ID FROM BFCP_INDEX CP";
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return("Error in $sel");
      }
      while($row = $dbmgr->fetch_row())
      {
         foreach($allClients as $key=>$client)
            if($client->id == $row[0]) unset($allClients[$key]);
      }
//.*write(.*$.*);
      $finalList[] = Array();
      $flLoc = 0;
      foreach($allClients as $key=>$client)
      {
//.*write(.*$.*);
         $finalList[$flLoc++] = $allClients[$key];
      }
      if($flLoc == 0) return null;
      else return($finalList);
   }
   function dbLoadClientListActiveWithoutPages($dbmgr)
   {
      $this->log->write("Admin.dbLoadClientListWithoutPages(dbmgr)");
      $allClients = $this->dbLoadClientListActiveBriefAll($dbmgr);
      $sel = "SELECT c.USER_ID, cp.ACTIVE FROM USER c, CP_INDEX cp WHERE c.USER_ID = cp.USER_ID";
      if(!($dbmgr->query($sel)))
         return("Error in $sel");
      while($row = $dbmgr->fetch_row())
      {
         foreach($allClients as $key=>$client)
            if($client->id == $row[0]) unset($allClients[$key]);
      }
      $finalList[] = Array();
      $flLoc = 0;
      foreach($allClients as $key=>$client)
      {
         $finalList[$flLoc++] = $allClients[$key];
      }
//.*write(.*$.*);
      if($flLoc == 0) return null;
      else return($finalList);
   }
   function dbLoadClientIdsWithPages($dbmgr)
   {
      $clientArray[] = Array();
      $sel = "SELECT c.USER_ID FROM USER c, CP_INDEX cp WHERE c.USER_ID = cp.USER_ID";
      if(!($dbmgr->query($sel)))
         return("Error in $sel");
      for($i=0; $row = $dbmgr->fetch_row(); $i++)
      {
         $clientArray[$i] = $row[0];
      }
      if($i == 0) return null;
      else return $clientArray;
   }
   function getLinkFromList($linkNum)
   {
      return sizeof($this->linkArray);
      for($i=0; $i < sizeof($this->linkArray); $i++)
      {
         if($this->linkArray[$i]->id == $linkNum)
         {
            return $this->linkArray[$i];
         }
      }
      return false;
   }
   
   function br2nl( $data ) {
      return preg_replace( '!<br.*>!iU', "\n", $data );
   }
}
?>