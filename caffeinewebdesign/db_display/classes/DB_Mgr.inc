<?php
//require_once("http://www.e-sharis.net/includes/php_files/Rics_Settings.inc");
require_once("Settings.inc");
class DB_Mgr
{
	var $settings;
	var $rs;
	var $conn;
	var $db;
	function DB_Mgr($db)
	{
		$this->settings = new Settings();
		$this->connect($db);
	}
	
	function connect($db)
	{
		$this->db = $this->settings->db[$db];
		$this->conn = mysql_connect($this->settings->server[$db], $this->settings->id[$db], $this->settings->pwd[$db]);
	}
	
	function disconnect()
	{
		mysql_close($this->conn);
	}
	
	function get_conn()
	{
		return $this->conn;
	}
	
	function query($query)
	{
		$this->rs = mysql_query($query, $this->conn);
	}
	
	function fetch_row()
	{
		return mysql_fetch_row($this->rs);
	}
	
	function fetch_array()
	{
		return mysql_fetch_array($this->rs);
	}
	
	function get_field_value($num)
	{
		return mysql_fetch_field($this->rs, $num);
	}
	
	function get_num_rows()
	{
		return mysql_num_rows($this->rs);
	}
	
	function get_num_fields()
	{
		return mysql_num_fields($this->rs);
	}
	function get_field_name($field_num)
	{
		return mysql_field_name($this->rs, $field_num);
	}
	
	function set_table_list()
	{
		$this->rs = mysql_list_tables($this->db, $this->conn);
	}
}
?>