require 'rails_helper'

RSpec.describe Follow, type: :model do
  subject { create(:follow) }  # ✅ ensure valid record exists

  describe 'associations' do
    it { should belong_to(:follower).class_name('User') }
    it { should belong_to(:followed).class_name('User') }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:follower_id).scoped_to(:followed_id) }
  end
end
