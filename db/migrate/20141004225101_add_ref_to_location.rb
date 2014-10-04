class AddRefToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :character_id, :integer
    add_index :locations, :character_id
  end
end
