class ContactController < ApplicationController
  def new
  end

  def create
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
  #   if !@name
  #     flash[:alert] = 'Please leave your name!'
  #     render :new
  end
end
