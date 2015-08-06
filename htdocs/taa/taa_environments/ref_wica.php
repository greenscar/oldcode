<?php
   $title = "WICA Info";
   include("./header.inc");
?>

<div id="Content">
   <h1>WICA</h1>
   <h4 class="header">HELP</h4>
   <h5>To get help in WICA, use –l</h5>
   <ul>
      <li>
         Example (Help @ Node Level)
         <div class="ex">./WICA.sh –e TIERS –l</div>
      </li>
   </ul>
   <hr>
   <h4 class="header">WICA INFO</h4>
      <ul>
         <li>
            <div class="ex">wasadmin@iedaau019</div>
         </li>
         <li>
            <div class="ex">/export/WICA/bin</div>
         </li>
         <li>
            <div class="ex">
               Configuration information:<br>
               /export/WICA/environments/TIERS/cells/&lt;cell name&gt;<br>
               EX:
               /export/WICA/environments/TIERS/cells/tiers_misc_Network
            </div>
         </li>
      </ul>
   <hr>
   <h4 class="header">FORMAT</h4>
      <ul>
         <li>
            <div class="ex">./WICA.sh –e &lt;environment name&gt; -c &lt;cell name&gt; -n &lt;node name&gt; -u &lt;cluster name&gt; -a &lt;application name&gt;</div>
         </li>
         <li><div class="ex">EXAMPLE</div>
            <ul>
               <li>ENVIRONMENT - <u>TIERS</u></li>
               <li>CELL - <u>tiers_apt_Network</u></li>
               <li>NODE - <u>iedaau002</u></li>
               <li>CLUSTER - <u>apt01-cluster</u></li>
               <li>APPLICATION - <u>tiersapt01</u></li>
            </ul>
         </li>
      </ul>
   <hr>
   <h4 class="header">PICKING UP CHANGES DONE IN THE DM</h4>
   <ul>
      <li>
         To pick up changes bounce in this order:
         <ol>
            <li>
               Deployment Manager<br>
               ./WICA.sh -e TIERS -c tiers_apt_Network -t stop_nd<br>
               ./WICA.sh -e TIERS -c tiers_apt_Network -t start_nd
            </li>
            <li>
               node agent<br>
               ./WICA.sh -e TIERS -c tiers_apt_Network -n iedaau002 -t stop_nodeagent<br>
               ./WICA.sh -e TIERS -c tiers_apt_Network -n iedaau002 -t start_nodeagent
            </li>
            <li>
               Cluster<br>
               ./WICA.sh -e TIERS -c tiers_apt_Network -u apt01-cluster -t stop_cluster<br>
               ./WICA.sh -e TIERS -c tiers_apt_Network -u apt01-cluster -t start_cluster
            </li>
         </ol>
      </li>
   </ul>
   <h4 class="header">EXAMPLES</h4>
   <ul>
      <li>
         Start Node Agent
         <div class="ex">[wasadmin@iedaau019]> ./WICA.sh -e TIERS -c tiers_aging_Network -n iedaau002 -t start_nodeagent</div>
      </li>
      <li>
         Stop GENX<br>
         ./WICA.sh -e TIERS -c tiers_genx_Network -u genx-cluster -a stage3tiersGENX -t stop_app
      </li>
      <li>
         Start App
         <div class="ex">./WICA.sh -e TIERS -c tiers_aging_Network -u aging01-cluster -a tiersaging01 -t start_app</div>
      </li>
      <li>
         Stop node
         <div class="ex">./WICA.sh -e TIERS -c tiers_aging_Network -t stop_nd</div>
      </li>
      <li>
         Start node
         <div class="ex">./WICA.sh -e TIERS -c tiers_aging_Network -t start_nd</div>
      </li>
   </ul>
</div>

<?php 
//include("menu.inc"); 
?>
</body>
</html>
