require 'rails_helper'

RSpec.describe "Spree::ProductDecorator", type: :model do
  let(:product) { create(:product, taxons: [taxon, taxon2]) }
  let!(:same_related_products) { create(:product, taxons: [taxon, taxon2]) }
  let(:related_products) { create_list(:product, 5, taxons: [taxon, taxon2]) }
  let(:taxon) { create(:taxon) }
  let(:taxon2) { create(:taxon) }

  describe "Spree::ProductDecorator" do
    it "関連商品同士が重複していないこと" do
      expect(product.related_products).to eq product.related_products.uniq
    end

    it "該当商品と関連商品の情報が重複していないこと" do
      expect(product.related_products).not_to include product
    end
  end
end
