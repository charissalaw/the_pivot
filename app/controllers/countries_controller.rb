class CountriesController < ApplicationController
  def show
    @country = Country.find_by_slug(params[:slug])
  end

  def search
    redirect_to country_path(params[:country_search])
  end
end
