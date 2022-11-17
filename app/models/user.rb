class User < ApplicationRecord
  pay_customer

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true, allow_blank: true

  has_one :preference

  after_create :create_preference
  after_create :create_free_trial


  def create_preference
    User::Preference.create(user: self)
  end

  def create_free_trial
    trial_time = 7.days.from_now
    set_payment_processor :fake_processor, allow_fake: true
    payment_processor.subscribe(trial_ends_at: trial_time, ends_at: trial_time)
  end

  def should_send_inbox?
    return false if preference.next_inbox_at.nil? || !subscribed?

    Time.use_zone(preference.timezone) do
      now = Time.zone.now

      Event.create(user: self, name: 'should_send_inbox?', description: "last_inbox_at : #{last_inbox_at} | now: #{Time.zone.now} | next_inbox_at: #{preference.next_inbox_at}")

      if last_inbox_at
        now > preference.next_inbox_at && preference.next_inbox_at > last_inbox_at
      else
        now > preference.next_inbox_at
      end
    end
  end

  def subscribed?
    has_active_subscription? || on_trial?
  end

  def on_trial?
    payment_processor&.on_trial?
  end

  def send_inbox
    newsletter_messages = NewsletterMessage.where(user: self).where(created_at: (last_inbox_at..preference.next_inbox_at)).order(created_at: :desc)

    if !newsletter_messages.count.zero?
      InboxMailer.with(user: self, newsletter_messages: newsletter_messages).inbox_email.deliver_now

      Event.create(user: self, name: 'send_inbox', description: "Count: #{newsletter_messages.count} | Ids: #{newsletter_messages.ids}")
    end

    update(last_inbox_at: Time.zone.now)
  end

  private

  def has_active_subscription?
    pay_customers.map(&:subscription).compact.map(&:active?).compact.include?(true)
  end
end
