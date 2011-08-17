class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.string :upload_file_name
      t.integer :upload_file_size
      t.string :upload_content_type
      t.datetime :upload_created_at
      t.references :user
      t.string :comment
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :uploads
  end
end