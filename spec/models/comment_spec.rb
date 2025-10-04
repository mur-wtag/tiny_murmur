require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:murmur) }
    it { should belong_to(:author).class_name('User') }
  end
end
