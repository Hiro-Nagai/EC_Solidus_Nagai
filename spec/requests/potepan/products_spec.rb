require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /show" do
    let(:product) { create(:spree_product, :skip_validate) }

    before do
      get potepan_product_url(product.id)
    end


  end
end



