class AddCountryRefToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :country, index: true, foreign_key: true
  end
end
