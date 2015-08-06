<?php
$title = "Treat Shops";
$page_height = 900;
$on_load="document.mailing_list.first_name.select();document.mailing_list.first_name.focus();";
$page_header = "./page_headers/treat_shops_header.gif";
include("header.inc");
?>
	<div class="body" style="margin: 30px 0px 0px 25px;">
            <img src="./page_bodies/treat_shops_body.gif">
            <div style="border:0px solid orange; width:600px; height:350px;position:relative; top:50px; left:-55px;"> 
    <form action="" method="post" name="mailing_list" target="#">
      <table border=0px style="color:#F8B6D3;font-size:14px;font-family:arial;font-weight:bold; width:103%; border:0px solid black;">
        <tr> 
          <td width="80">Store Name</td>
          <td width="195">
            <input type="text" name="first_name" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;">
          </td>
          <td width="102">Store Address</td>
          <td width="200"><input type="text" name="last_name" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"></td>
        </tr>
        <tr> 
          <td >Email</td>
          <td><input type="text" name="email" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"></td>
          <td>City</td>
          <td><input type="text" name="address" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"></td>
        </tr>
        <tr> 
          <td>State</td>
          <td><input type="text" name="city" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"></td>
          <td>Zip</td>
          <td><input type="text" name="state" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"></td>
        </tr>
        <tr> 
          <td>Phone</td>
          <td><input type="text" name="zip_code" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:200px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;"></td>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr> 
                 
          <td valign=top>Comments</td>
          <td colspan="3"><textarea name="comments_suggestions" style="color:#EE2D68;font-size:14px;font-family:arial;font-weight:bold;width:100%;height:90px;background-color:#F8DEEB;border-color:white;border-width:2px;border-style:solid;overflow:hidden;"></textarea></td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">
            <a href=# class="submit" style="margin: 10px 130px 10px 236px;" onclick="mailing_list.reset();"> 
                <div class="arialfourteen">Submit</div>
            </a>
          </td>
        </tr>
      </table>
    </form>
        </div>
	
	
<?php
include("footer.inc");
?>