<?
include("header.inc");
commonHeader("$Company","Remove A Category");

blueFont("Arial","Select the category you wish to remove, and then SUBMIT!<br><br>");
echo "<TABLE BORDER=\"0\" CELLPADDING=\"10\" CELLSPACING=\"10\"><TR>";
echo "<FORM ACTION=\"./removeCategory2.php\" METHOD=\"POST\">";

echo "<tr><td>";
blueFont("Arial","Select A Category<br>");
echo "<select name=\"Category\" size=\"1\">";
mysql_connect("$DBHost","$DBUser","$DBPass");
$result=mysql("$DBName","SELECT * FROM Category ORDER BY Category");
while ($row = mysql_fetch_row($result)) {
echo "<option value=\"$row[1]\"> $row[0] </option>";
}
echo "</select></td></tr>";

echo "<tr><td><INPUT TYPE=\"submit\" NAME=\"Submit\" VALUE=\"Submit\"></form></TABLE>";

adminFooter($Relative);
?>
