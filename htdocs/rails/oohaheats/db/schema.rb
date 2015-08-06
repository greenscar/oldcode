# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "categories", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "categorizations", :id => false, :force => true do |t|
    t.integer  "category_id", :null => false
    t.integer  "recipe_id",   :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "categorizations", ["category_id"], :name => "fk_category_assign_categories"
  add_index "categorizations", ["recipe_id"], :name => "fk_category_assign_recipes"

  create_table "groceries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", :force => true do |t|
    t.integer  "order_num",      :null => false
    t.integer  "measurement_id"
    t.integer  "grocery_id",     :null => false
    t.integer  "recipe_id",      :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "ingredients", ["grocery_id"], :name => "fk_ingredients_groceries"
  add_index "ingredients", ["measurement_id"], :name => "fk_ingredients_measurements"
  add_index "ingredients", ["recipe_id"], :name => "fk_ingredients_recipes"

  create_table "measurements", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "rating",                   :null => false
    t.datetime "datetime",                 :null => false
    t.string   "ip",         :limit => 45, :null => false
    t.integer  "recipe_id",                :null => false
    t.text     "comment"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "ratings", ["recipe_id"], :name => "fk_ratings_recipes"

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "active",     :default => true, :null => false
  end

  create_table "security_lvls", :force => true do |t|
    t.string   "name",       :limit => 45, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "security_users", :force => true do |t|
    t.string  "name",            :limit => 45
    t.string  "password",        :limit => 192
    t.string  "created_at",      :limit => 45
    t.string  "updated_at",      :limit => 45
    t.integer "security_lvl_id",                :null => false
  end

  add_index "security_users", ["security_lvl_id"], :name => "fk_security_users_security_lvls"

  create_table "steps", :force => true do |t|
    t.integer  "order_num",   :null => false
    t.text     "instruction", :null => false
    t.integer  "recipe_id",   :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "steps", ["recipe_id"], :name => "fk_steps_recipes"

  create_table "trackings", :force => true do |t|
    t.string   "ip",         :limit => 45
    t.integer  "recipe_id",                :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "trackings", ["recipe_id"], :name => "fk_views_recipes"

end
