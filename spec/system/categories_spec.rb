require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :system do
  describe "categories/show" do
    let(:image) { create(:image) }
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:product2) { create(:product) }

    before do
      product.images << image
      get potepan_category_path(taxon.id)
    end

    it "カテゴリーページが表示されていること" do
      visit potepan_category_path(taxon.id)
        expect(page).to have_http_status(:success)
    end

    it "親カテゴリー名(Taxonomy名)が表示されていること" do
      visit potepan_category_path(taxon.id)
        expect(page).to have_content taxonomy.name
    end

    it "ページ内の複数箇所に表示されているTaxon名が全てもれなく表示されていること" do
      visit potepan_category_path(taxon.id) 
        expect(page).to have_content taxon.name
    end

    it "Taxon名に引き続いてそれに紐づく商品数が表示されていること" do
      visit potepan_category_path(taxon.id) 
        expect(page).to have_content taxon.products.size.to_s
    end

    it "対象のTaxonに紐付いていない商品が表示されていないこと" do
      visit potepan_category_path(taxon.id) 
        expect(page).not_to have_content(product2.name)
    end

    it "意図した商品画像が表示されていること" do
      visit potepan_category_path(taxon.id) 
      within ('.productBox') do 
        expect(page).to have_selector("img[src$='blank.jpg']")
      end
    end

    it "商品の名前価格が表示されていること" do
      visit potepan_category_path(taxon.id) 
        expect(page).to have_content product.name
        expect(page).to have_content product.display_price.to_s
    end
  end
end
