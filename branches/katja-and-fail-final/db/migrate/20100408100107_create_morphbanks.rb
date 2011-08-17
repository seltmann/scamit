class CreateMorphbanks < ActiveRecord::Migration
  def self.up
    create_table :morphbanks do |t|
      t.references :species
      t.integer :morphbank_code
      t.string :scamit_unique_id
      t.text :notes
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :morphbanks
  end
end