<div id="Menu">
   <a href="http://www.oohaheats.com/" title="Ooh Ah Eats Home">
      <img src="monkey.png">
   </a>
   <form method="post" name="searchForm" action="search_process.php">
      <p>
         Search Recipes:
         <input type="text" class="search" name="titles">
         Search Ingredients:
         <input type="text" class="search" name="ingredients">
         <a href="#" title="Search" onclick="searchForm.submit();">Search</a>
      </p>
   </form>
   <?php      require_once("./classes/Cookbook.inc");      $cookbook = new Cookbook();      $cats = $cookbook->get_categories();      foreach($cats as $cat)      {         echo("<a href=\"category_display.php?id=" . $cat->id. "&name=" . $cat->descr . "\" title=\"" . $cat->descr . "\">" . $cat->descr . "</a><br>\n");      }
      if(isset($_SESSION['user']))
      {
         ?>
         <br>
         <h5>ADMIN TOOLS</h5>
         <a href="recipe_mod.php">Modify / Delete</a><br>
         <a href="recipe_add.php">Add</a>
         <?php
      }
      else
      {
         ?>
         <form method="post" name="loginForm" action="login_process.php">
         <p>
            admin id:
            <input type="text" class="search" name="id">
            password:
            <input type="password" class="search" name="pwd">
            <a href="#" title="Search" onclick="loginForm.submit();">Login</a>
         </p>
         </form>
         <?php
      }   ?>
</div>