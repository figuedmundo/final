class User < ActiveRecord::Base
  attr_accessible :email, :password , :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,     presence: { message: "no puede estar en blanco"},
                        format: { with: VALID_EMAIL_REGEX, message: "no es un email valido" },
                        uniqueness: { case_sensitive: true, message: "este email ya esta en 
                          nuestra base de datos"}


  validates :password,  presence: { message: "no puede estar en blanco"},
                        length: { minimum: 6, message: "minimo %{count} letras" },
                        on: :create

  validates :password_confirmation, presence: { message: "no puede estar en blanco"},
                                    on: :create


  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
