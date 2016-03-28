class Country::CountriesController < ApplicationController
  def show
    @country = Country.find_by(slug: params[:country])
    @projects = Project.where(country_id: @country.id)
  end
end
