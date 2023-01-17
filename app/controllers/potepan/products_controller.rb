class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_MAXIMUM_COUNT = 4

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.
      related_products.
      includes(master: [:default_price, images: { attachment_attachment: :blob }]).
      limit(RELATED_PRODUCTS_MAXIMUM_COUNT)
  end
end
