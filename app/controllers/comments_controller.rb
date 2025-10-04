# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_murmur
  before_action :set_comment, only: %i[edit update destroy]
  before_action :ensure_frame_response, only: %i[new edit]

  def new
    @comment = current_user.comments.new
    @comment.murmur = @murmur
  end

  def edit; end

  # rubocop:disable Metrics/AbcSize
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.murmur = @murmur

    respond_to do |format|
      if @comment.save
        flash.now[:notice] = "Comment was successfully created."

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend(
              "murmur-#{@murmur.id}-comments",
              partial: "comments/comment",
              locals: { comment: @comment }
            ),
            turbo_stream.replace("flash", partial: "shared/flash")
          ]
        end
        format.html { redirect_to murmur_comment_path(@comment), notice: "Comment was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/AbcSize
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        flash.now[:notice] = "Comment was successfully updated."

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              @comment,
              partial: "comments/comment",
              locals: { comment: @comment }
            ),
            turbo_stream.replace("flash", partial: "shared/flash")
          ]
        end
        format.html { redirect_to murmur_comment_path(@comment), notice: "Comment was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  def destroy
    @comment.destroy
    flash.now[:alert] = "Comment was successfully destroyed."

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@comment),
          turbo_stream.replace("flash", partial: "shared/flash")
        ]
      end
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
    end
  end

  private

  def set_murmur
    @murmur = policy_scope(Murmur).find(params[:murmur_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = policy_scope(Comment).find(params[:id])
    authorize @comment, "#{action_name}?".to_sym
  end

  def ensure_frame_response
    return unless Rails.env.development?
    redirect_to root_path unless turbo_frame_request?
  end

  def comment_params
    params
      .require(:comment)
      .permit(
        :content
      )
  end
end
