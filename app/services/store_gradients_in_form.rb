class StoreGradientsInForm

  def initialize(store, form)
    @forms = form.gradient_forms
    @store = store
  end

  def call
    @forms.map { |form| store(form) }
  end

  private def store(form)
    return false unless form.save?
    @store.save(form.attributes)
    return true
  end

end