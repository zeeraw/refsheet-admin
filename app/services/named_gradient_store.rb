class NamedGradientStore

  def initialize(riak:, style:)
    @riak, @style = riak, style
    @gradients = @riak.bucket_type("default").bucket("gradients")
    @gradient_index = @riak.bucket("index")
    @keys = Riak::Crdt::Set.new(@gradient_index, "gradients")
  end

  def find(key)
    key_data_to_named_gradient(key, @gradients.get(key).data)
  end

  def list(limit: 100, offset: 0)
    @gradients.get_many(@keys.members).map do |key, object|
      key_data_to_named_gradient(key, object.data)
    end
  end

  def save(id:, name:, points:)
    @keys.add(id)
    @gradients.get_or_new(id).tap do |object|
      object.data = { name: name, points: points }
      object.content_type = "application/json"
      object.store
    end
  end

  def delete(id)
    @keys.reload.delete(id)
    @gradients.delete(id)
  end

  private def key_data_to_named_gradient(key, data)
    name = data.fetch("name", nil)
    gradient = Gradient::Map.deserialize(data.fetch("points", nil))
    NamedGradient.new(key, name, gradient)
  end

end