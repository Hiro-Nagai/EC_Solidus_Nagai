require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  describe "GET #show" do
    let(:image) { create(:image) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }  
    let(:related_products) do
      create_list(:product, 5, taxons: [taxon]).each_with_index do |product, i|
        product.price = i
        product.save
      end   
    end

    before do
      related_products.each do |related_product|
        related_product.images << create(:image)
      end
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

    it "関連商品が最大4つ表示されていること" do
      within '.productsContent' do
        related_products.first(4).all? do |related_product|
          expect(page).to have_content(related_product.name)
          expect(page).to have_content(related_product.display_price)
        end
      end
    end
  end
end
