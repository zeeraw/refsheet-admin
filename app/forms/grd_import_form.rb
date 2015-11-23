require "active_model"

class GRDImportForm

  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_reader :file, :upload_id

  validates :file, presence: true

  def initialize(file: nil, upload_id: nil)
    @file, @upload_id = file, upload_id
  end

  def gradients
    @gradients ||= Gradient::GRD.parse(@file.read)
  end

  def gradients_params
    gradients.map do |name, gradient|
      ActionController::Parameters.new({ name: name, points: gradient.serialize.to_json })
    end
  end

end