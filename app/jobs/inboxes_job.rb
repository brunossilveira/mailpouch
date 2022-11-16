class InboxesJob
  include Sidekiq::Job

  def perform
    User.find_each do |user|
      InboxJob.perform_later(user) if user.should_send_inbox?
    end
  end
end
