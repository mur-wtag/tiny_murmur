# frozen_string_literal: true

class Api::MurmursController < ApplicationController
  before_action :set_murmur, only: [ :show, :destroy ]

  def index
    murmurs = Murmur.includes(:author, :likes).order(created_at: :desc).page(params[:page]).per(10)
    render json: murmurs.as_json(include: { user: { only: [ :id, :name ] }, likes: { only: [ :id ] } }, methods: [ :likes_count ])
  end

  def show
    render json: @murmur
  end

  def create
    murmur = current_user.murmurs.build(murmur_params)
    if murmur.save
      render json: murmur, status: :created
    else
      render json: murmur.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @murmur.user == current_user
      @murmur.destroy
      head :no_content
    else
      head :forbidden
    end
  end

  private

  def set_murmur
    @murmur = Murmur.find(params[:id])
  end

  def murmur_params
    params.require(:murmur).permit(:content)
  end
end
