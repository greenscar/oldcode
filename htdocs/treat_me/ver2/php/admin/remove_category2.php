<?
include("header.inc");
commonHeader("$Company","Remove A Category");

blueFont("Arial","Select the category you wish to remove, and then SUBMIT!<br><br>");
echo "<TABLE BORDER=\"0\" CELLPADDING=\"10\" CELLSPACING=\"10\">";

echo "<tr><td>";
mysql_connect("$DBHost","$DBUser","$DBPass");
$result=mysql("$DBName","SELECT * FROM Category WHERE CategoryID='$Category'");
while ($row = mysql_fetch_row($result)) {
$CCa=$row[0];
$CCI=$row[1];
}
blueFont("Arial","<h2>Are you sure you want to remove </h2>");
redFont("Arial","<h2>$CCa</h2>");
?>

<form action="removeCategoryResponse.php" method="post">
<input type="hidden" name="CategoryID" value="<? echo $CCI; ?>">
<input type="submit" value="YES"></form><p>

<form action="$Relative/admin/" method="post">
<input type="submit" value="NO"></form><p>

<?
echo "</td></tr></table>";

adminFooter($Relative);
?>
