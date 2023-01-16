require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET #show" do
    let(:product) { create(:product, taxons: [taxon]) }
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }

    before do
      get potepan_product_path(product.id)
    end

    it "ページが表示されていること" do
      expect(response).to have_http_status(:success)
    end

    it "商品の情報が表示されていること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
    end

    it "関連商品を取得する" do
      within '.productsContent' do
        related_products.all? do |related_product|
          expect(response.body).to include related_product.name
          expect(response.body).to include related_product.display_price.to_s
        end
      end
    end
  end
end
