# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  id_place   :integer
#

class Comment < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  belongs_to :place

  validates :user_id, presence: true
  validates :content, presence: { message: "No puede estar en blanco" },
                      length: { maximum: 2000, message: "Demasiado largo, solamente %{count} letras" }
                      

end
