module Api
  module V1
    class ProductsController < ApplicationController
      def create
        product = Product.new(product_params)

        if product.valid?
          ProductCreationJob.perform_later(product_params)
          render json: { message: "Product creation in progress" }, status: :accepted
        else
          render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index
        products = Product.all
        render json: products, status: :ok
      end

      private

      def product_params
        params.require(:product).permit(:name)
      end
    end
  end
end
