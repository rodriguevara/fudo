require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /api/v1/login' do
    let(:user) { create(:user, email: 'user@example.com', password: 'password123') }
    context 'with valid credentials' do
      it 'returns a JWT token' do
        post '/api/v1/login', params: { user: { email: user.email, password: 'password123' } }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized status' do
        post '/api/v1/login', params: { user: { email: user.email, password: 'wrongpassword' } }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq('error' => 'Invalid credentials')
      end
    end
  end
end
