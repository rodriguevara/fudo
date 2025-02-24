require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def dummy_action
      render plain: 'dummy'
    end
  end

  before do
    routes.draw { get 'dummy_action' => 'anonymous#dummy_action' }
  end

  describe '#jwt_encode' do
    let(:payload) { { user_id: 1 } }
    let(:token) { subject.send(:jwt_encode, payload) }
    let(:decoded_token) { JWT.decode(token, Rails.application.credentials.jwt_secret_key)[0] }

    it 'encodes a payload into a JWT token' do
      expect(decoded_token['user_id']).to eq(1)
    end

    it 'includes an expiration time' do
      expect(decoded_token).to have_key('exp')
    end
  end
end
