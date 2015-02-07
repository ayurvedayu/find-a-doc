class Spree::VerificationsController < ApplicationController
  def create
    phone = params[:verification][:phone]

    current_spree_user.verifications.update_all status: 'deleted'

    
    vrf = current_spree_user.verifications.new status: 'active', phone: phone

    if vrf.save
      redirect_to spree.account_path, notice: 'Verification code sent to your phone'
    end
  end

  def destroy
  end

  def update
  end

  def complete
    vrf = current_spree_user.verifications.active.last

    if params[:verification][:token].eql? vrf.token
      current_spree_user.update(phone_is_verified: true)
      vrf.update status: 'completed'
      redirect_to spree.account_path, notice: 'Your phone is succesfully verified, thank you.'
    else
      redirect_to spree.account_path, alert: 'Wrong activation code.'
    end
  end


end


