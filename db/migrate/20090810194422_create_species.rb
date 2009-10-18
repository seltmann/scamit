class CreateSpecies < ActiveRecord::Migration
  def self.up
    create_table :species , :options=>"DEFAULT CHARSET utf8" do |t|
      t.integer :sort_id
      t.integer :scamit_id
      t.string :phylum
      t.string :subphylum
      t.string :theclass
      t.string :subclass
      t.string :infraclass
      t.string :superorder
      t.string :order
      t.string :suborder
      t.string :infraorder
      t.string :superfamily
      t.string :family
      t.string :subfamily
      t.string :genus
      t.string :subgenus
      t.string :species
      t.string :describer
      t.boolean :red
      t.boolean :bold
      t.boolean :nonstandarditalic
      t.boolean :authorred
      t.boolean :subgenusred
      
      t.timestamps
    end
    
      create_table :speciesversions , :options=>"DEFAULT CHARSET utf8" do |t|
        t.integer :sort_id
        t.integer :scamit_id
        t.string :phylum
        t.string :subphylum
        t.string :theclass
        t.string :subclass
        t.string :infraclass
        t.string :superorder
        t.string :order
        t.string :suborder
        t.string :infraorder
        t.string :superfamily
        t.string :family
        t.string :subfamily
        t.string :genus
        t.string :subgenus
        t.string :species
        t.string :describer
        t.boolean :red
        t.boolean :bold
        t.boolean :nonstandarditalic
        t.boolean :authorred
        t.boolean :subgenusred
        t.integer :parent_id
        t.references :user
        t.boolean :approved, :null => :yes, :default => 0
        t.timestamps
      end
      
      
  end
  
  def self.down
    drop_table :species
    drop_table :speciesversions
  end
end