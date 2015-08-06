<?php
   $title = "Aging Environment Setup";
   include("./header.inc");
?>

<div id="Content">
   <h1>Aging Environment Setup</h1>
   <h4 class="header">3 Parts</h4>
   <ol>
      <li>Server</li>
      <li>WebSphere</li>
      <li>DB Update</li>
   </ol>
   <hr>
   <h4 class="header">Server</h4>
   <ul>
      <li>
         Ensure the file exists
         <br>
         <p>/home/&lt;owner&gt;/WebContent/&lt;ENVNAME&gt;/jars/cal/cal141.jar exists.</p>
      </li>
   </ul>
   <hr>
   <h4 class="header">WebSphere</h4>
   <ol>
      <li>Click Application Server you wish to enable aging</li>
      <li>Click Process Definitions</li>
      <li>Click Java Virtual Machine</li>
      <li>Goto Generic JVM Arguments</li>
      <li>
         Add -Xbootclasspath/p:/home/wastest/DATA/TIERS/cal141.jar
         <br>
         EX:-Xbootclasspath/p:/home/wastest/DATA/TIERS/cal141.jar -client -XX:MaxPermSize=256m  -XX:NewRatio=2 -XX:MaxNewSize=512m -XX:+AggressiveHea      
      </li>      
   </ol>
   <hr>
   <h4 class="header">Database</h4>
   <ol>
      <li>
         insert into fw_parameters values (1,'APPLICATION_DATE','08/14/2006 12:00:00','jsandlin',null,sysdate,null,1, to_date('12-31-2999','mm-dd-yyyy'));
         <br>
         <b>OR</b>
         <br>
         update fw_parameters set parm_value = '08/14/2006 12:00:00' where parm_id = 1;
      </li>
      <li>Bounce the App</li>
   </ol>
</div>

<?php 
//include("menu.inc"); 
?>
</body>
</html>
