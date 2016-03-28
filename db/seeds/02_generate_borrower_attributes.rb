class BorrowerAttributeSeed
  def self.generate_borrower_attributes
    criteria.each do |quality|
      seed = BorrowerAttribute.create(category:quality[0], label:quality[1], score:quality[2])
      puts "Created BorrowerAttribute: #{seed.category}, #{seed.label}."
    end
  end

private
  def self.criteria
    [["income", "> $60,000", 7],
    ["income", "$50,000 to $60,000", 6],
    ["income", "$40,000 to $50,000", 5],
    ["income", "$30,000 to $40,000", 4],
    ["income", "$20,000 to $30,000", 1],
    ["income", "$10,000 to $20,000", 1],
    ["income", "< $10,000", 1],
    ["housing", "> $3,000", 7],
    ["housing", "$2,000 to $3,000", 5],
    ["housing", "$1,500 to $2,000", 3],
    ["housing", "$1,000 to $2,000", 3],
    ["housing", "$500 to $1000", 2],
    ["housing", "< $500", 4],
    ["credit", "> $3,000", 7],
    ["credit", "$2,000 to $3,000", 5],
    ["credit", "$1,500 to $2,000", 3],
    ["credit", "$1,000 to $2,000", 3],
    ["credit", "$500 to $1000", 2],
    ["credit", "< $500", 1],
    ["dependents", "> 6", 1],
    ["dependents", "5", 2],
    ["dependents", "4", 3],
    ["dependents", "3", 4],
    ["dependents", "2", 5],
    ["dependents", "1", 5],
    ["dependents", "0", 5]]
  end
end

BorrowerAttributeSeed.generate_borrower_attributes
