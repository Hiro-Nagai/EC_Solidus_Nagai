require 'rails_helper'

RSpec.describe "Potepan::Samples", type: :request do
  #  describe "GET /potepan/samples" do
  #    it "works! (now write some real specs)" do
  #      get potepan_samples_path
  #      expect(response).to have_http_status(200)
  #    end

  describe "GET /potepan/index" do
    it "正常にレスを返す" do
      get "/potepan/index"
      expect(response).to have_http_status(200)
    end
  end
end
