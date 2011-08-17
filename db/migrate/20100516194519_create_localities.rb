class CreateLocalities < ActiveRecord::Migration
  def self.up
    create_table :localities do |t|
      t.string :station_id
      t.string :stratum
      t.string :stratum_secondary
      t.float :lat
      t.float :lng
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :localities
  end
end