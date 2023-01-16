class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.related_products.distinct.limit(4)
  end
end
