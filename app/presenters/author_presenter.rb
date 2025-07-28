class AuthorPresenter < BasePresenter
  def initialize(author, include_books: false)
    @author = author
    @include_books = include_books
  end

  def as_json
    {
      id: @author.id,
      name: @author.name,
      created_at: @author.created_at,
      updated_at: @author.updated_at
    }.tap do |hash|
      if @include_books
        hash[:books] = BookPresenter.present(@author.books)
      end
    end
  end
end
