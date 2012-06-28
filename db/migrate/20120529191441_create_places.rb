class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.point :coord, :srid => 3785 

      t.timestamps
    end
    change_table :places do |t|
      t.index :coord, :spatial => true 
    end
  end
end
