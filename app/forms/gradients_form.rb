require "active_model"

class GradientsForm

  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_reader :gradient_forms

  def initialize(gradients_params)
    @gradient_forms = gradients_params.map { |params| GradientForm.new(params) }
  end

end