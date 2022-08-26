class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :chats, dependent: :destroy

  has_one_attached :profile_image

  validates :last_name, length: {in: 1..25}, uniqueness: true
  validates :first_name, length: {in: 1..25}, uniqueness: true
  validates :last_name_kana, length: {in: 1..25}, uniqueness: true
  validates :first_name_kana, length: {in: 1..25}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.first_name = "guest"
      user.last_name = "user"
      user.first_name_kana = "ゲスト"
      user.last_name_kana = "ユーザー"
      user.user_name = "guest"
    end
  end
end
