class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show
    # first is to find that row with that id...
    @product = Product.find params[:id]
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
    @product = Product.find params[:id]
    @product.destroy
    redirect_to products_path
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]
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

end
