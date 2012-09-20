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
  attr_accessible :name, :lat, :lon, :desc, :address, :type_place_id
  belongs_to :user
  has_many :comments
  has_many :photos
  belongs_to :type_place

  attr_accessor :lat, :lon

  # before_save { |place| place.coord = FACTORY.point(lon, lat).projection if place.new_record? }

  include PgSearch
  pg_search_scope :search, against: [:name, :desc, :address],
                          using: {tsearch: {dictionary: "spanish"}},
                          associated_against: { type_place: :name }


  FACTORY = RGeo::Geographic.simple_mercator_factory
  set_rgeo_factory_for_column(:coord, FACTORY.projection_factory)

  before_save :create_coord
  before_save { |place| place.name = name.downcase }

  validates :name,  uniqueness: { case_sensitive: true, message: "este nombre ya esta en uso" },
                    presence: { message: "no puede estar en blanco"}

  validates :lat,   numericality: true,
                    length: { maximum: 25 },
                    on: :create


  validates :lon,   numericality: true,
                    length: { maximum: 25 },                                    
                    on: :create
  
  validates :address, length: { maximum: 35, message: "muy largo, solo %{count} letras" }
  validates :desc,    length: { maximum: 250, message: "muy largo, solo %{count} letras" }
  validates :type_place_id, presence: { message: "no puedes saltarte esto"}

  # To interact in projected coordinates, just use the "coord"
  # attribute directly.
  # def coord_projected
  #   self.coord
  # end
  # def coord_projected=(value)
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


  def self.text_search(query)
    if query.present?
      # where("name ilike :q  or  desc  ilike  :q", q: "%#{query}")
      search(query)
    else
      scoped
    end
  end


  private

    def create_coord
      if self.new_record?
        self.coord = FACTORY.point(lon, lat).projection 
      else
        p self.coord
      end
    end

end

