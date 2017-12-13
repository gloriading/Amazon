class ReviewsController < ApplicationController
  before_action :authenticate_user!
  # this is added afer the method was created in application controller
  before_action :find_product
  before_action :find_review, :authorize_user!, only: [:destroy]

  def create
    # 1 - get new inputs (rating, body) from the new form
    # 2 - pass & store the parameters to the new review
    # 3 - associate the new review with the parent
    # 4 - try to save it

    @review = Review.new(review_params)
    @review.product = @product # associate review to the parent product
    @review.user = current_user
     # in order to add username next to the review, order matters!!!!!!!

    if @review.save
      redirect_to product_path(@product)
    else
      @reviews = @product.reviews.order(created_at: :desc)
      render 'products/show'
    end



  end

  def destroy

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


  def find_review # add this (from destroy)
    @review = Review.find params[:id]
  end

  def authorize_user! # add find_answer, then add before_action on top
    unless can?(:manage, @review)
      flash[:alert] = "Access Denied!"
      redirect_to home_path
    end
  end


end
