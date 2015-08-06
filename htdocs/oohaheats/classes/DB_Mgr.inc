<?php
require_once("Settings.inc");
class DB_Mgr
{
	var $settings;
	var $rs;
	var $conn;
	var $db;
	
	function DB_Mgr()
	{
		$this->settings = new Settings_oohaheats();
		$this->connect();
	}
	
	function connect()
	{
		$this->conn = mysql_connect($this->settings->server, $this->settings->id,$this->settings->pwd) or die("Can't connect: " . mysql_error());
		$this->db = mysql_select_db($this->settings->db, $this->conn);
	}
	
	function disconnect()
	{
		mysql_close($this->conn);
	}
	
	function query($query)
	{
		$this->rs = mysql_query($query, $this->conn) or die("ERROR in $query => " . mysql_error());
		return $this->rs;
	}
	
	function fetch_row()
	{
		return(mysql_fetch_row($this->rs));
	}
	
	function fetch_assoc_array()
	{
		return(mysql_fetch_assoc($this->rs));
	}
	function get_field($num)
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
		$this->rs = mysql_list_tables($this->settings->db, $this->conn);
	}
	function get_last_key()
	{
		return(mysql_insert_id(/*$this->conn*/));
	}
}
?>