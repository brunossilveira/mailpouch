class InboxJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find(user_id)

    user.send_inbox

    InboxJob.perform_at(user.next_inbox_at, user.id) if user.next_inbox_at
  end
end
