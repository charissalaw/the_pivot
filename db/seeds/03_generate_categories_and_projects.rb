class CategoriesSeed
  def self.generate_categories
    categories.each do |category|
      seed = Category.create(name:category)
      puts "Created Category: #{seed.name}."
    end
  end

private
  def self.categories
    %w(education food agriculture arts health housing transportation retail entertainment emergency)
  end
end

CategoriesSeed.generate_categories
