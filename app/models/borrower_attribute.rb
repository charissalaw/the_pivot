class BorrowerAttribute < ActiveRecord::Base

  def self.annual_income
    where(category:"income")
  end

  def self.housing_costs
    where(category:"housing")
  end

  def self.credit_payments
    where(category:"credit")
  end

  def self.dependents
    where(category:"dependents")
  end
end
