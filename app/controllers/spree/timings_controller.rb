class Spree::TimingsController < ApplicationController
  def index
    date = Date.new(Date.today.year,params[:month].to_i,params[:day].to_i)

    @slots = Spree::TimeSlot.all_for_doctor(params[:doctor_employee_id], date: date)
    
    respond_to do |format|
      format.js {}
    end
  end
end
