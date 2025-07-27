10.times do
  FactoryBot.create(
    :author,
    :with_books,
    books_count: rand(1..10)
  )
end
