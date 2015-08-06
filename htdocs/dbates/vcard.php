<?php
if(isset($_GET["fn"]) && isset($_GET["ln"]))
{
    require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Rep.inc");
    $rep = new Rep();
    $rep->first_name=$_GET["fn"];
    $rep->last_name=$_GET["ln"];
    
    // We'll be outputting a PDF
    header('Content-type: text/x-vCard');
    
    $vcard_name = $rep->first_name . "_" . $rep->last_name . ".vcf";
    // It will be called downloaded.pdf
    header("Content-Disposition: attachment; filename=\"$vcard_name\"");
    
    readfile($rep->getVcardPath());
}
else
{
    header("location: " . $_SERVER["SERVER_NAME"] . "/directory.php");
}
?> 