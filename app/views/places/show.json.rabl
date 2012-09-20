object  @place
attributes :id, :name, :desc, :address

node(:type) { |place| place.type_place.name }
node(:lng) { |place| place.coord_geographic.x }
node(:lat) { |place| place.coord_geographic.y }

child :photos do 
  attributes :id, :desc
  node(:url) { |photo| photo.image.url(:square) }
  # node(:url_large) { |photo| photo.image.url }
end