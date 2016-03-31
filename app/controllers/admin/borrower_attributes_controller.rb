class Admin::BorrowerAttributesController < ApplicationController

  def index
    @borrower_attributes ||= BorrowerAttribute.all
  end

  def edit
  end

  def update
    borrower_attribute = BorrowerAttribute.find(params[:id])
    borrower_attribute.update(borrower_attribute_params)
    redirect_to admin_borrower_attributes_path
  end

  private
    def borrower_attribute_params
      params.permit(:score, :label)
    end
end
