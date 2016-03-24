class CategoriesSeed
  def self.generate_categories
    categories.each do |category|
      seed = Category.create(name:category)
      puts "Created Category: #{seed.name}."
    end
  end

private
  def self.categories
    ["education", "food", "agriculture"]
  end
end

CategoriesSeed.generate_categories
