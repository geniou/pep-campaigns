FactoryGirl.define do

  factory :reference do
  end

  factory :application do
  end

  factory :campaign do
    name { 'Campaign' }
  end

  factory :question do
    factory :application_question, class: Question::Application
    factory :reference_question, class: Question::Reference
  end

  factory :admin do
    sequence(:email) { |n| "email#{n}@example.com" }
    password { 'ecertv5634v5zfv345t' }
  end
end
