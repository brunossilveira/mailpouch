class ApplicationController < ActionController::Base
  before_action :redirect_if_no_username
  before_action :create_checkout_session

  def create_checkout_session
    if current_user && !current_user.subscribed?
      current_user.set_payment_processor(:stripe)
      current_user.payment_processor.customer

      @checkout_session = current_user.payment_processor.checkout(
        mode: "subscription",
        line_items: "price_1LepW7CTF1HsdpZG7awop8A2"
      )
    end
  end


  def redirect_if_no_username
    if current_user && !current_user.username.present? && controller_name != "profile"
      flash[:notice] = "Please set a username so you can start subscribing to newsletters!"
      redirect_to profile_path
    end
  end
end
