class BorrowerApplication
  def initialize(borrower_params)
    @borrower_params = borrower_params
  end

  def evaluate_borrower
    if @borrower_params.values.map(&:to_i).inject(:+) < 20
      Borrower.new(@borrower_params)
    else
      Borrower.new
    end
  end
end
