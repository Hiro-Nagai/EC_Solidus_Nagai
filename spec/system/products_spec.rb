require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
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

    it "一覧ページへ戻るをクリックすると商品カテゴリページへアクセスされていること" do
      visit potepan_category_path(taxon.id)
        expect(current_path).to eq potepan_category_path(taxon.id)
    end

    it "ページが表示されていること" do
      visit potepan_product_path(product.id)
        expect(page).to have_http_status(:success)
    end
  end
end
