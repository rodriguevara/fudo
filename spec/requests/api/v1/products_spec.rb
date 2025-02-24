require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => "Bearer #{jwt_encode(user_id: user.id)}" } }

  before do
    allow(ProductCreationJob).to receive(:perform_later) do |params|
      TestProductCreationJob.perform_later(params)
    end
  end

  describe 'GET /api/v1/products' do
    before do
      create_list(:product, 3)
    end

    it 'returns a list of products' do
      get '/api/v1/products', headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end

    it 'returns unauthorized for requests without a valid token' do
      get '/api/v1/products'
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq('error' => 'Unauthorized')
    end
  end

  describe 'POST /api/v1/products' do
    let(:valid_params) { { product: { name: 'New Product' } } }
    let(:invalid_params) { { product: { name: '' } } }

    context 'with valid parameters' do
      it 'enqueues a product creation job' do
        expect {
          post '/api/v1/products', params: valid_params, headers: headers
        }.to have_enqueued_job(TestProductCreationJob).with(valid_params[:product])

        expect(response).to have_http_status(:accepted)
        expect(JSON.parse(response.body)).to eq('message' => 'Product creation in progress')
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        post '/api/v1/products', params: invalid_params, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'without authentication' do
      it 'returns unauthorized status' do
        post '/api/v1/products', params: valid_params
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq('error' => 'Unauthorized')
      end
    end
  end
end
