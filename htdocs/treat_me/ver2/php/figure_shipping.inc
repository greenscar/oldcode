<?php
function shipping_upgrade_price($upgrade){
	switch($upgrade){
		case "3rd_day":
			return 5.95;
			break;
		case "2nd_day":
			return 10.95;
			break;
		case "overnight":
			return 20;
			break;
		default:
			return 0;
			break;
	}
}
function compute_shipping($sub_total){
	$shipping = 0;
	if($sub_total < 50){
		$shipping = 8;
	}
	else if($sub_total < 100){
		$shipping = 8.95;
	}
	else if($sub_total < 150){
		$shipping = 11.95;
	}	
		else if($sub_total < 200){
		$shipping = 14.95;
	}
	$shipping=number_format($shipping,"2",".","thousands_sep");
	return $shipping;
}

/*
* This function will add the shipping upgrade amount to the shipping charges
*/
function compute_shipping_upgrade($shipping, $shipping_type){
	switch($shipping_type){
		case "3rd_day":
			$shipping += 5.95;
			break;
		case "2nd_day":
			$shipping += 10.95;
			break;
		case "overnight":
			$shipping += 20;
			break;
	}
	return $shipping;
}

?>