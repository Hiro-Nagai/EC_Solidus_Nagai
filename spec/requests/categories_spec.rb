RSpec.describe "Potepan::Categories", type: :request do
  describe "categories/show" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }

    before do
      get potepan_category_path(taxon.id)
    end

    it "カテゴリーページが表示されていること" do
      expect(response).to have_http_status(:success)
    end
  end
end
