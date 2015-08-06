<html>
<head>
</head>
<body>
<table width="800px" border=0px>
<?php
for($i=0; $i < 16777216; $i = $i + 64)
{
    //echo str_pad($input, 10, "-=", STR_PAD_LEFT);
    // RED 
    $red = dechex(floor($i / 65536)); //fmod($i, 65536);
    if(strlen($red) < 2) $red = str_pad($red, 2, "0", STR_PAD_LEFT);
    // GREEN
    if($i > 65336)
    {
        //$green = $i - 65336;
        $green = $i;
        $green = dechex(floor($green / 256));//fmod($i, 256);
        //$green = floor($green / 256);//fmod($i, 256);
    }
    else // $ <= 65336
    {
        $green = dechex(floor($i / 256));//fmod($i, 256);
    }
    if(strlen($green) < 2) $green = str_pad($green, 2, "0", STR_PAD_LEFT);
    // BLUE
    $blue = dechex(fmod($i, 256));
    if(strlen($blue) < 2) $blue = str_pad($blue, 2, "0", STR_PAD_LEFT);
    if((fmod($i, 512) == 0) && ($i != 512))
        echo("<tr>");
    $color = $red . "|" .  $green . "|" . $blue;
    //echo("<td>$i</td>");
    echo("<td style=\"background-color:#$color;border: 1px #$color solid;\">$color</td>");
    if((fmod(($i + 512), 512) == 0) && ($i != 0))
        echo("</tr>\n");
}


/*
for($red = 0; $red < 256; $red = $red + 5)
{
    for($green=0; $green<256; $green = $green + 5)
    {
        for($blue=0;$blue<256;$blue = $blue + 5)
        {
            echo("<!--$red-->");
            $redhex = dechex($red);
            $greenhex = dechex($green);
            $bluehex = dechex($blue);
            if(strlen($redhex) == 1) $redhex = "0" . $redhex;
            if(strlen($greenhex) == 1) $greenhex = "0" . $greenhex;
            if(strlen($bluehex) == 1) $bluehex = "0" . $bluehex;
            $color = $redhex . $greenhex  . $bluehex;
            if($blue == 0) echo("<tr>");
            else if((fmod(($blue), 8) == 0) && ($blue != 1))
            {
                echo("<tr>");
            }
            //echo("<td>$color</td>");
            echo("<td style=\"background-color:#$color;border: 1px #$color solid;\">$color</td>");
            if((fmod(($blue + 1), 8) == 0) && ($blue != 0))
            {
                echo("</tr>\n");
            }
        }
    }
}
*/
?>
</table>
</body>
</html>
