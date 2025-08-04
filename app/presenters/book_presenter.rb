class BookPresenter < BasePresenter
  def as_json(attributes_to_exclude: [])
    {
      id: @object.id,
      title: @object.title,
      author: author_info,
      created_at: @object.created_at,
      updated_at: @object.updated_at
    }.except(*attributes_to_exclude)
  end

  private

  def author_info
    return nil unless @object.author

    {
      id: @object.author.id,
      name: @object.author.name
    }
  end
end
