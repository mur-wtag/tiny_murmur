# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(name:, modal_identifier: "modal")
    @name = name
    @modal_identifier = modal_identifier
  end
end
