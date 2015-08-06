<?php
class RecipesController extends AppController
{
    var $name = 'Recipes';
    //var $uses = array('Recipes', 'Categories', 'Ingredients', 'Steps', 'Measurements');
    //var $uses = array('Recipe', 'Category');
    function index()
    {
        $this->set('recipes', $this->Recipe->find('all'));
    }
}
?>

