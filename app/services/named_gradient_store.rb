class NamedGradientStore

  GRADIENTS_BUCKET = "gradients".freeze
  STYLES_BUCKET = "styles".freeze

  def initialize(riak:, style:)
    @riak, @style = riak, style
    @gradients = @riak.bucket(GRADIENTS_BUCKET)
    @styles = @riak.bucket(STYLES_BUCKET)
  end

  def save(id, name:, gradient:)
    @styles.get_or_new(@style) do |object|
      object.links << Riak::Link.new(GRADIENTS_BUCKET, @id, "includes")
      object.store
    end
    @gradients.get_or_new(id).tap do |object|
      object.data = { name: name, gradient: gradient.serialize }
      object.content_type = "application/json"
      object.store
    end
  end

  def delete(id)
    @gradients.delete(id)
  end

end