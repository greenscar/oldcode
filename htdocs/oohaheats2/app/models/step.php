<?php
class Step extends AppModel
{
    /*
     * COLUMNS:
     *  recipe_id
     *  order_num
     *  step_descr
     */
    // A good practice to always include this variable.
    var $name = 'Step';
    // This is used for validation.
    // Check out chapter "Data Validation"
    var $validate = array();
    // Define associations
    var $hasOne = 'Recipe';
    
}
?>
