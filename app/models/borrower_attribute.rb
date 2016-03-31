class BorrowerAttribute < ActiveRecord::Base

  def self.annual_income
    where(category:"income").order(:id)
  end

  def self.housing_costs
    where(category:"housing").order(:id)
  end

  def self.credit_payments
    where(category:"credit").order(:id)
  end

  def self.dependents
    where(category:"dependents").order(:id)
  end
end
