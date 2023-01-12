require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  describe "GET #show" do
    let(:image) { create(:image) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }   
    
    before do
      product.images << image
      visit potepan_product_path(product.id)
    end

    it "一覧ページへ戻るをクリックすると商品カテゴリページへアクセスされていること" do
      visit potepan_category_path(taxon.id)
        expect(current_path).to eq potepan_category_path(taxon.id)
    end

    it "ページが表示されていること" do
        expect(page).to have_http_status(:success)
    end
  end
end
