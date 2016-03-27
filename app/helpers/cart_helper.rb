module CartHelper
  def cart_total(projects)
    raw_cart_total(projects)
  end

  def raw_cart_total(projects)
    @cart.contents.values.sum
  end
end
