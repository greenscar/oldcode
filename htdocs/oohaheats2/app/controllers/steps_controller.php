<?php
class StepsController extends AppController
{
    var $name = 'Steps';
    function index()
    {
        $this->set('steps', $this->Category->find('all'));
    }
}
?>
