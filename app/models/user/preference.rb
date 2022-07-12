class User::Preference < ApplicationRecord
  belongs_to :user

  after_commit :update_next_run_at
  after_commit :schedule_inbox_job

  def schedule_inbox_job
    old_job = Sidekiq::ScheduledSet.new.find_job(user.inbox_job_id)
    new_job = InboxJob.perform_at(next_inbox_at, user.id)

    old_job.delete
    user.update(inbox_job_id: job_id)
  end


  def update_next_run_at
    return true unless period && at

    user.update(next_inbox_at: next_inbox_at)
  end

  def next_inbox_at
    return nil unless period && at

    partial_time = Montrose.send(period).at(at)

    daily? ? partial_time.first : partial_time.on(on).first
  end

  def daily?
    period == "daily"
  end
end
