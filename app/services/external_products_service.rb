class ExternalProductsService
  API_URL = "https://23f0013223494503b54c61e8bee1190c.api.mockbin.io/"

  def self.fetch_products
    response = HTTParty.get(API_URL, headers: { "Content-Type" => "application/json" })
    response.parsed_response["data"] # Ajustamos para manejar la estructura correcta de la respuesta
  rescue StandardError => e
    Rails.logger.error("Error fetching external products: #{e.message}")
    []
  end
end
