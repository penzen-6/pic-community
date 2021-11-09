class Post < ApplicationRecord
    has_many_attached :images
    belongs_to :user
    has_many :comments
    has_many :likes
end
