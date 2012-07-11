object  @place
attributes :id, :name, :desc, :address

node(:lng) { |place| place.coord_geographic.x }
node(:lat) { |place| place.coord_geographic.y }