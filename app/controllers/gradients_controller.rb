class GradientsController < ApplicationController

  def index
    @named_gradients = store.list
  end

  def show
    @gradient = store.find(params.require(:id))
  end

  def destroy
    store.delete(params.require(:id))
    redirect_to gradients_path
  end

  def create
    @gradient_form = GradientForm.new(gradient_params)
    if @gradient_form.valid?
      store.save(@gradient_form.attributes)
      head :created
    else
      render partial: "components/gradient_form", layout: false, locals: { gradient_form: @gradient_form }, status: 422
    end
  end

  private def gradient_params
    params.require(:gradient_form).permit(:name, :points)
  end

  private def store
    @named_gradient_store ||= NamedGradientStore.new(riak: $riak, style: "default")
  end

end
