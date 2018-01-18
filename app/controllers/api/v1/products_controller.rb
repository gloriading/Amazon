class Api::V1::ProductsController < Api::ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: [:show, :destroy, :update]

  	def index
      @products = Product.order(created_at: :desc)
  		render json: @products
      # When use jbuilder, need to pass @products to the view (index.json.jbuilder)
      # don't need the above line if we use jbuilder

      # When use serializer, we don't need @ in front since there's no before_action
      # But we need `render json @products` to override jbuilder
  	end

    def show
      render json: @product
      # there's a before_action for show, so we need @
      # the line above will be over-ridden by serializer
    end

  	def create
      # Here we don't apply before_action so no need to use @
      product = Product.new product_params
      product.user = current_user
      if product.save
        render json: { id: product.id }
        # render json: product # show all the info of this product
      else
        render json: { error: product.errors.full_messages}
      end

    end

    def destroy
      if @product.destroy
        # head :ok
        render json: { message: 'You deleted it!' }
      else
        # head :bad_request
        render json: { error: 'Could not destroy product.' }
        # the situation (delete the same product twice) is unlikely to shown
      end
    end

    def update
      if @product.update product_params
        # head :ok
        # render json: { id: @product.id }
        render json: @product

      else
        render json: { error: @product.errors.full_messages}
      end
    end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :sale_price, { tag_ids: [] })
  end

  def find_product
    @product = Product.find params[:id]
  end

end
