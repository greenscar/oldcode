<?php
$title = "";
$page_height = 1000;
$on_load="document.mailing_list.first_name.select();document.mailing_list.first_name.focus();";
include("header.inc");
?>
	<div class="body">
	
		<img src="./page_bodies/mailing_list_body.gif" style="margin: 25px 0px 0px 80px;">
		
  <div style="border:0px solid orange; width:600px; height:350px;position:relative; top:40px; left:-85px;"> 
    <form action="" method="post" name="mailing_list" target="#">
      <table border=0px style="color:#F8B6D3;font-size:14px;font-family:arial;font-weight:bold; width:100%; border:0px solid black;">
        <tr> 
          <td width="76">First Name</td>
          <td width="205"><input type="text" name="first_name" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"></td>
          <td width="73">Last Name</td>
          <td width="200"><input type="text" name="last_name" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"></td>
        </tr>
        <tr> 
          <td >Email</td>
          <td><input type="text" name="email" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"></td>
          <td>Address</td>
          <td><input type="text" name="address" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"></td>
        </tr>
        <tr> 
          <td>City</td>
          <td><input type="text" name="city" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"></td>
          <td>State</td>
          <td><input type="text" name="state" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"></td>
        </tr>
        <tr> 
          <td>Zip Code</td>
          <td><input type="text" name="zip_code" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"></td>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4"> How did you hear about treat? &nbsp; <input type="text" name="reference" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"> 
          </td>
        </tr>
        <tr> 
          <td colspan="4">We welcome your comments, questions, and suggestions</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td colspan="3"><textarea name="comments_suggestions" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:100%;height:90px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;overflow:hidden;"></textarea></td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td colspan="3"> <a href=# class="submit" style="margin:10px 10px 10px 0px;" onclick="mailing_list.submit()"> 
            <div class="arialfourteen">Join Treat List</div>
			</a><a href=# class="submit" style="margin:10px 10px 10px 25px;" onclick="mailing_list.reset();"> 
            <div class="arialfourteen">Clear Form</div>
            </a> </td>
        </tr>
      </table>
    </form>
    <img src="images/treat_yourself_and_enjoy.gif" style="position:relative; margin: 20px 0px 0px 110px;" alt="Treat Yourself and Enjoy"> 
  </div>
		
		
<?php
include("footer.inc");
?>