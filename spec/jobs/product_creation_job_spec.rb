require 'rails_helper'

RSpec.describe ProductCreationJob, type: :job do
  describe '#perform' do
    let(:product_params) { { name: 'New Product' } }

    it 'creates a new product' do
      expect {
        ProductCreationJob.new.perform(product_params)
      }.to change(Product, :count).by(1)
    end
  end
end
