# frozen_string_literal: true

class UsersController < Clearance::UsersController
  before_action :require_login, only: %i[show me]
  before_action :set_user, only: %i[show me]

  def show; end

  def me
    render :show
  end

  private

  def set_user
    @user = action_name == "me" ? current_user : User.find(params[:id])
    assign_murmurs

    authorize @user, "#{action_name}?".to_sym
  end

  def assign_murmurs
    scope = @user.murmurs.order(created_at: :desc)
    @murmurs = scope.paginate(page: params[:page], per_page: 10)
  end

  def user_params
    params
      .require(:user)
      .permit(:email, :password, :first_name, :last_name)
  end
end
