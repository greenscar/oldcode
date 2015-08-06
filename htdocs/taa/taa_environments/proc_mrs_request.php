<?php
   $title = "MRS Process";
   include("./header.inc");
?>
<div id="Content">
   <h1>MRS Changes</h1>
   <p>
      MRS stands for Master Reference Schema. This database schema is used to house data that will be loaded into the cache of the TIERS application upon startup. When a change is applied in a MRS, it WILL go into production. The MRS schema is copied in its entirety from DEV/AST to APT to IPT to PROD. Thus if you make a change which is later determined should not go into production you must create another request to back out your changes.
   </p>
   <p>
      Please be aware: if this process is not followed in its entirety, the request will be assigned back to the owner. No MRS changes will be applied without a scheduled release number and a parent SR without management’s approval.
   </p>
   <p>
      Based on the size of the change, it may take several hours to process a request. There are some tables in the MRS (e.g. Security tables) which are not true reference tables and do not require a bounce of the application to reflect the change. However, all Reference Table changes do require a bounce of the TIERS app to view. Also, even when your MRS change is processed in the MRS environment and the application bounces picking up your changes you will still not see the change in the SQL query window. The MRS is copied in its entirety from the MRS environment to the corresponding AST environment each night; therefore, you will see your changes reflected in the AST environment the next day. Thus, it will usually take a full 24 hour period for your MRS change to be fully reflected in the AST environment.
   </p>
   <p>
      To initially have a MRS change applied in DEV / AST, you must create a request to the MRS team. The MRS team will apply the change to the AST environment. We will copy MRS weekly from AST to APT and then IPT; therefore, at this point, you are done with your change unless you are rushed to have it promoted up the environments.
   </p>

   <ol>
      <li>Complete MRS template (see <a href="http://iepsww001/environments/Information/Reference_Table_Template.xls">Reference_Table_Template.xls</a>)</li>
      <li>Create environment request (ER) in ITG</li>
      <li>
         Enter the following values:
         <ol>
            <li>Team: APP TIERS</li>
            <li>Short Description: “MRS change [name of table being changed]”	</li>
            <li>Description of Change: MRS change to table(s): [table 1], [table 2], etc. </li>
            <li>Enter your Release Name</li>
            <li>Give Target Completion Date & Time allowing 24 hrs.</li>
            <li>The rest of the mandatory fields are self explanatory.</li>
         </ol>
      </li>
      <li>
         Under References / Reference Additions,  add your spreadsheet
         <ol>
            <li>Select Attachment and click Add</li>
            <li>Attach the MRS spreadsheet you completed</li>
         </ol>
      </li>
      <li>
         Add your SR as a parent
         <ol>
            <li>Select Request (Existing) and click Add</li>
            <li>Enter your SR number and click Search</li>
            <li>Select “Parent of this Request...” radio button</li>
            <li>Place a check in the box to the left of your SR</li>
            <li>Click “Add”</li>
         </ol>
      </li>
      <li>Save your request. </li>
      <li>After the request is completed, the ticket will be assigned back to you for validation purposes. Validate your change in the DB then place a note in the ER.</li>
   </ol>
   <ul>
      <li>MRS copies from AST to APT will happen nightly.</li>
      <li>MRS copies from APT to IPT will happen weekly.</li>
   </ul>
</div>
<?php 
//include("menu.inc"); 
?>
</body>
</html>


