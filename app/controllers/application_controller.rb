# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Pundit::Authorization

  before_action :require_login

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
end
