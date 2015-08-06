<?php
class Document
{
   var $id;
   var $title;
   var $description;
   var $file_loc;
   var $public;
   var $copyright_source;
   var $author;
   var $post_date;
   var $expire_date;
   
   function Document(){}
   
   function dbInsert($dbmgr)
   {
      $ins = "INSERT INTO DOCUMENT (TITLE, DESCRIPTION, FILE_LOC, PUBLIC, SOURCE, AUTHOR, POST_DATE, EXPIRE_DATE)"
           . " VALUES("
           . "'" . $this->title . "', '"
           . "'" . $this->description . "', '"
           . "'" . $this->file_loc . "', '"
           . "'" . $this->public . "', '"
           . "'" . $this->source . "', '"
           . "'" . $this->author . "', '"
           . "'" . $this->post_date . "', '"
           . "'" . $this->expire_date . ");";
      if(!($dbmgr->query($ins)))
         return("ERROR in $sel<BR>");
      $this->id = $dbmgr->get_last_key();
      return $this->id;
   }
   function dbUpdate($dbmgr)
   {
      $upd = "UPDATE DOCUMENT SET"
           . " TITLE = '" . $this->title . "', "
           . " DESCRIPTION = '" . $this->description . "', "
           . " FILE_LOC = '" . $this->file_loc . "', "
           . " PUBLIC = " . $this->public . ", "
           . " SOURCE = '" . $this->source . "', "
           . " AUTHOR = '" . $this->author . "', "
           . " POST_DATE = " . $this->post_date . ", "
           . " EXPIRE_DATE = " . $this->expire_date . ", "
           . " WHERE DOC_ID = " . $this->id;
      if(!($dbmgr->query($upd)))
         return("ERROR in $sel<BR>");
      return $this->id;
   }
   function dbLoad($dbmgr)
   {
      $load = "LOAD * FROM DOCUMENT WHERE DOC_ID = " . $this->id;
      if(!($dbmgr->query($load)))
         return("ERROR in $load<BR>");
      $row = $dbmgr->fetch_row();
      $this->title = $row["TITLE"];
      $this->description = $row["DESCRIPTION"];
      $this->file_loc = $row["FILE_LOC"];
      $this->public = $row["PUBLIC"];
      $this->source = $row["SOURCE"];
      $this->author = $row["AUTHOR"];
      $this->post_date = $row["POST_DATE"];
      $this->expire_date = $row["EXPIRE_DATE"];
      return $this->id;
   }
}
?>
