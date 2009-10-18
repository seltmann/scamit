class CreateSynonyms < ActiveRecord::Migration
  def self.up
    create_table :synonyms , :options=>"DEFAULT CHARSET utf8"do |t|
      t.integer :old_id
      t.references :species
      t.integer :scamit_id
      t.string :genus
      t.string :species
      t.string :describer
      t.datetime :dateadded
      t.text :comments
      t.integer :specieslistsort_id
      t.boolean :chkgenred
      t.boolean :chkspred
      t.boolean :chkauth
      t.datetime :approveddate
      t.references :approvedby
      t.timestamps
    end
    
    create_table :synonymversions , :options=>"DEFAULT CHARSET utf8" do |t|
      t.integer :old_id
      t.references :species
      t.integer :scamit_id
      t.string :genus
      t.string :species
      t.string :describer
      t.datetime :dateadded
      t.text :comments
      t.integer :specieslistsort_id
      t.boolean :chkgenred
      t.boolean :chkspred
      t.boolean :chkauth
      t.references :user
      t.integer :parent_id
      t.boolean :approved, :null => :yes, :default => 0
      t.datetime :approveddate
      t.references :approvedby
      t.timestamps
    end
    
    
    add_index :synonyms, :species_id
    add_index :synonymversions, :species_id
    add_index :synonymversions, :user_id
  end
  
  def self.down
    drop_table :synonyms
    drop_table :synonymversions
  end
end