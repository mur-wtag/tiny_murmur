require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { create(:like) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:murmur) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:user_id).scoped_to(:murmur_id) }
  end
end
