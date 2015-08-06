<?php
   $title = "SAS Trigger Reset";
   include("./header.inc");
?>
<div id="Content">
   <h1>Reset SAS Triggers</h1>
   <ol>
      <li>Log into the appropriate write-access database.</li>
      <li>
         Execute the following query (replacing 1234567890 with the actual case number):
         <br>
         select * from ed_indv_service_dtls where case_num = 1234567890
      </li>
      <li>Change the current_elig_ind from 'M' to 'P'.  Leave any triggers that have current_elig_ind as anything other then 'M' as they are.</li>
      <li>Click Commit.</li>
   </ol>
   <p>
      The triggers can now be resubmitted (by changing case mode to Change Action and redisposing without changing any information in Data Collection).
   </p>
</div>
<?php 
//include("menu.inc"); 
?>
</body>
</html>
