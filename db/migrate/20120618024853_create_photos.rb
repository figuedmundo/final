class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :desc
      t.integer :place_id
      t.integer :user_id

      t.timestamps
    end
  end
end
