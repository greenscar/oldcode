<?php
require_once("Secretary.inc");
require_once("MQ.inc");
require_once("Schema.inc");
require_once("Settings.inc");
require_once("Environment.inc");
require_once("Application.inc");
class App
{  
   var $application;
   // Release number of application. Currently not used
   var $release_num;
   // Schema app talks to
   var $schema;
   // MQ used by app
   var $mq;
   // MISC settings for app to use.
   var $settings;
   // Environment of app (AST01, AST02, etc)
   var $environment;
   // User who owns the application
   var $user;
   // Baseline number
   var $baseline_num;
   function App()
   {
      $this->application = new Application();
      $this->environment = new Environment();
      $this->log = new Secretary();
      $this->mq = new MQ();
      $this->schema = new Schema();
      $this->settings = new Settings();
   }
   
   function to_string()
   {
      $str = "\r\n-------------------------------------------\r\n";
      $str .= "application->name => " . $this->application->name . "\r\n";
      $str .= "environment->name => " . $this->environment->name . "\r\n";
      $str .= "release_num => " . $this->release_num . "\r\n";
      $str .= "schema => " . $this->schema->id . "\r\n";
      $str .= "mq => " . $this->mq->id . "\r\n";
      $str .= "-------------------------------------------\r\n";
      return($str);
   }   
}
?>
