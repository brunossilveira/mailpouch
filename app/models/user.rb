class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true, allow_blank: true

  has_one :preference

  after_create :create_preference

  def create_preference
    User::Preference.create(user: self)
  end

  def should_send_newsletter?
    return false if next_inbox_at.nil?

    if last_inbox_at
      Time.zone.now > next_inbox_at && next_inbox_at > last_inbox_at
    else
      Time.zone.now > next_inbox_at
    end
  end

  def send_inbox
    return unless should_send_newsletter?

    newsletter_messages = NewsletterMessage.where(user: self).where(created_at: (last_inbox_at..next_inbox_at)).order(created_at: :desc)

    return if newsletter_messages.count.zero?

    InboxMailer.with(user: self, newsletter_messages: newsletter_messages).inbox_email.deliver_now

    update(last_inbox_at: Time.zone.now, next_inbox_at: preference.next_inbox_at)

    Event.create(user: self, name: 'send_inbox', description: "Count: #{newsletter_messages.count} | Ids: #{newsletter_messages.ids}")
  end
end
