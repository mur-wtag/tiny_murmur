# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :murmur
  belongs_to :author, class_name: "User"
end
