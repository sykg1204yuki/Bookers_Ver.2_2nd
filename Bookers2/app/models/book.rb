class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites,  dependent: :destroy
  has_many :comments, dependent: :destroy
  
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
    # 例：user = User.find(1)
    #     favorites.where(user_id: 1).exists? 
    #       => Userテーブル内の『id="1"(PK)』が、Favoriteテーブル内のuser_idカラム内に存在しているか？
  end 

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}


end
