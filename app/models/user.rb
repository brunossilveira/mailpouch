class User < ApplicationRecord
  pay_customer

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :username, length: {minimum: 5, maximum: 16}, format: { with: /\A[a-z0-9]+\Z/, message: 'must contain lower case letters, number and no white spaces' }, uniqueness: true, allow_blank: true
  validates :email, uniqueness: true

  has_one :preference, dependent: :destroy

  after_create :create_preference
  after_create :create_free_trial

  after_create do
    self.username = email.split('@').first
    self.username = nil unless valid?
    save
  end

  def self.from_omniauth(auth)
    email = auth.info.email
    find_or_create_by(email: email) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.provider = auth.provider
      user.uid = auth.uid

      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def mailbox_email_address
    domain = ENV.fetch('MAILBOX_EMAIL_DOMAIN', 'inbox.mailpouch.app')

    "#{username}@#{domain}"
  end

  def create_preference
    User::Preference.create(user: self)
  end

  def create_free_trial
    trial_time = 7.days.from_now
    set_payment_processor :fake_processor, allow_fake: true
    payment_processor.subscribe(trial_ends_at: trial_time, ends_at: trial_time)
  end

  def should_send_inbox?
    preference.next_inbox_at.present? && subscribed?
  end

  def subscribed?
    has_active_subscription? || on_trial?
  end

  def on_trial?
    payment_processor&.on_trial?
  end

  def send_inbox
    return unless should_send_inbox?

    newsletter_messages = NewsletterMessage.inbox_messages_by(user: self)

    if !newsletter_messages.count.zero?
      InboxMailer.with(user: self, newsletter_messages: newsletter_messages).inbox_email.deliver_now

      Event.create(user: self, name: 'send_inbox', description: "Count: #{newsletter_messages.count} | Ids: #{newsletter_messages.ids}")

      newsletter_messages.update_all(read: true)
    end

    update(last_inbox_at: Time.zone.now)
  end

  private

  def has_active_subscription?
    pay_customers.map(&:subscription).compact.map(&:active?).compact.include?(true)
  end
end
