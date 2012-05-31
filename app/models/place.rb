# == Schema Information
#
# Table name: places
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  coord      :spatial({:no_co
#

class Place < ActiveRecord::Base
  attr_accessible :coord, :name


  FACTORY = RGeo::Geographic.simple_mercator_factory
  set_rgeo_factory_for_column(:coord, FACTORY.projection_factory)

  before_save { |place| place.name = name.downcase }
  validates :name,  uniqueness: { case_sensitive: true, message: "este nombre ya esta en uso" }

  # To interact in projected coordinates, just use the "coord"
  # attribute directly.
  # def latlng_projected
  #   self.coord
  # end
  # def latlng_projected=(value)
  #   self.coord = value
  # end

  # To use geographic (lat/lon) coordinates, convert them using
  # the wrapper factory.
  def coord_geographic
    FACTORY.unproject(self.coord)
  end
  def coord_geographic=(value)
    self.coord = FACTORY.project(value)
  end

end

