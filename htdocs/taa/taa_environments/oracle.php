<?php
//$x = oci_connect("ZORO", "ZERO", "dte2");
//if($x == null) echo("ERROR");
//else echo("oci_connect = $x");
?>
<?php
//if ($c=OCILogon("ZORO", "ZERO", "dte2")) {
//  echo "Successfully connected to Oracle.\n";
//  OCILogoff($c);
//} else {
//  $err = OCIError();
//  echo "Oracle Connect Error " . $err[text];
//}
?>
<?php
//if ($c=ora_logon("ZORO@dte2","ZERO")) {
//  echo "Successfully connected to Oracle.\n";
//  ora_commitoff($c);
//  ora_logoff($c);
//} else {
//  echo "Oracle Connect Error " . ora_error();
//}
?>

<?php
  $conn = oci_connect("ZORO", "ZERO", "dte2");
  if (!$conn) {
   $e = oci_error();
   echo htmlentities($e['message']);
   exit;
  }

  $query = "SELECT BUILD_TIME, RELEASE, ENV_ID, CODESTREAM FROM APP_BUILDS";

  $stid = oci_parse($conn, $query);
  if (!$stid) {
   $e = oci_error($conn);
   echo htmlentities($e['message']);
   exit;
  }

  $r = oci_execute($stid, OCI_DEFAULT);
  if (!$r) {
   $e = oci_error($stid);
   echo htmlentities($e['message']);
   exit;
  }

  echo '<table border="1">';
  echo("<tr><th>Build Time</th><th>Release</th><th>DB</th><th>Codestream</th></tr>");
  while ($row = oci_fetch_array($stid, OCI_RETURN_NULLS)) {
   echo '<tr>';
       foreach ($row as $item) {
         echo '<td>'.($item?htmlentities($item):'&nbsp;').'</td>';
       }
       echo '</tr>';
  }
  echo '</table>';

  echo("<hr>");
   oci_free_statement($stid);
  
  
   
  $query = "select BUILD_TIME, RELEASE, ENVIRONMENT, CODESTREAM from V_BUILD_TIME";

  $stid = oci_parse($conn, $query);
  if (!$stid) {
   $e = oci_error($conn);
   echo htmlentities($e['message']);
   exit;
  }

  $r = oci_execute($stid, OCI_DEFAULT);
  if (!$r) {
   $e = oci_error($stid);
   echo htmlentities($e['message']);
   exit;
  }

  echo '<table border="1">';
  echo("<tr><th>Build Time</th><th>Release</th><th>Environment</th><th>Codestream</th></tr>");
  while ($row = oci_fetch_array($stid, OCI_RETURN_NULLS)) {
   echo '<tr>';
       foreach ($row as $item) {
         echo '<td>'.($item?htmlentities($item):'&nbsp;').'</td>';
       }
       echo '</tr>';
  }
  echo '</table>';
   oci_free_statement($stid); 
?>
<hr>
<?php 
   $stmt = oci_parse($conn, "SELECT BUILD_TIME, RELEASE, ENV_ID, CODESTREAM FROM APP_BUILDS");
   oci_execute($stmt);
  
   echo "<table border=\"1\">";
   echo "<tr>";
   echo "<th>Name</th>";
   echo "<th>Type</th>";
   echo "<th>Length</th>";
   echo "</tr>";
  
   $ncols = oci_num_fields($stmt);
  
   for ($i = 1; $i <= $ncols; $i++) {
       $column_name  = oci_field_name($stmt, $i);
       $column_type  = oci_field_type($stmt, $i);
       $column_size  = oci_field_size($stmt, $i);
      
       echo "<tr>";
       echo "<td>$column_name</td>";
       echo "<td>$column_type</td>";
       echo "<td>$column_size</td>";
       echo "</tr>";
   }
      
   echo "</table>\n";
  
   oci_free_statement($stmt); 
?> 
  
<?php
  oci_close($conn);
?>
