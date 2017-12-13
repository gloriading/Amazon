class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  # this is added after the method was created in application controller
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  # the below should be put after :find_question
  before_action :authorize_user!, only: [:edit, :update, :destroy]

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

  def show
    # first is to find that row with that id...

    @product.price = @product.price.round(2)
    # in the form field, allow decimals:
    # <%= form.number_field :price, step: :any %>
    @reviews = @product.reviews.order(created_at: :desc)
    @review = Review.new
  end

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def destroy

    @product.destroy
    redirect_to products_path
  end

  def edit

  end

  def update
    
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end

  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
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
