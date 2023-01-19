class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_MAXIMUM_COUNT = 4

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.
      related_products.
      limit(RELATED_PRODUCTS_MAXIMUM_COUNT)
  end
end
