class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def show
    current_user.set_payment_processor(:stripe)
    current_user.payment_processor.customer

    @checkout_session = current_user.payment_processor.checkout(
      mode: "subscription",
      line_items: "price_1LepW7CTF1HsdpZG7awop8A2"
    )
  end
end