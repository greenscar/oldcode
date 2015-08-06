<?php
require_once("ensure_client.inc");
if(isset($_GET["fid"]))
{
   // LOAD FORM
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Form.inc");
   $form = new Form();
   $form->id = $_GET["fid"];
   $form->dbLoad($dbmgr);
   // DISPLAY FORM TO BE COMPLETED
   ?>
<html>
<head>
      <title><?php echo($client->name); ?></title>
      <script language="JavaScript" type="text/javascript" src="../form_check.js"></script>
      <script language="JavaScript" type="text/javascript">
      </script>
      <style type="text/css">@import "../template_client.css";</style>
</head>
<body>
   <h2 align="center"><?php echo($form->title); ?></title>
   <form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" >
   
   <?php
   /**********************************************
    * INSERT FORM BODY FROM DATABASE HERE. 
    *********************************************/
   
   include($form->code);
   /**********************************************
    * END INSERT FORM BODY FROM DATABASE HERE. 
    *********************************************/
   ?>
   </form>
</body>
</html>
   <?
}
else
{
   // FORM NOT SELECTED. FORWARD TO CUSTOM PAGE.
   header("Location: https://" . $_SERVER["SERVER_NAME"] . "/client/custom_page.php");
}
?>