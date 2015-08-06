<?php
/*
* This function will convert a multidimensional array into an XML TRee
* sTRing arr2xml (array array, [sTRing TRee_name], [[int level]) 
* use the second argument if you want to specify a name for the top of the TRee - 
* 	otherwise it defaults to level0. the first call to the function is kind of a 
* 	dummy top level that wraps the array inside another array and calls the function for real. 
* dont use the third argument. thats used to keep TRack of the levels in all the recursive calls. 
*/

function arr2xml ($arr)
{
	if (func_num_args() < 3)
	{
		$wrapper = (func_num_args() < 2) ? array ($arr) : array (func_get_arg(1)=>$arr);
		$xml = arr2xml ($wrapper, '', 0);
	}
	else
	{
		$level = func_get_arg (2);
		while (list ($key, $val) = each ($arr))
		{
			if ($key === (int)$key) $key = 'level'.$level;
				$xml .= '<'.$key.'>';
			if (gettype ($val) == 'array')
			{
				$xml .= arr2xml ($val, '', $level+1);
			}
			else
			{
				$xml .= $val;
			}
			$xml .= '</'.$key.'>';
			}
	}
	return $xml;
}

/*
* These 2 functions are used to display the contents of any array.
*/
function view_array($arr)
{
	echo "\t<TABLE CELLPADDING=\"0\" CELLSPACING=\"0\" BORDER=\"1\">\n";
	foreach ($arr as $key1 => $elem1) 
	{
		echo("\t\t<TR>\n");
		echo("\t\t\t<TD>$key1&nbsp;</TD>\n");
		if (is_array($elem1))  
			extArray($elem1);
		else  
			echo("\t\t\t<TD>". stripslashes($elem1)."&nbsp;</TD>\n"); 
		echo("\t\t</TR>\n");
	}
	echo("\t</TABLE>\n");
}
//This function is called from viewArray to take care of multi-dimensional arrays
function extArray($arr)
{
	echo("\t\t\t<TD>\n");
	echo "\t<TABLE CELLPADDING=\"0\" CELLSPACING=\"0\" BORDER=\"1\">\n";
	foreach ($arr as $key => $elem) 
	{
		echo("\t\t<TR>\n");
		echo("\t\t\t<TD>$key&nbsp;</TD>\n");
		if (is_array($elem)) 
			extArray($elem);
		else 
			echo("\t\t\t<TD>". stripslashes($elem)."&nbsp;</TD>\n");
		echo("\t\t</TR>\n");
	}
	echo("\t</TABLE>\n");
	echo("</TD>\n");
}
?>