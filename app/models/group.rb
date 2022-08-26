class Group < ApplicationRecord

  has_many :group_users
  has_many :chats, dependent: :destroy
  has_many :users, through: :group_users, source: :user
  belongs_to :owner, class_name: 'User'
  has_one_attached :group_image

  validates :name, length: {in: 1..50}, presence: true
  validates :introduction, length: {in: 1..250}, presence: true

  def get_group_image
    (group_image.attached?) ? group_image : 'no_image.jpg'
  end

  def is_owned_by?(user)
    owner.id == user.id
  end
  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end

end
