<?php
//require_once("DB_Mgr.inc");
require_once("Secretary.inc");
require_once("Flavor.inc");
class Catalog
{
   var $items;
   var $log;
   function Catalog()
   {
      $this->items = Array();
      $this->log = new Secretary();
   }
   function dbLoadItemsByNameID($dbmgr, $nameID)
   {
      $sel = "SELECT id.SKU, id.itemID, id.categoryID, id.flavorID, id.sizeID, id.cost_retail, id.active,nd.display_color,"
           . " cd.category, nd.name, nd.description, fd.flavor, fd.description as flavorDescription, sd.size"
           . " FROM itemDef id, category cd, nameDef nd, flavorDef fd, sizeDef sd"
           . " WHERE id.nameID = " . $nameID
           . " AND id.categoryID = cd.categoryID "
           . " AND id.nameID = nd.nameID "
           . " AND id.flavorID = fd.flavorID "
           . " AND id.sizeID = sd.sizeID "
           . " AND id.active = '1';";
      $this->log->write($sel);
      if(!($dbmgr->query($sel)))
      {
         $this->log->write("Error in $sel" . mysql_error());
         return(false);
      }
      else
      {
         while($row = $dbmgr->fetch_array())
         {
            $anItem = new Item();
            $aFlavor = new Flavor();
            $anItem->sku = $row["SKU"];
            $anItem->displayColor = $row["display_color"];
            $anItem->itemID = $row["itemID"];
            $anItem->categoryID = $row["categoryID"];
            $anItem->nameID = $nameID;
            $aFlavor->id = $row["flavorID"];
            $aFlavor->description = $row["flavorDescription"];
            $aFlavor->name = $row["flavor"];
            $anItem->flavor = $aFlavor;
            $anItem->sizeID = $row["sizeID"];
            $anItem->price = $row["cost_retail"];
            $anItem->active = $row["active"];
            $anItem->category = $row["category"];
            $anItem->name = $row["name"];
            $anItem->description = $row["description"];
            $anItem->size = $row["size"];
            $anItem->log();
            array_push($this->items, $anItem);
         }
         return(true);
      }
   }
}
?>