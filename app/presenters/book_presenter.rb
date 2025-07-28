class BookPresenter < BasePresenter
  def initialize(book)
    @book = book
  end

  def as_json
    {
      id: @book.id,
      title: @book.title,
      author: author_info,
      created_at: @book.created_at,
      updated_at: @book.updated_at
    }
  end

  private

  def author_info
    return nil unless @book.author

    {
      id: @book.author.id,
      name: @book.author.name
    }
  end
end
