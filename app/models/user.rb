class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :comments
  has_many :post, dependent: :destroy
  has_many :likes
  def liked_by?(post_id)
    likes.where(post_id: post_id).exists?
  end
  
  delegate :name, :learning_history, :purpose, :image, to: :profile
end