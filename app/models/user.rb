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

  def should_send_newsletter?
    return false if next_inbox_at.nil? || !subscribed?

    if last_inbox_at
      Time.zone.now > next_inbox_at && next_inbox_at > last_inbox_at
    else
      Time.zone.now > next_inbox_at
    end
  end

  def subscribed?
    payment_processor&.subscription&.active?
  end

  def send_inbox
    return unless should_send_newsletter?

    newsletter_messages = NewsletterMessage.where(user: self).where(created_at: (last_inbox_at..next_inbox_at)).order(created_at: :desc)

    if !newsletter_messages.count.zero?
      InboxMailer.with(user: self, newsletter_messages: newsletter_messages).inbox_email.deliver_now

      Event.create(user: self, name: 'send_inbox', description: "Count: #{newsletter_messages.count} | Ids: #{newsletter_messages.ids}")
    end


    new_job = InboxJob.perform_at(self.preference.next_inbox_at, self.id)

    update(last_inbox_at: Time.zone.now, next_inbox_at: preference.next_inbox_at, inbox_job_id: new_job)
  end
end
