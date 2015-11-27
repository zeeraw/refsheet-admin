class NamedGradient < Struct.new(:id, :name, :gradient)

  def to_param
    id
  end

end