FactoryGirl.define do

  factory :reference do
  end

  factory :application do
  end

  factory :campaign do
    name { 'Campaign' }
  end

  factory :admin do
    sequence(:email) { |n| "email#{n}@example.com" }
    password { 'ecertv5634v5zfv345t' }
  end
end
