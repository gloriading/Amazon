class Api::V1::ProductsController < Api::ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: [:show, :destroy]

  	def index
      @products = Product.order(created_at: :desc)
  		# render json: Product.all
  	end

    def show
      render json: @product
      # the line above will be over-ridden by serializer
    end

  	def create
      product = Product.new product_params
      product.user = current_user
      if product.save
        render json: { id: product.id }
      else
        render json: { error: product.errors.full_messages}
      end

       # render json: params
    end


    def destroy
      if @product.destroy
        head :ok
      else
        head :bad_request
      end
    end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :sale_price)
  end

  def find_product
    @product = Product.find params[:id]
  end

end
