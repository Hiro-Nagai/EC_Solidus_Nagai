class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_SHOW_NUM = 4
  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.related_products.distinct.limit(RELATED_PRODUCTS_SHOW_NUM).includes(master: [:default_price, images: { attachment_attachment: :blob }])
  end
end
