class InboxJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find(user_id)

    user.send_inbox

    Event.create(user: user, name: 'inbox_job')
  end
end
