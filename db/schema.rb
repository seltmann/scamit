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

ActiveRecord::Schema.define(:version => 20090825180724) do

  create_table "species", :force => true do |t|
    t.integer  "sort_id"
    t.integer  "scamit_id"
    t.string   "phylum"
    t.string   "subphylum"
    t.string   "theclass"
    t.string   "subclass"
    t.string   "infraclass"
    t.string   "superorder"
    t.string   "order"
    t.string   "suborder"
    t.string   "infraorder"
    t.string   "superfamily"
    t.string   "family"
    t.string   "subfamily"
    t.string   "genus"
    t.string   "subgenus"
    t.string   "species"
    t.string   "describer"
    t.boolean  "red"
    t.boolean  "bold"
    t.boolean  "nonstandarditalic"
    t.boolean  "authorred"
    t.boolean  "subgenusred"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "approveddate"
    t.integer  "approvedby"
  end

  create_table "speciesversions", :force => true do |t|
    t.integer  "sort_id"
    t.integer  "scamit_id"
    t.string   "phylum"
    t.string   "subphylum"
    t.string   "theclass"
    t.string   "subclass"
    t.string   "infraclass"
    t.string   "superorder"
    t.string   "order"
    t.string   "suborder"
    t.string   "infraorder"
    t.string   "superfamily"
    t.string   "family"
    t.string   "subfamily"
    t.string   "genus"
    t.string   "subgenus"
    t.string   "species"
    t.string   "describer"
    t.boolean  "red"
    t.boolean  "bold"
    t.boolean  "nonstandarditalic"
    t.boolean  "authorred"
    t.boolean  "subgenusred"
    t.integer  "parent_id"
    t.integer  "user_id"
    t.boolean  "approved",          :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "synonyms", :force => true do |t|
    t.integer  "old_id"
    t.integer  "species_id"
    t.integer  "scamit_id"
    t.string   "genus"
    t.string   "species"
    t.string   "describer"
    t.datetime "dateadded"
    t.text     "comments"
    t.integer  "specieslistsort_id"
    t.boolean  "chkgenred"
    t.boolean  "chkspred"
    t.boolean  "chkauth"
    t.datetime "approveddate"
    t.integer  "approvedby_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "synonyms", ["species_id"], :name => "index_synonyms_on_species_id"

  create_table "synonymversions", :force => true do |t|
    t.integer  "old_id"
    t.integer  "species_id"
    t.integer  "scamit_id"
    t.string   "genus"
    t.string   "species"
    t.string   "describer"
    t.datetime "dateadded"
    t.text     "comments"
    t.integer  "specieslistsort_id"
    t.boolean  "chkgenred"
    t.boolean  "chkspred"
    t.boolean  "chkauth"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.boolean  "approved",           :default => false
    t.datetime "approveddate"
    t.integer  "approvedby_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "synonymversions", ["species_id"], :name => "index_synonymversions_on_species_id"
  add_index "synonymversions", ["user_id"], :name => "index_synonymversions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "address"
    t.string   "phone",                     :limit => 16
    t.string   "affiliation",               :limit => 40
    t.integer  "role",                                     :default => 1
    t.string   "title",                     :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
