require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET #show" do
    let(:product) { create(:product, taxons: [taxon]) }
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    let(:related_products) {
      create_list(:product, 5, taxons: [taxon]).each_with_index do |product, i|
       product.price = i
       product.save
      end   
     }

    before do
      related_products.each do |related_product|
        related_product.images << create(:image)
      end
      get potepan_product_path(product.id)
    end

    it "リクエストが成功すること" do
      expect(response).to have_http_status(:success)
    end

    it "商品の情報が含まれていること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
    end

    it "関連商品が含まれること" do
      within '.productsContent' do
        related_products.all? do |related_product|
          expect(response.body).to include related_product.name
          expect(response.body).to include related_product.display_price.to_s
        end
      end
    end

    it '5つ目の関連商品が含まれないこと' do
      expect(response.body).not_to include(related_products[4].name)
    end

    it '最大4つの商品が含まれること' do
      within '.productsContent' do
        (0..3).each do |i|
          expect(response.body).to include(related_products[i].name)
        end
      end
    end
  end
end
