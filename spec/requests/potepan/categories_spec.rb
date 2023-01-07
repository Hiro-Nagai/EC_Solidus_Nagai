require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "categories/show" do
    let(:image) { create(:image) }
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }

    before do
      product.images << image
      get potepan_category_path(taxon.id)
    end

    it "カテゴリーページが表示されていること" do
      expect(response).to have_http_status(:success)
    end

    it "カテゴリーの名前が表示されていること" do
      expect(response.body).to include taxon.name
    end

    it "商品の名前価格が表示されていること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
    end
  end
end
