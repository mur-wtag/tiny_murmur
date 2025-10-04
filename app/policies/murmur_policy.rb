# frozen_string_literal: true

class MurmurPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def new?
    index?
  end

  def create?
    index?
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

  def like?
    record.author_id != user.id
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
