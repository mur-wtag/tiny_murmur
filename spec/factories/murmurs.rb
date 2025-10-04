FactoryBot.define do
  factory :murmur do
    content { "Hello world" }
    association :author, factory: :user
  end
end
