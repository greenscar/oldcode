<?
include("header.inc");
commonHeader("$Company","Add A Picture");

blueFont("Arial","Select the product, and then SUBMIT!<br><br>");
echo "<TABLE BORDER=\"0\" CELLPADDING=\"10\" CELLSPACING=\"10\"><TR>";
echo "<FORM ACTION=\"./upload.php\" METHOD=\"GET\">";

echo "<tr><td>";
blueFont("Arial","Select An Item<br>");
echo "<select name=\"II\" size=\"1\">";
mysql_connect("$DBHost","$DBUser","$DBPass");

$result=mysql("$DBName","SELECT ItemID,ItemName,ItemSKU FROM Items ORDER BY ItemName");
while ($row = mysql_fetch_row($result)) {
echo "<option value='$row[0]'> $row[1] - $row[2] </option>";
}
echo "</select></td></tr>";
echo "<tr><td align=\"center\"><INPUT TYPE=\"submit\" NAME=\"Submit\" VALUE=\"Submit\"></form></TABLE>";

adminFooter($Relative);
?>
