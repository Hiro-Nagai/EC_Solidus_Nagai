require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET #show" do
    let(:product) { create(:product, taxons: [taxon]) }
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    let(:related_products) { create_list(:product, 5, taxons: [taxon]) }

    before do
      get potepan_product_path(product.id)
      related_products.each do |related_product|
        related_product.images << create(:image)
      end
    end

    it "ページが表示されている事" do
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

    it "idを基準として昇順で取得する" do
      within '.productsContent' do
        expect(response.body["related_products"]).to include(related_products.sort_by(&:id))
      end
    end

    context '関連商品が5つある場合' do
      it '4つの商品が表示されること' do
        within '.productsContent' do
          expect(response.body).to include(related_products[0].name)
          expect(response.body).to include(related_products[1].name)
          expect(response.body).to include(related_products[2].name)
          expect(response.body).to include(related_products[3].name)
          expect(response.body).not_to include(related_products[4].name)
        end
      end
    end
  end
end
