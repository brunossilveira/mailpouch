class InboxJob < ApplicationJob
  def perform
    User.find_each do |user|
      user.send_inbox
    end
  end
end
