class Post < ApplicationRecord

  belongs_to user

  validates :body, length: {in: 1..200}, presence:true

  has_one_attached :image

end
