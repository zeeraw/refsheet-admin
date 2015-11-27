class GrdImportController < ApplicationController

  def new
    @grd_import_form = GRDImportForm.new(upload_id: SecureRandom.uuid)
  end

  def create
    @grd_import_form = GRDImportForm.new(grd_import_params)
    if @grd_import_form.valid?
      @gradient_forms = @grd_import_form.gradients_params.map do |params|
        GradientForm.new(params)
      end
      return render "gradients/new"
    else
      return render "new"
    end
  end

  def grd_import_params
    params.require(:grd_import_form).permit(:file, :upload_id).symbolize_keys
  end

end