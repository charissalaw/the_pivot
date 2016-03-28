module CartHelper
  def cart_total(projects)
    raw_cart_total(projects) / 100
  end

  def raw_cart_total(projects)
    @cart.contents.values.sum * 100
  end
end
