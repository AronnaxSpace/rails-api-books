class AuthorPresenter < BasePresenter
  def initialize(author)
    @author = author
  end

  def as_json
    {
      id: @author.id,
      name: @author.name,
      created_at: @author.created_at,
      updated_at: @author.updated_at
    }
  end
end
