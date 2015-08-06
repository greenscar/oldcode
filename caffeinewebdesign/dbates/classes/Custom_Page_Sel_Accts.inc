<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Rep.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Link.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Service_Team.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Coverage.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Form.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/FAQ.inc");

class Custom_Page_Sel_Accts extends Custom_Page
{
   function Custom_Page_Sel_Accts($dbmgr)
   {
      Custom_Page::Custom_Page();
      $this->client = new Client();
      $this->client->id = 14;
      $this->client->dbLoad($dbmgr);
   }
}   
?>