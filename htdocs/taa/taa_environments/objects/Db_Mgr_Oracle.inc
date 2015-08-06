<?php
require_once("Settings.inc");
class Db_Mgr_Oracle
{
	var $settings;
	var $rs;
	var $conn;
   var $stmt;
	
	function Db_Mgr_Oracle()
	{
		$this->settings = new Settings();
		//$this->connect();
	}
	
	function connect()
	{
      $this->conn = oci_connect($this->settings->ora_id, $this->settings->ora_pwd, $this->settings->ora_server);
      if (!$this->conn) 
      {
         $e = oci_error();
         return $e['message'];
      }
	}
	
	function disconnect()
	{
		oci_close($this->conn);
	}
	
	function query($query)
	{  
      $this->stmt = oci_parse($this->conn, $query);
      $this->rs = oci_execute($this->stmt, OCI_DEFAULT);
      return $this->rs;
  
	}
   // Fetch an array of all results
   function fetch_all()
   {
      return(oci_fetch_all($this->stmt, $this->rs));
   }
	function fetch_row()
	{
      return(oci_fetch_array($this->rs));
	}
   function fetch_num_rows()
   {
      return(oci_num_rows($this->rs));
   }
	function fetch_assoc_array()
	{
		return(oci_fetch_assoc($this->stmt));
	}
	function get_num_fields()
	{
      return(oci_num_fields($this->stmt));
	}
	function get_field_name($field_num)
	{
		return(oci_field_name($this->stmt, $field_num));
	}
   /*
	function get_field($num)
	{
		return mysql_fetch_field($this->rs, $num);
	}
	
	function get_num_rows()
	{
		return mysql_num_rows($this->rs);
	}
	
	
	function set_table_list()
	{
		$this->rs = mysql_list_tables($this->settings->db, $this->conn);
	}
   */
}
?>