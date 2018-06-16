module ApplicationHelper
  def presenter model
    klass = "#{model.class}Presenter".constantize
    presenter = klass.new model, self
    yield presenter if block_given?
  end
end
