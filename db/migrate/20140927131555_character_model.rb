class CharacterModel < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :experience
    end
  end
end
