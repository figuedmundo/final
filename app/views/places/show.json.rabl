object  @place
attributes :id, :name

node(:lat) { |place| place.coord_geographic.x }
node(:lng) { |place| place.coord_geographic.y }