class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def show
    current_user.set_payment_processor(:stripe)

    @checkout_session = current_user.payment_processor.checkout(
      mode: "subscription",
      line_items: [ENV.fetch('STRIPE_PRICE_ID_USD', 'price_1LepW7CTF1HsdpZG7awop8A2'), ENV.fetch('STRIPE_PRICE_ID_BRL', 'price_1LepW7CTF1HsdpZG7awop8A2')]
    )
  end
end
