# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  remember_token  :string(255)
#  name            :string(255)
#  last_name       :string(255)
#  admin           :boolean         default(FALSE)
#  avatar          :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :password , :password_confirmation, :name, :last_name, :avatar
  has_many :comments
  has_many :places
  has_secure_password
  
  mount_uploader :avatar, AvatarUploader

  before_save { |user| user.email     = email.downcase }
  before_save { |user| user.name      = name.titleize }
  before_save { |user| user.last_name = last_name.titleize }
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,          presence: { message: "no puede estar en blanco"},
                            length: { maximum: 30, message: "maximo %{count} letras" }

  validates :last_name,     presence: { message: "no puede estar en blanco"},
                            length: { maximum: 30, message: "maximo %{count} letras" }

  validates :email,     presence: { message: "no puede estar en blanco"},
                        format: { with: VALID_EMAIL_REGEX, message: "no es un email valido" },
                        uniqueness: { case_sensitive: true, message: "este email ya esta en 
                          nuestra base de datos"}


  validates :password,  presence: { message: "no puede estar en blanco"},
                        length: { minimum: 6, message: "minimo %{count} letras" },
                        on: :create

  validates :password_confirmation, presence: { message: "no puede estar en blanco"},
                                    on: :create


  def full_name
    "#{self.name} #{self.last_name}"
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
