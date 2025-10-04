# frozen_string_literal: true

class Api::LikesController < ApplicationController
  def create
    murmur = Murmur.find(params[:murmur_id])
    like = murmur.likes.build(user: current_user)
    if MurmurPolicy.new(current_user, murmur).like? && like.save
      render json: { success: true, likes_count: murmur.reload.likes_count }
    else
      render json: { success: false, errors: like.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    murmur = Murmur.find(params[:murmur_id])
    like = murmur.likes.find_by(user: current_user)
    like&.destroy
    render json: { success: true, likes_count: murmur.likes.count }
  end
end
