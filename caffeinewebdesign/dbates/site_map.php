
<?php
    $title = "SITE MAP";
    $image = "map.jpg";
    $bgcolor = "899E88";
    include("./page_header.inc");
?>
<table class="body">
    <tr>
        <td>
            <table width="461" align="center">
                <tr> 
                    <td width="170" style="vertical-align: top;"> DEPARTMENTS 
                        <ul style="font-size: 11px; margin-left: 30px">
                            <li><a href="./depts_marine.php">Marine</a></li>
                            <li><a href="./depts_commercial_lines.php">Commercial</a></li>
                            <li><a href="./depts_mgt_liability.php">Management Liability</a></li>
                            <li><a href="./depts_personal.php">Personal Risk</a></li>
                        </ul>
                    </td>
                    <td width="279" rowspan="3" style="vertical-align: top;"> INDUSTRY & PRODUCT SPECIALTIES 
                        <ul style="font-size: 11px; margin-left: 30px">
                            <li>Manufacturing</li>
                            <li><a href="./spec_construction.php">Construction</a></li>
                            <li><a href="./spec_life_sciences.php">Life Sciences</a></li>
                            <li><a href="./spec_construction.php">Construction</a></li>
                            <li><a href="./spec_technology.php">Technology</a></li>
                            <li><a href="./spec_food_processing.php">Food Processing</a></li>
                            <li><a href="./spec_workers_comp.php">Workers Compensation</a></li>
                            <li>Errors & Omissions</li>
                            <li><a href="./spec_environmental.php">Environmental & Pollution</a></li>
                            <li>Other Specialties</li>
                            <li><a href="./spec_directors.php">Directors & Officers</a></li>
                            <li>Wholesale Distribution</li>
                            <li><a href="./spec_employment_practices.php">Employment Practices Liability</a></li>
                        </ul>
                    </td>
                </tr>
                <tr> 
                    <td height="40" style="vertical-align: top;padding-top:20px;"> CONTACT US 
                        <ul style="font-size: 11px; margin-left: 30px;">
                            <li><a href="./directory.php">Associate Directory</a></li>
                            <li><a href="./map.php">Map & Directions</a></li>
                        </ul>
                        <br>
                    </td>
                </tr>
                <tr>
                    <td height="41" style="vertical-align: top;"> NEWS 
                        <ul style="font-size: 11px; margin-left: 30px">
                            <li><a href="./news.php">News &amp; Events</a></li>
                        </ul>
                    </td>
                </tr>
                <tr style="padding-top:30px;"> 
                    <td style="vertical-align: top;padding-top:20px;"> ABOUT D&amp;B 
                        <ul style="font-size: 11px; margin-left: 30px">
                            <li><a href="./history.php">History</a></li>
                            <li>Associations</li>
                            <li><a href="./giving.php">Charitable Giving</a></li>
                        </ul>
                    </td>
                    <td style="vertical-align: top;padding-top:20px;"> CLIENT ACCESS 
                        <ul style="font-size: 11px;  margin-left: 30px">
                            <li><a href="./login.php">Login</a></li>
                        </ul>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<?php include("./page_footer.inc"); ?>