class CreateIngredients < ActiveRecord::Migration
  def self.up
    create_table :ingredients do |t|
       t.integer :order_num
      t.integer :measurement_id
      t.integer :grocery_id
      t.integer :recipe_id
      t.timestamps
    end
  end

  def self.down
    drop_table :ingredients
  end
end
