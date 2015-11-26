class GradientsController < ApplicationController

  def index
    store = NamedGradientStore.new(riak: $riak, style: "default")
    @named_gradients = store.list
  end

  def create
    @gradients_form = GradientsForm.new(gradients_params)
    if @gradients_form.valid?
      store = NamedGradientStore.new(riak: $riak, style: "default")
      StoreGradientsInForm.new(store, @gradients_form).call
      redirect_to gradients_path
    else
      render "new"
    end
  end

  private def gradients_params
    params.require(:gradients_form).permit(gradient_forms: [:name, :points, :save]).require(:gradient_forms)
  end

end
