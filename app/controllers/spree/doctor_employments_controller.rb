class Spree::DoctorEmploymentsController < Spree::HomeController
  def destroy
    @employment = current_spree_user.doctor.doctor_employments.find(params[:id])
    if @employment.destroy
      redirect_to spree.edit_account_path, notice: 'employment was successfully destroyed.'
    else
      redirect_to spree.edit_account_path, alert: 'employment was not successfully destroyed.'
    end
  end
end