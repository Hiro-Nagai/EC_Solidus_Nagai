require 'rails_helper'

RSpec.describe "Spree::ProductDecorator", type: :model do
  let(:product) { create(:product, taxons: [taxon, taxon2]) }
  let!(:same_related_product) { create(:product, taxons: [taxon, taxon2]) }
  let(:related_product) { create_list(:product, 5, taxons: [taxon, taxon2], ) } 
  let(:taxon) { create(:taxon) }
  let(:taxon2) { create(:taxon) }
  let(:other_taxon) { create :taxon }
  let(:not_related_product) { create :product, taxons: [other_taxon] }
  let!(:related_products) { create_list(:product, 4, taxons: [taxon]) }

  describe "related_products" do
    it "関連商品同士が重複していないこと" do
      expect(related_products == related_products.uniq).to be true
    end

    it "レシーバ(product)自身を含まないこと" do
      expect(product.related_products).not_to include product
    end

    it "関連しない商品を持たない" do
      expect(product.related_products).not_to include other_taxon
    end
  end
end
