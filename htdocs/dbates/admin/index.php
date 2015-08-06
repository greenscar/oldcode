<?php
    include("ensure_admin.inc");
?>
<?php
   $title = "Administrator Menu";
   include("html_header.inc");
?>
<body>
<table class="mod_screen">
<tr><th class="menu">Administrator Menu</th></td>
<tr><td><a href="link_menu.php" class="menu">Link Admin</a></td></tr>
<tr><td><a href="faq_menu.php" class="menu">FAQ Admin</a></td></tr>
<?php
if($security->user_is_root($admin))
{
?>
<tr><td><a href="specialty_menu.php" class="menu">Specialty Admin</a></td></tr>
<tr><td><a href="dept_menu.php" class="menu">Department Admin</a></td></tr>
<tr><td><a href="user_menu.php" class="menu">User Admin</a></td></tr>
<tr><td><a href="form_menu.php" class="menu">Form Admin</a></td></tr>
<?php
}
?>
<tr><td><a href="rep_menu.php" class="menu">Associate Admin</a></td></tr>
<tr><td><a href="file_menu.php" class="menu">File Admin</a></td></tr>
<tr><td><a href="news_menu.php" class="menu">News Admin</a></td></tr>
<tr><td><a href="cp_menu.php" class="menu">Custom Page Admin</a></td></tr>
<tr><td><a href="sa_edit.php" class="menu">Select Accounts Page Admin</a></td></tr>
<tr><td><a href="bf_cp_menu.php" class="menu">Batch File Custom Page Admin</a></td></tr>
<!--
<tr><td><a href="mass_image_menu.php" class="menu">Mass Image Accounts</a></td></tr>
<tr><td><a href="copy_table_data.php">Refresh Tables</a></td></tr>
<tr><td><a href="display_table_data.php" class="menu">Display Tables</a></td></tr>
-->
<tr><td><a href="pwd_change.php" class="menu">Change my Password</a></td></tr>
<tr><td><a href="logout.php" class="menu">Logout</a></td></tr>
</table>
</body>
</html>