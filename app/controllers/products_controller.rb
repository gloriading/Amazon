class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  # this is added after the method was created in application controller
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  # the below should be put after :find_question
  before_action :authorize_user!, only: [:edit, :update, :destroy]

#---new product form ----------------------------------------------------------
  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    @product.user = current_user # in order to add username next to the product
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end
#---show a product and its reviews---------------------------------------------
  def show
    # first is to find that row with that id...
    @product.price = @product.price.round(2)
    # in the form field, allow decimals: <%= form.number_field :price, step: :any %>
    @reviews = @product.reviews.order(created_at: :desc)
    @review = Review.new
  end

#---product index---------------------------------------------------------------
  def index
    @products = Product.all.order(created_at: :desc)
    @products_count = Product.count
    
  end

#---search posts by title or body -------------------------------------------
  def search
    @search_results = Product.search(params[:search]) if params[:search].present?
  end

#---delete a product -----------------------------------------------------------
  def destroy

    @product.destroy
    redirect_to products_path
  end

#---edit a product--------------------------------------------------------------
  def edit

  end

  def update

    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end

  end
#-------------------------------------------------------------------------------
  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :sale_price)
  end

  def find_product
    @product = Product.find params[:id]
  end

  def authorize_user!
    unless can?(:manage, @product)
      flash[:alert] = 'Access Denied!'
      redirect_to home_path
    end
  end

end
