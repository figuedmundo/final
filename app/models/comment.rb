class Comment < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: { message: "No puede estar en blanco" },
                      length: { maximum: 2000, message: "Demasiado largo, solamente %{count} letras" }
                      

end
