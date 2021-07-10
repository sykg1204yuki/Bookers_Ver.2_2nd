class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #ここからフォロー・フォロワー機能アソシエーション
  has_many :active_relationships, class_name:"Relationship", foreign_key: :following_id, dependent: :destroy
           #↑↑自由に設定可能↑↑         ↑↑ここで参照モデル↑↑         ↑↑ここで参照カラム↑↑
  has_many :followings, through: :active_relationships, source: :follower
    #「user」テーブルのid（フォローする人）
    #　→中間テーブル「Relationship」の「following_id(FK) == user.id」から「follower_id(Fk)」を取得
    #  →「follower_id」==「user.id」なので「user」テーブルのid（フォローされている人）を取得

  has_many :passive_relationships, class_name:"Relationship", foreign_key: :follower_id, dependent: :destroy

  has_many :followers, through: :passive_relationships, source: :following
  #アソシエーションここまで

  #ここからフォロー・フォロワー機能で使用するメソッドの定義
  def follow(user_id)
    active_relationships.create(follower_id: user_id)
    #byebug
      #relationship = Relationship.new(followed_id: user_id)
      #relationship.save  #の省略形
      #createはnewとsaveを合わせた挙動をする

  end

  def unfollow(user_id)
    active_relationships.find_by(follower_id: user_id).destroy

  end

  def followings?(user)
    followings.include?(user)

  end
  #メソッド定義ここまで




  attachment :profile_image

  validates :name, uniqueness: true, length: {in: 2..20}
  validates :introduction, length: {maximum: 50}


end
