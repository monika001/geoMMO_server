class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :latitude, default: 0
      t.float :longitude, default: 0
      t.integer :area, default: -1

      t.timestamps
    end
  end
end
