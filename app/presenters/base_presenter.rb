class BasePresenter
  def initialize(object)
    @object = object
  end

  def self.present(object_or_collection, attributes_to_exclude: [])
    if object_or_collection.respond_to?(:map)
      object_or_collection.map { |item| new(item).as_json(attributes_to_exclude: attributes_to_exclude) }
    else
      new(object_or_collection).as_json(attributes_to_exclude: attributes_to_exclude)
    end
  end

  def as_json(attributes_to_exclude: [])
    raise NotImplementedError, "Subclasses must implement #as_json"
  end
end
