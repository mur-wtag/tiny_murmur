FactoryBot.define do
  factory :comment do
    body { "Nice post!" }
    association :author, factory: :user
    association :murmur
  end
end
