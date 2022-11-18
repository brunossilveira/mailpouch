class InboxJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find(user_id)

    user.send_inbox

    next_inbox_at = user.preference.next_inbox_at

    InboxJob.perform_at(next_inbox_at, user.id) if next_inbox_at
  end
end
