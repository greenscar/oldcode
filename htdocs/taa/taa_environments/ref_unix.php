<?php
   $title = "UNIX Info";
   include("./header.inc");
?>

<div id="Content">
   <h1>Unix</h1>
   
   <h5 class="header">List Running Processes</h5>
   <ul>
      <li>prstat -a 10</li>
      <li>top</li>
   </ul>
   <h5 class="header">Kill Running Processes</h5>
   <ul>
      <li>ps -ef | grep &lt;user&gt; | grep &lt;PORTION OF BATCH JOB NAME&gt; | awk '{print $2}' | xargs kill</li>
   </ul>
   
   <h5 class="header">Test # of open connections to a port</h5>
   <ol>
      <li>Telnet to box you want to test</li>
      <li>netstat -an | awk '$1 ~ /\.&lt;PORT NUM&gt;$/{sum+=1}END{print sum}'</li>
      <li>EX: netstat -an | awk '$1 ~ /\.1666$/{sum+=1}END{print sum}'</li>
   </ol>
   <br>
   <h5 class="header">CHMOD of all files in a dir recursively</h5>
   <ul>
   <li>find . -type f -exec chmod 644 {} \;</li>
   </ul>
   <hr>
   <h5 class="header">LIST ALL FILES IN A DIR AND IT'S SUB DIRS CONTAINING A STRING</h5>
   <ul>
      <li>find /home/wasadmin/TIERS_ALAMO_APT -name *.java | xargs DAOCacheLoader.getInstance</li>
      <li>find ./TIERS* -name "*.*" -exec grep ietadu001 {} \;</li>
      <li>find ./TIERS* -name *.* | xargs grep ietadu001</li>
   </ul>
   <p>note: this may display many "grep: can't open &lt;filename&gt;" errors.
      In order to avoid this, end the cmd with 2&gt;/dev/null so it sends all errors to null.
   <br>
      Thus:
   <br>
      find ./TIERS* -name *.* | xargs grep ietadu001 2>/dev/null
   </p>
   <hr>
   <h5 class="header">FIND FILES & REPLACE STRING IN FILES</h5>
   <ul>
      <li>find ./* -type f -name "*.ksh" -exec perl -pi -e "s/ENV/AGING02/g" {} \;</li>
      <li>perl -pi -e "s/iedaau003/AST01/g" persistence.properties</li>
      <li>find /TIERS/$1 -type f -name "*.ksh" -exec perl -pi -e "s/\015\012/\012/g" {} \;</li>
   </ul>
   <hr>
   <h5 class="header">SEARCH FOR ALL JAR FILES THEN SEARCH CONTENTS FOR PARTICULAR FILE</h5>
   <p>
      for i in `find . -name "*.jar" -print`; do unzip -l $i 2> /dev/null | grep StringFormatter > /dev/null 2>&1; if [ $? == 0 ]; then echo $i; fi; done
   </p>
   <h5 class="header">CREATE PATCH DIRS</h5>
   <p>
      for i in `ls`; do `mkdir $i/java/patch`; done
   </p>
   <hr>
   <h5 class="header">CREATE KEY FROM ONE BOX TO ANOTHER</h5>
   <ol>
      <li>On source machine, cd ~/.ssh</li>
      <li>cat contents of id_dsa.pub OR id_rsa.pub</li>
      <li>Copy contents and paste in notepad (NOTE: THIS IS A SINGLE LINE, NOT MULTIPLE)</li>
      <li>Login to Destination box from the Source Box<br>
EX: [wasadmin@iedaau019]/home/wasadmin> ssh batchtaa@ietadu001
      </li>
      <li>Enter your password and login. (If you cannot log in, then NG needs to add that user to the list of users for that box.)</li>
      <li>Verify you are in home dir => pwd</li>
      <li>CREATE .ssh dir => mkdir .ssh</li>
      <li>Set .ssh permissions to 700 => chmod 700 .ssh</li>
      <li>cd .ssh</li>
      <li>vi authorized_keys</li>
      <li>paste your key and make sure it is a single line.</li>
      <li>verify your connections works by ssh batchtaa@ietadu001 and you should not get a login.<br>
      If you are prompted for a login, you did something wrong.<br>
      If you get prompted for password, you did somethign wrong.<br>
      If you get prompted for passphrase, whoever created that public / private key pair we used created a passphrase with it also.<br>
      </li>
   </ol>
   <hr>
   <h5 class="header">TO EDIT USER INFORMATION (cmd line, alias, etc)</h5>
      vi ~/.bashrc
   <hr>
   <h5 class="header">Change dir so all items written in it wil inherit group of dir</h5>
   <ol>
      <li>change dir so anything written to it takes group of chmod g+s dirName</li>
      <li>change dir so group can write in it.<br>
         chmod g+w dirName
      </li>
      <li>
         change group of contents of dir.<br>
         chgrp grpName dirName/*
      </li>
      <li>
         change contents of dir to give group read write.<br>
         chmod g+rw dirName/*
      </li>
   </ol>
   <hr>
   <h5 class="header">Batch Setup with Security</h5>
   <a href="envts\batchpermissions.txt">script to change permissions</a>
   <p>When setting up batch security, batchop needs to be able to write in */temp & fw/java/patch.<br>
   Also, everything created in these directories needs to be writable by batchop.</p>
   <h6>Do this to fw/java/patch/*</h6>
   <ul>
      <li>
         # Set dir so anything written in it inherits dir's group.
         <br>
         chmod g+s fw/java/patch
      </li>
      <li>
         # Set everything in in/data to be writable by group
         <br>
         chmod g+w fw/java/patch
      </li>
      <li>
         # Always must have execute permissions to dir itself & so group can execute what they place in patch dir
         <br>
         chmod -R g+x fw/java/patch
      </li>
      <li>
         # Change group of data contents to batchtaa
         <br>
         chgrp -R batchtaa fw/java/patch
      </li>
   </ul>
   <h6>Do this to env_name/*/temp, env_name/*/logs, env_name/tierslogs, env_name/*/data, env_name/*/report, env_name/co/print</h6>
   <ul>
      <li>
         # Set dir so anything written in it inherits dir's group.
         <br>
         chmod g+s */temp
      </li>
      <li>
         # Set everything in temp to be writable by group
         <br>
         chmod -R g+w */temp
      </li>
      <li>
         # Always must have execute permissions to dir itself.
         <br>
         chmod g+x */temp
      </li>
      <li>
         # Change group of temp contents to batchtaa
         <br>
         chgrp -R batchtaa */temp
      </li>
   </ul>
   <hr>
   <h6>Find unwanted characters</h6>
   <ul>
      <li>
         Find /ENV/
         <br>
         find ./* -type f -name "*.ksh" | grep "/ENV/"
      </li>
      <li>
         Find ^M
         <br>
         find ./* -type f -name "*.ksh" | grep "&lt;CTRL-V&gt; &lt;CTRL-M&gt;"
      </li>
   </ul>
   <hr>
   <h6>Num Files in DIR</h6>
   <ul>
      <li>ls  -l  | wc -l</li>
   </ul>
   <hr>
   <h6>Used Space of Current FileSystem (DIR)</h6>
   <ul>
      <li>cd to parent dir</li>
      <li>du -sh &lt;dirname&gt;</li>
   </ul>
   <hr>
   
   <h6>User / Group lookup</h6>
   <ul>
      <li>ypcat passwd | grep &lt;user num&gt;</li>
      <li>ypcat group | grep #</li>
   </ul>
   <hr>
   <h6>Apache</h6>
   <ul>
      <li>/etc/apache</li>
      <li>/var/apache</li>
      <li>
         sudo /usr/apache/bin/apachectl restart
         <br>
         Provide your user password
      </li>   
   </ul>
   <hr>
   <h5 class="header">Building with ANT</h5>
   <h6>In Background:</h6>
   <ol>
      <li>cd /home/ccbuild/tiersbuild/harmony/scripts</li>
      <li>at -f deploy56APTAging.sh now</li>
   </ol>
   <h6>In Foreground:</h6>
   <ol>
      <li>cd /home/ccbuild/tiersbuild/harmony/xml</li>
      <li>ant -Dview_name=TIERS_WICHITA_AST -Denv_name=AST01 -Dbuild_number=58.1 buildboth_ws</li>
   </ol>
      
</div>

<?php 
//include("menu.inc"); 
?>
</body>
</html>