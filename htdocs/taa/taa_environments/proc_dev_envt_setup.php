<?php
   $title = "How to Prep an Envt for Development";
   include("./header.inc");
?>
<div id="Content">
   <h1>How to Prep an Envt for Development</h1>
   <ol>
      <li>Have stream created</li>
      <li>Have views of stream created on build box</li>
      <li>Copy all MRS from R-1 to R's MRS tables</li>
      <li>Bump up sequence number of destination MRS envt to highest level</li>
      <li>Bring DB up to latest version of R-1 and run all migration scripts</li>
      <li>Change version and description of DB to release number</li>
      <li>Compare properties files and make changes to R where necessary</li>
      <li>Set up build script</li>
      <li>Make sure all property files from previous release have been applied</li>
   </ol>
</div>
<?php 
//include("menu.inc"); 
?>
</body>
</html>
