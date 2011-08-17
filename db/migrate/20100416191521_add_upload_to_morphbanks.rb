class AddUploadToMorphbanks < ActiveRecord::Migration
  def self.up
    add_column :morphbanks, :upload_id, :integer
  end

  def self.down
    remove_column :morphbanks, :upload_id
  end
end
