# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    new?
  end

  def edit?
    record.author_id == user.id
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
