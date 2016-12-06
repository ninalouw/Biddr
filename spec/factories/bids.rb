FactoryGirl.define do
  factory :bid do
    association :user
    association :auction
    bid_amount { rand(100) + 1 }
  end
end
