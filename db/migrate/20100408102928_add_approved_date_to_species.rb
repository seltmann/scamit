class AddApprovedDateToSpecies < ActiveRecord::Migration
  def self.up
    add_column :speciesversions, :approveddate, :datetime
    add_column :speciesversions, :approvedby_id, :integer
  end

  def self.down
    remove_column :speciesversions, :approveddate
    remove_column :speciesversions, :approvedby_id
  end
end
