<?php
class Settings
{
   //var $server = "PSTEST, 2433";
   var $server = "localhost";
   var $db = "environments";
   var $id = "envtinfo";
   var $pwd = "envtinfo";
   var $ora_server = "dte2";
   var $ora_id = "ZORO";
   var $ora_pwd = "ZERO";
   var $date_format = "Y-m-d H:i:s";
   //var $tiers_schemas = array(210, 218, 219, 220, 299, 240, 499, 611, 699, 630, 640, 650, 229, 230, 299, 499, 699, 199, 605, 610);
   var $app_list = array("TIERS", "SSP", "STP");
   var $app_schemas = array();
   var $doc_root;
   //var $tables = array("site" => "SI_SITE", "phone_line" =>"SI_PHONE_LINE", "phone_company"=>"SI_PHONE_CO", "phone_type"=>"SI_PHONE_TYPE", "amenity_type"=>"SI_AMENITY_TYPE", "amenity_list"=>"SI_AMENITY_LIST");
   
   function Settings()
   {
      $this->app_schemas = array(
            "TIERS" => array(199, 210, 218, 219, 220, 229, 230, 240, 299, 499, 605, 610, 611, 630, 640, 650, 699 ,700,8030,8010,8020,680),
            "SSP" => array('WSAS1SS','WSAS2SS','WSGNXSS','WS1APSS','WS2APSS','WSIPTSTSS','WSPFOST'),
            "STP" => array('WSAS1ST','WSAS2ST','WSGNXST','WS1APST','WS2APST','WSIPTSTST','WSPFOSS'),
            "MAXeIE" => array('MAXDEV1', 'MAXDEV2','MAXX','MAXQ','MAXQ4','MAXQ2','MAXQ3')
           );
      $this->doc_root = $_SERVER["DOCUMENT_ROOT"] . "/envts";
   }
   
   function is_whole_number($var){
      return (is_numeric($var)&&(intval($var)==floatval($var))&&($var>0));
   }

   function get_time()
   {
      return date($this->date_format, time());
   }
    
}
?>