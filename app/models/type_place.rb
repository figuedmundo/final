# == Schema Information
#
# Table name: type_places
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class TypePlace < ActiveRecord::Base
  attr_accessible :name
  has_many :places


  before_save { |tp| tp.name = name.downcase }

  validates :name,  presence: { message: "no puede estar en blanco"},
                    length: { maximum: 20, message: "maximo %{count} letras" },
                    uniqueness: { case_sensitive: true, message: "este nombre ya esta en nuestra base de datos"}
end
