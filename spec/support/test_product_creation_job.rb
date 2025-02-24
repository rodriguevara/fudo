class TestProductCreationJob < ApplicationJob
  queue_as :test

  def perform(product_params)
    product = Product.new(product_params)
    product.valid?
  end
end
