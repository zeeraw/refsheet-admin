require "active_model"

class GradientForm

  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_reader :id, :name, :points, :gradient, :save

  validates :name, presence: true

  def initialize(attrs={})
    @name, @points = attrs.values_at(*%i(name points))
    @id = attrs.fetch(:id) { SecureRandom.uuid }
    @gradient = Gradient::Map.deserialize(JSON.parse(@points)) if @points
  end

  def persisted?
    false
  end

  def attributes
    { id: @id, name: @name, points: @gradient.serialize }
  end

end