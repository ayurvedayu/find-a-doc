class Spree::VerificationsController < Spree::HomeController
  def create
    phone = params[:verification][:phone]

    current_spree_user.verifications.update_all status: 'deleted'

    
    vrf = current_spree_user.verifications.new status: 'active', phone: phone

    if vrf.save
      redirect_to spree.account_path, notice: 'Verification code sent to your phone'
    else
      redirect :back, error: 'Verification code could not be sent to your phone'
    end
  end

  def destroy
  end

  def update
    @verification = Spree::Verification.find(params[:id])

    if @verification.update(entered_token: params[:verification][:entered_token])
      redirect_to @verification.verifiable, notice: 'Thanks, phone is verified!'
    else
      render :edit
    end
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

  def edit
    @verification = Spree::Verification.find(params[:id])
  end


end


