require "active_model"

class GradientForm

  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_reader :name, :points, :gradient, :save

  def initialize(attrs={})
    @name, @points, @save = attrs.values_at(*%w(name points save))
    @gradient = Gradient::Map.deserialize(JSON.parse(@points))
  end

end