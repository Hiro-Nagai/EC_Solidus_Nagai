require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "categories/show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    let(:product) { create(:product, taxons: [taxon]) }
   
    before do
      get potepan_category_path(taxon.id)
    end

    it "カテゴリーページが表示されていること" do
      expect(response).to have_http_status(:success)
    end

    it "taxonがresponseに含まれること" do
      expect(response.body).to include taxon.name
    end

    it "taxonomyがresponseに含まれること" do
      expect(response.body).to include taxonomy.name
    end

    it "productがresponseに含まれること" do
      within ('.productCaption') do
        expect(response.body).to include product.name
      end
    end
  end
end
