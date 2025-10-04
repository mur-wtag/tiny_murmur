# frozen_string_literal: true

class MurmursController < ApplicationController
  before_action :set_murmur, only: %i[edit update destroy]
  before_action :ensure_frame_response, only: %i[new edit]

  def index
    authorize :murmur, :index?
    scope = policy_scope(
      Murmur,
      policy_scope_class: MurmurPolicy::Scope
    ).includes(:author, :likes, :comments).order(created_at: :desc).order(created_at: :desc)

    @murmurs = scope.paginate(page: params[:page], per_page: 10)
  end

  def new
    @murmur = current_user.murmurs.new
  end

  def edit; end

  # rubocop:disable Metrics/AbcSize
  def create
    @murmur = current_user.murmurs.new(murmur_params)

    respond_to do |format|
      if @murmur.save
        flash.now[:notice] = "Murmur was successfully created."

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend(
              "murmurs", # this matches the tbody ID
              partial: "murmurs/murmur",
              locals: { murmur: @murmur }
            ),
            turbo_stream.replace("flash", partial: "shared/flash")
          ]
        end
        format.html { redirect_to murmur_url(@murmur), notice: "Murmur was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @murmur.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/AbcSize
  def update
    respond_to do |format|
      if @murmur.update(murmur_params)
        flash.now[:notice] = "Murmur was successfully updated."

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              @murmur,
              partial: "murmurs/murmur",
              locals: { murmur: @murmur }
            ),
            turbo_stream.replace("flash", partial: "shared/flash")
          ]
        end
        format.html { redirect_to murmur_url(@murmur), notice: "Murmur was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @murmur.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  def destroy
    @murmur.destroy
    flash.now[:alert] = "Murmur was successfully destroyed."

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@murmur),
          turbo_stream.replace("flash", partial: "shared/flash")
        ]
      end
      format.html { redirect_to murmurs_url, notice: "Murmur was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_murmur
    @murmur = policy_scope(Murmur).find(params[:id])
    authorize @murmur, "#{action_name}?".to_sym
  end

  def ensure_frame_response
    return unless Rails.env.development?
    redirect_to root_path unless turbo_frame_request?
  end

  def murmur_params
    params
      .require(:murmur)
      .permit(
        :content
      )
  end
end
