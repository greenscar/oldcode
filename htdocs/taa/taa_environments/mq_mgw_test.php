<html>
<head><title>TIERS Related Tables</title>
<STYLE TYPE="text/css">
      H1 { color: blue }
      tr{
         border: 0px;
         margin: 0px;
         padding: 0px;
      }
      tr.1 {background-color:#CCCCCC;}
      tr.0 {background-color:#FFFFFF;}
      table{
         border:2px solid #000000;
      }
      th{
         border-left:1px solid #000000;
         border-right:1px solid #000000;
         border-bottom:2px solid #000000;
         font-weight: bold; 
         color: #FFFFFF;
         background-color: #000000;
         padding: 0px 3px 0px 3px;
         font-size: 12pt;
         line-height: 14pt; 
         font-family: arial, times, helvetica; 
      }
      a{ 
         color: #FFFFFF;
         background-color: #000000;
         text-decoration:none;
      }
      a:hover
      {
         color: #0088FF;
         background-color: #000000;
         text-decoration:none;
      }
      td.data {
         font-weight: normal; 
         font-size: 12pt;
         line-height: 14pt; 
         font-family: arial, times, helvetica; 
         font-variant: normal;
         font-style: normal;
         padding: 2px;/*5px, 5px, 5px, 5px;*/
         border: 0px;
         margin: 0px;
         text-align:center;  
         border-left:1px solid #000000;
         border-right:1px solid #000000;
      }
    </STYLE>

</head>
<body align="center">
<?php
  $conn = oci_connect("ZORO", "ZERO", "dte2");
  if (!$conn) {
   $e = oci_error();
   echo htmlentities($e['message']);
   exit;
  }
   


  //$envs_to_display = array(620, 621,610, 605,640, 218, 219,630,680,651, 8010, 8020,650);
  $strSQL = "select ENV_ID, OWNER_ACCOUNT, HOST_STRING, SERVER_NAME, Q_MANAGER, PORT, GATEWAY_CHANNEL, APPINST, IPADDRESS, UMODE FROM v_app_mq_security order by ";
  //$strSQL = "select unique ENV_ID, Q_MANAGER FROM v_app_mq_security order by ";
         if(isset($_GET["cn"]))
         {
            $cn = $_GET["cn"];
         }
         else
            $strSQL .= "ENV_ID";
  $stmt = oci_parse($conn, $strSQL);
  if (!$stmt) {
     $e = oci_error($conn);
     echo htmlentities($e['message']);
     exit;
  }
  $result = oci_execute($stmt);
  if (!$result) {
     $e = oci_error($stid);
     echo htmlentities($e['message']);
     exit;
  }
  $ncols = oci_num_fields($stmt);
  echo("<h1 align=\"center\">MQS</h1>");
  echo("<h5>$strSQL</h5>");
  echo "<table border=\"0\" align=\"center\" cellpadding=0 cellspacing=0>";
  echo "<tr>";
  for ($i = 1; $i <= $ncols; $i++) {
      $column_name  = oci_field_name($stmt, $i);
      echo "<th><a href=\"" . $_SERVER["PHP_SELF"] . "?cn=$column_name\">$column_name</a></th>";
  }
  echo("</tr>\n");
  
  $row_num = 0;
  while ($row = oci_fetch_array($stmt, OCI_RETURN_NULLS)) {
     echo("<tr class=\"" . (($row_num++) % 2) .  "\">");
     echo "<td class=\"data\">". $row["ENV_ID"] ."</td>";
     echo "<td class=\"data\">". $row["OWNER_ACCOUNT"] ."</td>";
     echo "<td class=\"data\">". $row["HOST_STRING"] ."</td>";
     echo "<td class=\"data\">". $row["SERVER_NAME"] ."</td>";
     echo "<td class=\"data\">". $row["Q_MANAGER"] ."</td>";
     echo "<td class=\"data\">". $row["PORT"] ."</td>";
     echo "<td class=\"data\">". $row["GATEWAY_CHANNEL"] ."</td>";
     echo "<td class=\"data\">". $row["APPINST"] ."</td>";
     echo "<td class=\"data\">". $row["IPADDRESS"] ."</td>";
     echo "<td class=\"data\">". $row["UMODE"] ."</td>";
     echo "</tr>\n";
  }
  echo "</table>\n";
  oci_free_statement($stmt); 
?> 
  
<?php
  oci_close($conn);
?>
</body>
