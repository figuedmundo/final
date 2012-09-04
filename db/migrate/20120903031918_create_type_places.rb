class CreateTypePlaces < ActiveRecord::Migration
  def change
    create_table :type_places do |t|
      t.string :name

      t.timestamps
    end
    add_index :type_places, :name, unique: true
  end
end
