class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @users = User.order(created_at: :desc)
    @number_of_products = Product.count
    @number_of_reviews = Review.count
    @number_of_users = User.count
    @products = Product.order(created_at: :desc)
    
    locations = Location.all
    @hash = Gmaps4rails.build_markers(locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow location.user.full_name
    end

  end

  private

  def authorize_admin!
    redirect_to home_path, alert: 'Access Denied!' unless current_user.is_admin?
  end

end
