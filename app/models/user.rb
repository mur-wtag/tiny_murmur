# frozen_string_literal: true

class User < ApplicationRecord
  include Clearance::User

  has_many :murmurs, foreign_key: "author_id", dependent: :destroy

  has_many :likes
  has_many :liked_murmurs, through: :likes, source: :murmur, class_name: "Murmur"

  has_many :following_associations, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :following_associations, source: :followed

  has_many :follower_associations, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :follower_associations, source: :follower

  has_many :comments, foreign_key: :author_id

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  def full_name
    [ first_name, last_name ].compact.join(" ")
  end
end
