require 'rails_helper'

RSpec.describe "Products", type: :system do
  include Rails.application.routes.url_helpers
  describe "GET #show" do
    let(:image) { create(:image) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    
    before do
      product.images << image
      get potepan_product_path(product.id)
      # 画像URL取得が上手くいかない問題への対応
      # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
      ActiveStorage::Current.host = request.base_url
    end

    it "一覧ページに戻るをクリックすると商品カテゴリページへアクセスされていること" do
      click_link 'HOME'
      expect(current_path).to eq potepan_category_path(taxons.id)
    end

    it "ページが表示されていること" do
      expect(response).to have_http_status(:success)
    end

    it "商品の名前が表示されていること" do
      expect(response.body).to include product.name
    end

    it "商品の価格が表示されていること" do
      expect(response.body).to include product.display_price.to_s
    end

    it "商品の説明が表示されていること" do
      expect(response.body).to include product.description
    end
  end
end
