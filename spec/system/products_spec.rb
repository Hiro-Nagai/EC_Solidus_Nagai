require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  describe "GET #show" do
    let(:image) { create(:image) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }  
    let(:related_products) { create_list(:product, 5, taxons: [taxon]) }

    before do
      product.images << image
      visit potepan_product_path(product.id)
    end

    it "一覧ページへ戻るをクリックすると商品カテゴリページへアクセスされていること" do
      click_link "一覧ページへ戻る"
      expect(current_path).to eq potepan_category_path(taxon.id)
    end

    it "商品の情報が表示されていること" do
      expect(page).to have_content(product.name)
      expect(page).to have_content(product.display_price)
      expect(page).to have_content(product.description)
    end

    it "関連商品が4つ表示されていること" do
      within ('.productCaption')
      related_products.first(4) do |related_product|
        expect(page).to have_content(related_product.name)
        expect(page).to have_content(related_product.display_price)
      end
    end
  end
end
