class Post < ApplicationRecord

  belongs_to :user
  has_many :post_hashtags, dependent: :destroy
  has_many :hashtags, through: :post_hashtags

  validates :body, length: {in: 1..200}, presence:true

  has_one_attached :image

  #作成
  after_create do
    post = Post.find_by(id: id)
    # hashbodyに打ち込まれたハッシュタグを検出
    hashtags = tag_body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      # ハッシュタグは先頭の#を外した上で保存
      tag = Hashtag.find_or_create_by(tag_name: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end
  #更新
  before_update do
    post = Post.find_by(id: id)
    post.hashtags.clear
    hashtags = tag_body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(tag_name: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end

end
