<?php
class Recipe extends AppModel
{
    var $name = 'Recipe';
    var $belongsTo = 'Category';
    var $hasMany = array('Steps', 'Ingredients');
}
?>
