class SurveysController < ApplicationController

  before_action :authenticate_user!

   def new
     @survey = Survey.new
     2.times { @survey.options.build }
   end

   def create

     @survey = Survey.new survey_params
     if @survey.save
       render plain: 'success'
     else
       render :new
     end
   end

   private
   def survey_params
     params.require(:survey).permit(
       :body, { options_attributes: [:body, :id, :_destroy] })
   end

end
