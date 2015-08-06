<?php
//require_once("DB_Mgr.inc");
require_once("Secretary.inc");
class Item
{
   var $sku;
   var $itemID;
   var $categoryID;
   var $nameID;
   var $sizeID;
   var $price;
   var $active;
   var $category;
   var $name;
   var $description;
   var $flavor;
   var $size;
   var $displayColor;
   
   function log()
   {
      $this->log->write("sku = " . $this->sku . "\n" .
                        "itemID = " . $this->itemID . "\n" .
                        "categoryID = " . $this->categoryID . "\n" .
                        "nameID = " . $this->nameID . "\n" .
                        "sizeID = " . $this->sizeID . "\n" .
                        "price = " . $this->price . "\n" .
                        "active = " . $this->active . "\n" .
                        "category = " . $this->category . "\n" .
                        "name = " . $this->name . "\n" .
                        "description = " . $this->description . "\n" .
                        "flavorID = " . $this->flavor->id . "\n" .
                        "flavorName = " . $this->flavor->name . "\n" .
                        "flavorDescription = " . $this->flavor->description . "\n" .
                        "size = " . $this->size . "\n" .
                        "displayColor = " . $this->displayColor);
   }
   
   var $log;
   
   function Item()
   {
      $this->log = new Secretary();
   }
   /*
   function dbLoadViaSKU($dbmgr)
   {
      $sel = "SELECT id.itemID, id.itemID, id.categoryID, id.nameID, id.flavorID, id.sizeID, id.cost_retail, id.active,"
           . " cd.category, nd.name, nd.description, fd.flavor, fd.description as flavorDescription, sd.size"
           . " FROM itemDef id, category cd, nameDef nd, flavorDef fd, sizeDef sd"
           . " WHERE id.itemID = " . $this->itemID
           . " AND id.categoryID = cd.categoryID "
           . " AND id.nameID = nd.nameID "
           . " AND id.flavorID = fd.flavorID "
           . " AND id.sizeID = sd.sizeID;";
      if(!($dbmgr->query($sel)))
      {
         $this->log->write("Error in $sel");
         return(false);
      }
      else
      {
         while($row = $dbmgr->fetch_array())
         {
            $this->sku = $row["SKU"];
            $this->itemID = $row["itemID"];
            $this->categoryID = $row["categoryID"];
            $this->nameID = $row["nameID"];
            array_push($this->flavorIDs, $row["flavorID"]);
            array_push($this->flavorDescriptions, $row["flavorDescription"]);
            //$this->flavorID = $row["flavorID"];
            $this->sizeID = $row["sizeID"];
            $this->price = $row["cost_retail"];
            $this->active = $row["active"];
            $this->category = $row["category"];
            $this->name = $row["name"];
            $this->description = $row["description"];
            array_push($this->flavors, $row["flavor"]);
            //$this->flavor = $row["flavor"];
            $this->size = $row["size"];
         }
         return(true);
      }
   }
   */
}
?>