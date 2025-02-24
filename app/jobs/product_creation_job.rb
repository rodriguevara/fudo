class ProductCreationJob < ApplicationJob
  queue_as :default

  def perform(product_params)
    Product.create!(product_params)
  rescue StandardError => e
    # Aquí podrías implementar notificaciones de error
    Rails.logger.error("Error creating product: #{e.message}")
  end
end
