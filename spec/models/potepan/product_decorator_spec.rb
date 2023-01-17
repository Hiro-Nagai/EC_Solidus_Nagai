require 'rails_helper'

RSpec.describe "Spree::ProductDecorator", type: :model do
  let(:product) { create(:product, taxons: [taxon, taxon2]) }
  let!(:same_related_product) { create(:product, taxons: [taxon, taxon2]) }
  let(:related_product) { create_list(:product, 5, taxons: [taxon, taxon2], ) } #order: :id 
  let(:taxon) { create(:taxon) }
  let(:taxon2) { create(:taxon) }

  describe "Spree::ProductDecorator" do
    it "関連商品同士が重複していないこと" do
      expect(related_product).to eq related_product.uniq
    end

    it "レシーバ(product)自身を含まないこと" do
      expect(product.related_products).not_to include product
    end
  end
end
