class AddCommonnameToSpecies < ActiveRecord::Migration
  def self.up
    add_column :species, :common_name, :string
  end

  def self.down
    remove_column :species, :common_name
  end
end
