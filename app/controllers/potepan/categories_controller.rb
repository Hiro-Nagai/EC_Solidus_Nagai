class Potepan::CategoriesController < ApplicationController
  def show
    
    @taxon = Spree::Taxon.find(params[:id])
  end
end
