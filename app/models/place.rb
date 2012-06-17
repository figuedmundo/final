# == Schema Information
#
# Table name: places
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  coord      :spatial({:no_co
#  desc       :string(255)
#  address    :string(255)
#  user_id    :integer
#

class Place < ActiveRecord::Base
  attr_accessible :name, :lat, :lng, :desc, :address
  belongs_to :user
  has_many :comments
  attr_accessor :lat, :lng

  before_save :create_coord


  FACTORY = RGeo::Geographic.simple_mercator_factory
  set_rgeo_factory_for_column(:coord, FACTORY.projection_factory)

  before_save { |place| place.name = name.downcase }
  validates :name,  uniqueness: { case_sensitive: true, message: "este nombre ya esta en uso" },
                    presence: { message: "no puede estar en blanco"}

  validates :lat,   numericality: true,
                    length: { maximum: 25 },
                    on: :create


  validates :lng,   numericality: true,
                    length: { maximum: 25 },                                    
                    on: :create
  
  validates :address, length: { maximum: 35, message: "muy largo, solo %{count} letras" }
  validates :desc,    length: { maximum: 250, message: "muy largo, solo %{count} letras" }

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


  private

    def create_coord
      self.coord = FACTORY.point(lat, lng).projection
    end

end

