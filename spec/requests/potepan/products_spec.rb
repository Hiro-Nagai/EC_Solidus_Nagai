# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products_request', type: :request do
  describe 'GET /potepan/products/:id' do
    
    
    let!(:product) { create(:product,) }

    before do
      get potepan_products_path(product.id)
    end

    it 'returns 200 response' do
      expect(response).to have_http_status(200)
    end

    it 'shows a product information' do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
    end
  end
end







=begin
rescue => exception
  
end
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products_request', type: :request do
  describe 'GET /potepan/products/:id' do

    
    
    !let(:product) { create(:product)  } 

    before do
      get potepan_products_path(product.id)
    end

    it 'returns 200 response' do
      expect(response).to have_http_status(200)
    end

    it 'shows a product information' do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
    end
  end
end
=end