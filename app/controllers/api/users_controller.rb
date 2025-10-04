# frozen_string_literal: true

class Api::UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: {
      id: user.id,
      name: user.name,
      followCount: user.following.count,
      followedCount: user.followers.count,
      murmurs: user.murmurs.order(created_at: :desc)
    }
  end
end
