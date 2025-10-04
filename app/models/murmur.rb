# frozen_string_literal: true

class Murmur < ApplicationRecord
  has_many :likes
  has_many :comments, dependent: :destroy

  belongs_to :author, class_name: "User"

  def liked_by(user)
    likes.where(user_id: user.id)
  end
end
