class CreateWays < ActiveRecord::Migration
  def change
    create_table :ways, primary_key: :gid do |t|
      t.string :name
      t.float :dist
      t.integer :source
      t.integer :target
      t.line_string :the_geom, srid: 3785

      t.timestamps
    end
    add_index :ways, :the_geom, spatial: true
    add_index :ways, :source
    add_index :ways, :target
  end
end
