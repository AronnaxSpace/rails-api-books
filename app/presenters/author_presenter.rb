class AuthorPresenter < BasePresenter
  def as_json(attributes_to_exclude: [])
    {
      id: @object.id,
      name: @object.name,
      created_at: @object.created_at,
      updated_at: @object.updated_at
    }.tap do |hash|
      unless attributes_to_exclude.include?(:books)
        hash[:books] = BookPresenter.present(@object.books, attributes_to_exclude: [ :author ])
      end
    end
  end
end
