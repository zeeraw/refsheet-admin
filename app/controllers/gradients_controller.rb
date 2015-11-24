class GradientsController < ApplicationController

  def index
  end

  def create
    @gradients_form = GradientsForm.new(gradients_params)
    if @gradients_form.valid?
      redirect_to gradients_path
    else
      render "new"
    end
  end

  private def gradients_params
    params.require(:gradients_form).permit(gradient_forms: [:name, :points, :save]).require(:gradient_forms)
  end

end
