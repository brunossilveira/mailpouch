class ApplicationController < ActionController::Base
  before_action :set_user_timezone
  before_action :redirect_if_no_username
  before_action :create_checkout_session
  before_action :load_preference
  before_action :save_last_access_at
  before_action :set_categories

  def set_user_timezone(&block)
    current_user.preference.update(timezone: timezone_from_cookies) if current_user && current_user.preference.timezone.nil?
  end

  def timezone_from_cookies
    cookies.fetch(:timezone, nil)
  end

  def create_checkout_session
    if current_user && !current_user.subscribed?
      current_user.set_payment_processor(:stripe)
      current_user.payment_processor.customer

      @checkout_session = current_user.payment_processor.checkout(
        mode: "subscription",
        line_items: ENV.fetch('STRIPE_PRICE_ID', 'price_1MbDpuCTF1HsdpZGYzlkgvKd')
      )
    end
  end

  def redirect_if_no_username
    if current_user && !current_user.username.present? && controller_name != "profile"
      flash[:notice] = "Please set a username so you can start subscribing to newsletters!"
      redirect_to profile_path
    end
  end

  def load_preference
    @preference = current_user&.preference
  end

  def save_last_access_at
    current_user&.update(last_access_at: Time.zone.now)
  end

  def set_categories
    @categories = Newsletter.pluck(:category).compact.map(&:downcase).uniq
  end
end
