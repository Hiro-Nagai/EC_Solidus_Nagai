require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end
end


require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET /show" do
    let(:test_taxon) { create(:taxon) }
    let(:test_product) { create(:product, taxons: [test_taxon]) }
    let(:products) { create_list(:product, 5, taxons: [test_product.taxons.first]) }

    before do
      get potepan_product_path(test_product.id)
    end

    it "httpステータスが200を返すこと" do
      expect(response).to have_http_status "200"
    end

    it "意図したページへrenderできているか" do
      expect(response).to render_template(:show)
    end

    it "同じtaxon情報を持つ他のproductを４つまで返すこと" do
      stub_const("RELATED_PRODUCTS_DISPLAY_NUM_MAX", 4)
      expect(test_product.related_products.limit(RELATED_PRODUCTS_DISPLAY_NUM_MAX)).to eq [products[0], products[1], products[2], products[3]]
    end
  end
end