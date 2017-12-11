class ReviewsController < ApplicationController
  before_action :find_product

def create
  @review = Review.new(review_params)
  @review.product = @product

  if @review.save
    redirect_to product_path(@product)
  else
    @reviews = @product.reviews.order(created_at: :desc)
    render 'products/show'
  end
end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to product_path(@product)
  end


private
def review_params
  params.require(:review).permit(:rating, :body)
end

def find_product
  @product = Product.find params[:product_id]
end




end
