class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_project(project_id, quantity)
    contents[project_id.to_s] ||= 0
    contents[project_id.to_s] += quantity.to_i
  end

  def count
    contents.values.sum
  end

  def projects
    contents.map do |project_id, quantity|
      CartProject.new(project_id, quantity)
    end
  end

  def empty?
    contents.empty?
  end

  def remove_project_from_cart(id)
    contents.reject! {|k| k == id}
  end

  def update(params)
    contents[params[:id]] = params[:quantity].to_i
  end
end
