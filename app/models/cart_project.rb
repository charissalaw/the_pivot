class CartProject < SimpleDelegator
attr_reader :project, :quantity

  def initialize(project_id, quantity)
    @project = Project.find(project_id)
    @quantity = quantity
    super(@project)
  end

  def subtotal
    project.price * quantity
  end

  def format_subtotal
    subtotal / 100
  end
end
