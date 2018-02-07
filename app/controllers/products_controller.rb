class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  # this is added after the method was created in application controller
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  # the below should be put after :find_question
  before_action :authorize_user!, only: [:edit, :update, :destroy]

#---new product form ----------------------------------------------------------
  def new
    @product = Product.new
    @product.faqs.build
  end

  def create
    @product = Product.new product_params
    @product.user = current_user # in order to add username next to the product
    if @product.save
      # ProductMailer.notify_product_owner(@product).deliver_now
      #--[JOB]-----------------------------------------------------
      ProductCreateReminderJob.set(wait:10.seconds).perform_later
      # ProductCreateReminderJob.perform_now
      #------------------------------------------------------------
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

    # @reviews = @product.reviews.order(created_at: :desc)
    @reviews = @product.reviews.sort{|b, a| a.review_votes_result <=> b.review_votes_result} # sort by total # of votes desc

    @review = Review.new
    @user_like = current_user.likes.find_by_product_id(@product) if user_signed_in?
    @user_favourite = current_user.favourites.find_by_product_id(@product) if user_signed_in?
    @user_vote = current_user.votes.find_by_product_id(@product) if user_signed_in?

    @faqs = @product.faqs
  end

#---product index---------------------------------------------------------------
  def index

    @products_count = Product.count

    @liked = params[:liked]
    @favourited = params[:favourited]
     #this is get from application.html.erb `{liked: true}` `{favourited: true}`

    if @liked
      @products = current_user.liked_products
    elsif @favourited
      @products = current_user.favourited_products
    else
      @products = Product.all.order(created_at: :desc)
    end

    respond_to do |format|
        format.html { render }
        format.json { render json: @products}
         # go to http://localhost:3000/products.json to show all the data
        format.xml { render xml: @products}
    end

  end

#---search posts by title or body -------------------------------------------
  def search
    @search_results = Product.search_it(params[:search_it]) if params[:search_it].present?
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
    @product.slug = nil
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end

  end
#-------------------------------------------------------------------------------
  private

  def product_params
    params.require(:product).permit(
      :title,
      :description,
      :price,
      :sale_price,
      :image, { tag_ids: [] },
      { faqs_attributes: [:question, :answer, :id, :_destroy] }
    )
  end

  def find_product
    @product = Product.find params[:id]
  end

  def authorize_user!
    unless can?(:crud, @product)
      flash[:alert] = 'Access Denied!'
      redirect_to home_path
    end
  end

end
