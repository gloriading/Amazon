class ProductListsController < ApplicationController

  before_action :authorize_user!, only: [:show]

  def show
    # binding.pry
    # @product.user = current_user
    # @product.user_id = user.id
    @products = current_user.products

  end

  private

  def authorize_user!
    unless can?(:manage, @product)
      flash[:alert] = 'Access Denied!'
      redirect_to home_path
    end
  end

end
