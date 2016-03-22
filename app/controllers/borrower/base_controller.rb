class Admin::BaseController < ApplicationController
  before_action :require_borrower

  def require_borrower
    render file: "/public/404" unless current_admin?
  end
end
