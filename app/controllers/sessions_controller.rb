# frozen_string_literal: true

class SessionsController < Clearance::SessionsController
  before_action :redirect_signed_in_users, only: :new
  skip_before_action :require_login, only: %i[create new destroy], raise: false

  def create
    @user = authenticate(params)

    sign_in(@user) do |status|
      if status.success?
        redirect_back_or url_after_create
      else
        flash.now.alert = status.failure_message
        render :new, status: :unauthorized
      end
    end
  end

  def destroy
    sign_out
    redirect_to url_after_destroy, status: :see_other
  end

  def new
    render :new, status: :unauthorized
  end

  private

  def redirect_signed_in_users
    if signed_in?
      redirect_to url_for_signed_in_users
    end
  end

  def url_after_create
    products_path
  end

  def url_after_destroy
    Clearance.configuration.url_after_destroy || sign_in_url
  end

  def url_for_signed_in_users
    url_after_create
  end
end
