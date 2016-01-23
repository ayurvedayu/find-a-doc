class Spree::ConfirmationsController < Devise::ConfirmationsController
  helper 'spree/base', 'spree/store'

  if Spree::Auth::Engine.dash_available?
    helper 'spree/analytics'
  end

  include Spree::Core::ControllerHelpers::Auth
  include Spree::Core::ControllerHelpers::Common
  include Spree::Core::ControllerHelpers::Order
  include Spree::Core::ControllerHelpers::Store

  before_filter :check_permissions, :only => [:edit, :update]
  skip_before_filter :require_no_authentication
  def new
   super
  end

  def create
    super
  end

  def update
    super
  end

  def show
    super
  end

  def after_confirmation_path_for(resource_name, resource)
    if signed_in?
      signed_in_root_path(resource)
    else
      login_path
    end
  end
end