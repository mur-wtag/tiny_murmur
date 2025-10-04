# frozen_string_literal: true

class Api::FollowsController < ApplicationController
  before_action :set_user

  def create
    follow = Follow.new(follower: current_user, followed: @followed_user)

    if UserPolicy.new(current_user, @followed_user).follow? && follow.save
      render json: { success: true, follower_count: @followed_user.reload.followers.count, follow_id: follow.id }
    else
      render json: { success: false, errors: follow.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.following.destroy(@followed_user)
    render json: { success: true, follower_count: @followed_user.reload.followers.count }
  end

  private

  def set_user
    @followed_user = User.find(params[:user_id])
  end
end
