class RenameSpecies < ActiveRecord::Migration
  def self.up
    rename_column :synonyms, :species, :the_species
  end

  def self.down
    rename_column :synonyms, :the_species, :species
  end
end
