class AddSpeciesNameToMorphbanks < ActiveRecord::Migration
  def self.up
    add_column :morphbanks, :species_name, :string
  end

  def self.down
    remove_column :morphbanks, :species_name
  end
end
