FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }

    trait :with_author do
      association :author
    end
  end
end
