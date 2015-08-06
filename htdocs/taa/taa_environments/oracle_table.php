<html>
<head><title>A table</title></head>
<body>
<?php
  $conn = oci_connect("ZORO", "ZERO", "dte2");
  if (!$conn) {
   $e = oci_error();
   echo htmlentities($e['message']);
   exit;
  }
  
  echo "<table border=\"1\">";
  
  $q = "SELECT BUILD_TIME, RELEASE, ENV_ID, CODESTREAM FROM APP_BUILDS";
  echo("<h3>$q</h3>");
  $stmt = oci_parse($conn, $q);
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
  
  echo "<tr>";
  for ($i = 1; $i <= $ncols; $i++) {
      $column_name  = oci_field_name($stmt, $i);
      echo "<th>$column_name</th>";
  }
  echo("</tr>");
  
  echo "<tr>";
  for ($i = 1; $i <= $ncols; $i++) {
      $column_type  = oci_field_type($stmt, $i);
      $column_size  = oci_field_size($stmt, $i);
      echo "<td><b>$column_type($column_size)</b></td>";
  }
  echo("</tr>");
  while ($row = oci_fetch_array($stmt, OCI_RETURN_NULLS)) {
     echo '<tr>';
     foreach ($row as $item) {
        echo '<td>'.($item?htmlentities($item):'&nbsp;').'</td>';
     }
     echo '</tr>';
  }
  echo "</table>\n";
  oci_free_statement($stmt); 
?> 
  
<?php
  oci_close($conn);
?>
</body>
