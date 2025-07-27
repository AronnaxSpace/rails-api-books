FactoryBot.define do
  factory :author do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }

    trait :with_books do
      transient do
        books_count { 5 }
      end

      after(:create) do |author, evaluator|
        create_list(:book, evaluator.books_count, author: author)
      end
    end
  end
end
