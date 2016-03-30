class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_project(project_id, loan_amount)
    contents[project_id.to_s] ||= 0
    contents[project_id.to_s] += loan_amount[1..-1].to_i
  end

  def adjust_loans
    flash = false
    contents.each do |project, loan|
      if (loan) > Project.find(project.to_i).remaining_goal
        current_project = Project.find(project.to_i)
        contents[project] = (current_project.remaining_goal / 100)
        flash = true
      end
    end
    flash
  end

  def count
    contents.values.sum
  end

  def projects
    contents.map do |project_id, loan_amount|
      CartProject.new(project_id, (loan_amount * 100))
    end
  end

  def empty?
    contents.empty?
  end

  def remove_project_from_cart(id)
    contents.reject! {|k| k == id}
  end

  def update(params)
    contents[params[:id]] = params["loan-amount"][1..-1].to_i
  end
end
