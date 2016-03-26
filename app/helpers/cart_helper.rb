module CartHelper
  def cart_total(projects)
    raw_cart_total(projects) / 100
  end

  def raw_cart_total(projects)
    projects.map do |project|
      project.goal * project.quantity
    end.reduce(:+)
  end
end
