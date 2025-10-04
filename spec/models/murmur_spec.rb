require 'rails_helper'

RSpec.describe Murmur, type: :model do
  describe 'associations' do
    it { should have_many(:likes) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should belong_to(:author).class_name('User') }
  end

  describe '#liked_by' do
    it 'returns likes for a specific user' do
      author = create(:user)
      user = create(:user)
      murmur = create(:murmur, author:)
      like = create(:like, user:, murmur:)

      expect(murmur.liked_by(user)).to include(like)
      expect(murmur.liked_by(author)).to be_empty
    end
  end
end
