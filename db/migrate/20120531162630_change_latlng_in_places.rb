class ChangeLatlngInPlaces < ActiveRecord::Migration
  def change
    rename_column :places, :latlng, :coord
    rename_index  :places, 'index_places_on_latlng', 'index_places_on_coord'
  end

end
