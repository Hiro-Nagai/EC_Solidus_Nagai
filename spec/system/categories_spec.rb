require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :system do
  describe "categories/show" do
    let(:image) { create(:image) }
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    let!(:taxon2) { create(:taxon, taxonomy: taxonomy) }
    let(:product) { create(:product, taxons: [taxon]) }
    let!(:product2) { create(:product) }
    let!(:product100) { create(:product, taxons: [taxon2]) }

    before do
      product.images << image
      visit potepan_category_path(taxon.id)
    end

    it "ページ内の複数箇所に表示されているTaxon名が全てもれなく表示されていること" do
      within ('.page-title') do
        expect(page).to have_content taxon.name
      end
      within ('.breadcrumb') do
        expect(page).to have_content taxon.name
      end
      within "#category-#{taxonomy.id}" do
        expect(page).to have_content taxon.name
      end
    end 

    it "カテゴリーページが表示されていること" do      
      expect(page).to have_http_status(:success)
    end

    it "親カテゴリー名(Taxonomy名)が表示されていること" do
      expect(page).to have_content taxonomy.name
    end

    it "対象のTaxonに紐付いていない商品が表示されていないこと" do
      expect(page).not_to have_content(product2.name)
    end
    
    it "対象以外のtaxonに紐づいている商品が表示されないこと" do
      expect(page).not_to have_content(product100.name)
    end

    it "Taxon名に引き続いてそれに紐づく商品数が表示されていること" do
      expect(page).to have_content "#{taxon.name} (#{taxon.all_products.count})"
    end

    it "意図した商品画像が表示されていること" do
      within ('.productBox') do 
        expect(page).to have_selector("img[src$='blank.jpg']")
      end
    end

    it "商品の名前と価格が表示されていること" do
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
    end
  end
end
