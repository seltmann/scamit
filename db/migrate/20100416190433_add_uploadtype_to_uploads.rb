class AddUploadtypeToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :uploadtype, :string, :default => 'morphbank', :null => false
  end

  def self.down
    remove_column :uploads, :uploadtype
  end
end
