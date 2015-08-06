<?php
   $title = "WebSphere Info";
   include("./header.inc");
?>

<div id="Content">
   <h1>WebSphere</h1>
   <h4 class="header">Modify Websphere Variables</h4>
   <ol>
      <li>Environment</li>
      <li>Manage WebSphere Variables</li>
      <li>Goto the Cell Level</li>
      <li>Apply</li>
   </ol>
   <hr>
   <h4 class="header">DB Info</h4>
   <ol>
      <li>Resources</li>
      <li>JDBC Providers</li>
      <li>Enter Node Name or Browse for Node</li>
      <li>Enter Server Name or Browse for Server</li>
      <li>Click Apply</li>
      <li>Click "Oracle JDBC Driver"</li>
   </ol>
   <hr>
   <h4 class="header">Disable security for Websphere</h4>
   <ol>
      <li> vi /export/ENV/TIERS/aging/WebSphere/DeploymentManager/config/cells/tiers_aging_Network/security.xml</li>
      <li>In first argument, set enabled=”false”</li>
   </ol>
   <hr>
   <h4 class="header">Deployed EAR</h4>
   <ul>
      <li>/export/ENV/TIERS/aging/WebSphere/AppServer/installedApps/tiers_aging_Network/tiersaging03.ear </li>
   </ul>
   <hr>
   <h4 class="header">Cache</h4>
   <ul>
      <li>/export/ENV/TIERS/aging/WebSphere/AppServer/temp/iedaau002/aging03-server2</li>
   </ul>
   
   
</div>

<?php 
//include("menu.inc"); 
?>
</body>
</html>