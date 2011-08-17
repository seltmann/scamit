class CreateSamples < ActiveRecord::Migration
  def self.up
    create_table :samples do |t|
      t.datetime :sample_date
      t.references :species
      t.references :locality
      t.integer :occurence

      t.timestamps
    end
  end

  def self.down
    drop_table :samples
  end
end
