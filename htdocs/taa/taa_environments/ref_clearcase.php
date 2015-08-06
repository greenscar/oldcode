<?php
   $title = "ClearCase Info";
   include("./header.inc");
?>
<div id="Content">
   <h1>ClearCase</h1>
   <h6>List baselines</h6>
   <p>cleartool lsbl</p>
   <h6>Display the Difference Between Baselines</h6>
   <p>cleartool diffbl 20070206_TIERS_601083@\\TAA_projects 20070206_TIERS_601082@\\TAA_projects</p>
   <h6>Display the Difference Between a Baseline & it's Predecessor</h6>
   <p>cleartool diffbl -pred 20070206_TIERS_601083@\\TAA_projects</p>
   <h6>Display the Version Differences Between a Baseline & it's Predecessor</h6>
   <p>cleartool diffbl -pred -versions 20070206_TIERS_601083@\\TAA_projects</p>
   <hr>
   <h6>List all views</h6>
   <p>cleartool lsview</p>
   <h6>Open a view</h6>
   <p>cp startview Jordan.M.Klein_TIERS_Project_AST_dyn</p>
   <hr>
   <h6>List all activities to deliver</h6>
   <p>cleartool deliver -prev</p>
   <h6>Deliver activity</h6>
   <p>cleartool deliver -act #,# -gmerge -complete</p>
   <hr>
   <h6>Find activity by number</h6>
   <p>cleartool lsact # </p>
   <h6>Find activity by name</h6>
   <p>cleartool lsact | find /i "SR#123456"</p>
   <h6>Find contributing activites</h6>
   <p>cleartool lsact –contrib TAAxxxxxxxx@\TAA_projects</p>
   <h6>List activity dates & descriptions</h6>
   <p>cleartool lsact -fmt "%d - %[headline]p\n"</p>
   <h6>List activity dates & ids</h6>
   <p>cleartool lsact -fmt "%d - %[crm_record_id]p\n"</p>
   <hr>
   <h6>View version tree</h6>
   <p>cleartool lsvtree -g &lt;full path filename&gt;</p>
   <h6>List stuff since certain date</h6>
   <p>cleartool find * -all -element -branch "created_since(12-Aug-2006)" -print</p>
   <h6>Modify headline of activity</h6>
   <p>cleartool chact -headline "Chris Bowles - CPM and Clues and Issues deliver TIERS_ALAMO_DEV on 8/21/2006 9:59:15 AM." TAA00010808</p>
   <h6>Show deliveries in progress</h6>
   <p>cleartool deliver -status</p>
   <h6>Move file between activities</h6>
   <p>
      cleartool chactivity -fcset &lt;source_activity&gt; \-tcsets &lt;to_activity&gt; add_proc@@/main/chris_webo_dev/1
      <br>
      <b>EX:</b>
      <br>
      cleartool chactivity -fcset TAA00011783 \-tcsets TAA00011773 ./TIERS_track04/track04EJB/ejbModule/us/tx/state/dhs/tiers/business/rules/co/CoTfPrintWriter.java@@/main/TIERS_Int/TIERS_Project_Int/TIERS_WICHITA_DEV/6
   </p>
   <hr>
   <h4>Find Merge</h4>
   <ol>
      <li>
         In the destination stream, create a NEW BASE CM Activity in the dynamic view with the activity name that developer is trying to deliver.
         <ol>
            <li>Open ClearCase Explorer</li>
            <li>Right click on the target project.</li>
            <li>Click View Properties</li>
            <li>Click Change</li>
            <li>Click New / BaseCMActivity</li>
            <li>Enter Headline</li>
            <li>Copy the ID Created</li>
            <li>Click OK / OK / OK</li>
         </ol>
      </li>
      <li>Open your new activity in ClearCase by double clicking on it</li>
      <li>At a command line, go to the M: drive.</li>
      <li>Change directory to the dynamic view of the destination directory.</li>
      <li>Navigate to a writable directory on that VOB. I.E. m:\TIERS_APT01\TIERS_Entity\</li>
      <li>Use the following commands to do the merge:</li>
      <li>Cleartool findmerge &lt;source_CQ_activity_#&gt;@\\TAA_projects –fcsets -nc -type d –merge –gmerge –log NUL</li>
      <li>Cleartool findmerge &lt;source_CQ_activity_#&gt;@\\TAA_projects –fcsets -nc -type f –merge –gmerge –log NUL</li>
      <li>Using ClearCase Project Explorer, in the destination stream, right-click on the new activity and select “Check in” and then “Apply”.  If there are several activities to check in, select the “Check in all” option.</li>
      <li>Close your activity by clicking Cancel.</li>
   </ol>
   <hr>
   <h4>Create a snapshot view</h4>
   <ol>
      <li>Open ClearCase Project Explorer</li>
      <li>Browse the tree on the left to find the project you wish to create view of.</li>
      <li>Right click on the project and click “Create View”</li>
      <li>
         On the window that comes up
         <ol>
            <li>Open Rational ClearCase Explorer</li>
            <li>On the bottom left, click the “Views” tab</li>
            <li>Right click in the dark grey area on the left</li>
            <li>Click “Add View Shortcut”</li>
            <li>For Page select “TIERS_Project”</li>
            <li>For “View Type” select “Snapshot”</li>
            <li>For “Snapshot Location” select “C:\working”</li>
         </ol>
      </li>
   </ol>



</div>
<?php 
//include("menu.inc"); 
?>
</body>
</html>
