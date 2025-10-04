require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user, password: 'password123') }

  describe 'associations' do
    it { should have_many(:murmurs).with_foreign_key('author_id').dependent(:destroy) }
    it { should have_many(:likes) }
    it { should have_many(:liked_murmurs).through(:likes).class_name('Murmur') }
    it { should have_many(:following_associations).class_name('Follow').with_foreign_key('follower_id').dependent(:destroy) }
    it { should have_many(:following).through(:following_associations).source(:followed) }
    it { should have_many(:follower_associations).class_name('Follow').with_foreign_key('followed_id').dependent(:destroy) }
    it { should have_many(:followers).through(:follower_associations).source(:follower) }
    it { should have_many(:comments).with_foreign_key('author_id') }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
  end

  describe '#full_name' do
    it 'concatenates first and last name' do
      user = build(:user, first_name: 'John', last_name: 'Doe')
      expect(user.full_name).to eq('John Doe')
    end

    it 'returns only first name if last name is nil' do
      user = build(:user, first_name: 'Jane', last_name: nil)
      expect(user.full_name).to eq('Jane')
    end
  end
end
