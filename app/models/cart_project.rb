class CartProject < SimpleDelegator
attr_reader :project, :loan_amount

  def initialize(project_id, loan_amount)
    @project = Project.find(project_id)
    @loan_amount = loan_amount
    super(@project)
  end
end
