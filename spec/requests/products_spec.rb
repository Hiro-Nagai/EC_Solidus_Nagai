require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET #show" do
    let(:product) { create(:product, taxons: [taxon]) }
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }   
    
    before do
      get potepan_product_path(product.id)
    end

    it "ページが表示されていること" do
      expect(response).to have_http_status(:success)
    end
  end
end
