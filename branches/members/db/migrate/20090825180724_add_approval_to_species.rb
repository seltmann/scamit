class AddApprovalToSpecies < ActiveRecord::Migration
  def self.up
    add_column :species, :approveddate, :datetime
    add_column :species, :approvedby, :integer
  end

  def self.down
    remove_column :species, :approvedby
    remove_column :species, :approveddate
  end
end
