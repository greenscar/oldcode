<?php
class Ingredient extends AppModel
{
    var $name = 'Ingredient';
    var $displayField = 'name';
    var $belongsTo = 'Item';
}
?>
