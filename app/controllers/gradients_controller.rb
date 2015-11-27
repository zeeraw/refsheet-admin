class GradientsController < ApplicationController

  def index
    store = NamedGradientStore.new(riak: $riak, style: "default")
    @named_gradients = store.list
  end

  def create
    @gradient_form = GradientForm.new(gradient_params)
    if @gradient_form.valid?
      store = NamedGradientStore.new(riak: $riak, style: "default")
      store.save(@gradient_form.attributes)
      render head: true, status: 201
    else
      render partial: "components/gradient_form", layout: false, locals: { gradient_form: @gradient_form }, status: 422
    end
  end

  private def gradient_params
    params.require(:gradient_form).permit(:name, :points)
  end

end
