# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    user.present?
  end

  def me?
    user.present?
  end

  def follow?
    record.id != user.id
  end
end
