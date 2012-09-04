class AddTypeToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :type_place_id, :integer
    add_index :places, :type_place_id
  end
end
