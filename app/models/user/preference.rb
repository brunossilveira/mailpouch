class User::Preference < ApplicationRecord
  belongs_to :user

  after_commit :update_next_run_at
  after_commit :schedule_inbox_job

  before_update :clear_fields_when_never

  def clear_fields_when_never
    return true unless period == 'never'

    self.on = nil
    self.at = nil
  end

  def schedule_inbox_job
    return true unless next_inbox_at

    old_job = Sidekiq::ScheduledSet.new.find_job(user.inbox_job_id)
    new_job = InboxJob.perform_at(next_inbox_at, user.id)

    old_job&.delete
    user.update(inbox_job_id: new_job)
  end


  def update_next_run_at
    return true unless next_inbox_at

    user.update(next_inbox_at: next_inbox_at)
  end

  def next_inbox_at
    return nil unless at

    partial_time = Montrose.send(p.period).at(p.at)

    p.daily? ? partial_time.first : partial_time.on(p.on).first
  end

  def daily?
    period == "daily"
  end
end
