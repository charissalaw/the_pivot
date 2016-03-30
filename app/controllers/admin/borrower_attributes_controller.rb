class Admin::BorrowerAttributesController < ApplicationController

  def index
    @borrower_attributes ||= BorrowerAttribute.all
  end

  def edit

  end

  def update
    binding.pry
  end
end
