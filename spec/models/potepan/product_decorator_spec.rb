require 'rails_helper'

RSpec.describe "Spree::ProductDecorator", type: :model do
  let(:taxon) { create(:taxon) }
  let(:taxon2) { create(:taxon) }
  let(:product) { create(:product, taxons: [taxon, taxon2]) }
  let!(:related_products) { create_list(:product, 5, taxons: [taxon, taxon2], ) }
  let(:other_taxon) { create :taxon }

  describe "related_products" do
    it "関連商品同士が重複していないこと" do
      expect(product.related_products).to match_array related_products
    end

    it "レシーバ(product)自身を含まないこと" do
      expect(product.related_products).not_to include product
    end

    it "関連しない商品を持たない" do
      expect(product.related_products).not_to include other_taxon
    end

    it "idの昇順で取得する" do
      expect(product.related_products).to eq related_products.sort_by(&:id)
    end
  end
end
