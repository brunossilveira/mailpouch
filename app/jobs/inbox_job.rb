class InboxJob < ApplicationJob
  def perform
    User.find_each do |user|
      return if !user.should_send_newsletter?

      InboxMailer.with(user: user).inbox_email.deliver_later
    end
  end
end
