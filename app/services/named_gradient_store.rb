class NamedGradientStore

  def initialize(riak:, style:)
    @riak, @style = riak, style
    @gradients = @riak.bucket_type("default").bucket("gradients")
    @gradient_index = @riak.bucket("index")
  end

  def save(id:, name:, points:)
    Riak::Crdt::Set.new(@gradient_index, "gradients").tap do |set|
      set.add(id)
    end

    @gradients.get_or_new(id).tap do |object|
      object.data = { name: name, points: points }
      object.content_type = "application/json"
      object.store
    end
  end

  def delete(id)
    @gradients.delete(id)
  end

end