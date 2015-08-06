<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/admin/ensure_admin.inc");
if(!empty($_POST["oldPwd"]))
{
   //echo("password=".$admin->password."<BR>");
   //echo("oldPwd = " . $_POST["oldPwd"]."<BR>");
   if($admin->checkPassword($_POST["oldPwd"]))
   {
      if(!empty($_POST["newPassword"]))
      {
         $admin->setPassword($_POST["newPassword"]);
         // Process Password change
      }
      $admin->dbUpdate($dbmgr);
      $_SESSION["user"] = $admin;
      $_GET["ip"] = null;
      header("Location: ./index.php");
   }
   else
      header("Location: " . $_SERVER["PHP_SELF"] . "?ip=true");
}
else
{
   header("Cache-control: private");//IE 6 Fix
   ?>
   <html>
   <head>
      <title><?php echo($admin->name); ?></title>
      <script language="JavaScript" type="text/javascript" src="../form_check.js"></script>
      <script language="JavaScript" type="text/javascript">
         function validatePersonalInfo(form)
         {
            var oldPwd = eval("form.oldPwd");
            var newPwd = eval("form.newPassword");
            var newPwd2 = eval("form.newPassword2");
            //if(newPwd.value.length > 0) alert("newPwd = " + newPwd.value.length);
            //return(false);
            if(field_is_blank(form, "oldPwd", "Old Password"))
               return(false);
            if(field_is_blank(form, "newPassword", "New Password Twice"))
                return(false);
            if(field_is_blank(form, "newPassword2", "New Password Twice"))
                return(false);
            
            if((newPwd.value.length > 0) || (newPwd2.value.length > 0))
            {
               if(!check_password(form, "newPassword", "newPassword2"))
                  return(false);
            }
            return(true);
         }
      </script>
      <style type="text/css">@import "../template_client.css";</style>
   </head>
      <body>
         <form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validatePersonalInfo(this);">
         <!--<table class="body" border="1">-->
         <table class="mod_screen" style="height: 300px; width: 450px;">
            <tr>
               <td>
                  <table width="100%" border="0">
                     <tr>
                        <?php
                        if(isset($_GET["ip"]) && strcmp($_GET["ip"], "true") == 0)
                        {
                        ?>
                        <th style="text-align:left;color: red;" colspan="2">
                           The old password you entered was incorrect.<br> Please reenter your information.
                        </th>
                        <?php
                        }
                        ?>
                     <tr>
                        <th style="text-align:center" colspan="2">
                           <?php echo($admin->name); ?>, change your password
                        </th>
                     </tr>
                     <tr>
                        <td class="darkBlackSmall" style="text-align: left" width="40%">Old Password:</td>
                        <td>
                           <input class="name" type="password" name="oldPwd"></input>
                        </td>
                     </tr>
                     <tr>
                        <td class="darkBlackSmall" style="text-align: left">New Password:</td>
                        <td>
                           <input class="name" type="password" name="newPassword"></input>
                        </td>
                     </tr>
                     <tr>
                        <td class="darkBlackSmall" style="text-align: left">New Password (Again):</td>
                        <td>
                           <input class="name" type="password" name="newPassword2"></input>
                        </td>
                     </tr>
                  </table>
               </td>
            </tr>
            <tr>
               <td colspan="3" align="center">
                  <input onclick="location.href='./index.php'" class="submitButton" type="button" name="cancel" value="Cancel" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                  <input type="submit" class="submitButton" name="update" value="Process Update" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               </td>
            </tr>
         </table>
         </form>
      </body>
<?php
}
?>