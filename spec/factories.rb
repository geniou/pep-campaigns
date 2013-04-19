FactoryGirl.define do

  factory :answer do
  end

  factory :contact do
    first_name "Robert"
    last_name "Paulson"
    email "his_name_is@robert.paulson"
    organisation "Project Mayhem"
    website "http://paperstreetsoap.com"
    street_name "Paper Street"
    house_number 221
    birthdate Date.parse("07/07/1969")
    nationality "US"
    sex "m"
  end

  factory :campaign do
    name { 'Campaign' }
    referee_introduction_text { "Please fill in the referee form" }
    required_reference_count 10
  end

  factory :question do
    factory :text_question, class: 'Question::Text' do
      ignore do
        answer nil
        application nil
      end
      after(:create) do |question, evaluator|
        if evaluator.answer
          create(:answer,
                 application_id: evaluator.application.id,
                 text_value: evaluator.answer,
                 question: question
                )
        end
      end
    end
    factory :rate_question, class: 'Question::Rate'
    factory :select_question, class: 'Question::Select'
  end

  factory :reference do
    association :campaign
    association :contact
    association :application
  end

  factory :application do
    association :campaign
    association :contact
  end

  factory :admin do
    sequence(:email) { |n| "email#{n}@example.com" }
    password { 'ecertv5634v5zfv345t' }
  end
end
