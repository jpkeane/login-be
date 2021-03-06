module Api
  module V1
    class ProductsController < ApiV1Controller
      before_action :set_product, only: [:show, :update, :destroy]

      # GET /products
      def index
        @products = Product.all
        authorize @products

        render json: @products
      end

      # GET /products/1
      def show
        authorize @product
        render json: @product
      end

      # POST /products
      def create
        @product = Product.new(product_params)

        authorize @product
        if @product.save
          render json: @product, status: :created
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /products/1
      def update
        authorize @product
        if @product.update(product_params)
          render json: @product
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      # DELETE /products/1
      def destroy
        authorize @product
        @product.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def product_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
    end
  end
end
