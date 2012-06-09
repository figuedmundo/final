class AddDescAddressToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :desc, :string
    add_column :places, :address, :string
  end
end
