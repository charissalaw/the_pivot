class Admin::BorrowerAttributesController < ApplicationController

  def index
    @borrower_attributes ||= BorrowerAttribute.all
  end

  def edit
  end

  def update
    borrower_attribute = BorrowerAttribute.find(params[:id])
    if borrower_attribute.update(borrower_attribute_params)
      flash[:alert] = "Attribute Updated. Please review carefully!"
      redirect_to admin_borrower_attributes_path
    else
      flash[:alert] = "Something went wrong."
      redirect_to admin_borrower_attributes_path
    end
  end

  private
    def borrower_attribute_params
      params.permit(:score, :label)
    end
end
