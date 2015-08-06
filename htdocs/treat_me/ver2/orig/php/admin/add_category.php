<?
include("header.inc");
commonHeader("$Company","Add A Category");

blueFont("Arial","Type your new category into the box, and then SUBMIT!<br><br>");

echo "<TABLE BORDER=\"0\" CELLPADDING=\"10\" CELLSPACING=\"10\"><tr>";
echo "<FORM ACTION=\"./add_category_response.php\" METHOD=\"POST\">";
echo "<tr><td>";
blueFont("Arial","Category");
echo "</td><td>";
echo "<input type=\"text\" name=\"category\" size=\"50\">";
echo "</td></tr>";
echo "<tr><td><INPUT TYPE=\"submit\" NAME=\"Submit\" VALUE=\"Submit\">";
echo "</td></tr></TABLE>";

adminFooter();
?>
