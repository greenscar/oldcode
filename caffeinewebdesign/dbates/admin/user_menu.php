<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
   //echo("date = " . date("w"));
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Root.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $admin = new Admin();
	$title = "Select the User you wish to edit or Create New";
	include("html_header.inc");
?>
<body>
   <table class="mod_screen">
      <tr>
         <th colspan="5" class="menu">User Index</th>
      </tr>
      <tr>
         <td align="center" width="10%"><h3>ID</h3></td>
         <td align="center" width="35%"><h3>Name</h3></td>
         <td align="center" width="35%"><h3>Contact</h3></td>
	 <td align="center" width="10%"><h3>Active</h3></td>
         <td align="center" width="10%"><h3>Type</h3></td>
      </tr>
      <?php
         $userArray = $admin->dbLoadUserList($dbmgr);
         //echo("size = " . sizeof($userArray) . "<BR>");
         foreach($userArray as $id => $user)
         //for($i=0; $i < sizeof($clientArray); $i++)
         {
            echo("\t<tr>\n");
            echo("\t\t<td>\n");
            echo("\t\t\t<a href=\"user_edit.php?id=" . $user->id . "\" class=\"menu\">");
            echo(htmlentities($user->user_name));
            echo("</a>\n");
            echo("\t\t</td>\n");
            echo("\t\t<td>\n");
            echo("\t\t\t<a href=\"user_edit.php?id=" . $user->id . "\" class=\"menu\">");
            echo(htmlentities($user->name));
            echo("</a>\n");
            echo("\t\t</td>\n");
            echo("\t\t<td>\n");
            echo("\t\t\t<a href=\"user_edit.php?id=" . $user->id . "\" class=\"menu\">");
            echo(htmlentities($user->contact));
            echo("</a>\n");
            echo("\t\t</td>\n");
            echo("\t\t<td>\n");
            echo("\t\t\t<a href=\"user_edit.php?id=" . $user->id . "\" class=\"menu\">");
            echo(htmlentities($user->isActive()));
            echo("</a>\n");
            echo("\t\t</td>\n");
            echo("\t\t<td>\n");
            echo("\t\t\t<a href=\"user_edit.php?id=" . $user->id . "\" class=\"menu\">");
            echo(htmlentities($user->getUserType()));
            echo("</a>\n");
            echo("\t\t</td>\n");
            echo("\t</tr>\n");
         }
      ?>
		<tr>
			<td colspan="5" align="center">
				<input type="Submit" class="submitButton" name="Create New" value="Create New" onClick="location.href=('user_create.php');" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
				<input type="Button" class="submitButton" name="Main Menu"  value="Main Menu"  onClick="location.href=('index.php');" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
			</td>
		</tr>
   </table>
</body>
</html>