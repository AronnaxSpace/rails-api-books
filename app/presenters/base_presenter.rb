class BasePresenter
  def self.present(object_or_collection)
    if object_or_collection.respond_to?(:map)
      object_or_collection.map { |item| new(item).as_json }
    else
      new(object_or_collection).as_json
    end
  end

  def as_json
    raise NotImplementedError, "Subclasses must implement #as_json"
  end
end
