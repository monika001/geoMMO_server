class AddDefaultValueToExperience < ActiveRecord::Migration
  def change
    change_column :characters, :experience, :integer, default: 0, null: false
  end
end
