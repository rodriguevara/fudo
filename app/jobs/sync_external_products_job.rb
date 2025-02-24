class SyncExternalProductsJob < ApplicationJob
  queue_as :default

  def perform
    external_products = ExternalProductsService.fetch_products

    external_products.each do |product_data|
      Product.find_or_create_by!(name: product_data["name"])
    end
  end
end
