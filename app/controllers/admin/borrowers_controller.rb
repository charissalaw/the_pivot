class Admin::BorrowersController < ApplicationController
  def index
    @borrowers = Search.admin_borrowers(params)
    if @borrowers.nil? && params[:id_search]
      @borrower = Borrower.find_by(id: params[:id_search])
      if @borrower
        redirect_to admin_borrower_path(@borrower)
      else
        flash.now[:alert] = "Borrower #{params[:id_search]}  doesn't exist!"
        render :index
      end
    end
  end

  def show
    @borrower = Borrower.find(params[:id])
    @project = Project.new
    # @projects = @borrower.projects.active_index
    @projects = @borrower.projects
  end
end
