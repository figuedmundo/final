class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.point :latlng, :srid => 3785 

      t.timestamps
    end
    change_table :places do |t|
      t.index :latlng, :spatial => true 
    end
  end
end
