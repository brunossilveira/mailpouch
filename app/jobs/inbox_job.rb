class InboxJob < ApplicationJob
  def perform
    Event.create(user: User.first, name: 'started_inbox_job')

    User.all.each do |user|
      user.send_inbox
    end

    Event.create(user: User.first, name: 'finished_inbox_job')
  end
end
