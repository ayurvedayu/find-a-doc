class AddAppointmentToSpreeReviews < ActiveRecord::Migration
  def change
    add_reference :spree_reviews, :appointment, index: true
  end
end
