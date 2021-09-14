class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ユーザのフォロワーを引っ張り出すためのアソシエーション
  has_many :followers_relationships,
  class_name: "Relationship",
  foreign_key: "followed_id",
  dependent: :destroy

  has_many :followers,
  through: :followers_relationships,
  source: :follower

  # ユーザがフォローしている人を引っ張り出すためのアソシエーション
  has_many :following_relationships,
  class_name: "Relationship",
  foreign_key: "follower_id",
  dependent: :destroy

  has_many :followings,
  through: :following_relationships,
  source: :followed

  # フォローする人のidを引数に渡す(自分のidはPKのように作成時自動で入る。多分)
  def follow(user_id)
    following_relationships.create(followed_id: user_id)
  end
 # フォローを外す人のidを引数に渡す
  def unfollow(user_id)
    following_relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
