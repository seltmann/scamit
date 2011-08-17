class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true, :options=>"DEFAULT CHARSET utf8"  do |t|
      t.column :login,                     :string, :limit => 40
      t.column :name,                      :string, :limit => 100, :default => '', :null => true
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :address,                   :string, :limit => 255
      t.column :phone,                     :string, :limit => 16
      t.column :affiliation,               :string, :limit => 40
      t.column :role,                      :integer, :null => :no, :default => 1
      t.column :title,                     :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      t.column :activation_code,           :string, :limit => 40
      t.column :activated_at,              :datetime
      t.column :state,                     :string, :null => :no, :default => 'passive'
      t.column :deleted_at,                :datetime
    end
    add_index :users, :login, :unique => true
  end

  def self.down
    drop_table "users"
  end
end
