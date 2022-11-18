class User::Preference < ApplicationRecord
  belongs_to :user

  before_update :clear_fields_when_never
  after_update :reschedule_inbox_job

  def reschedule_inbox_job
    remove_scheduled_job

    InboxJob.perform_at(next_inbox_at, user.id) if next_inbox_at
  end

  def clear_fields_when_never
    return true unless period == 'never'

    self.on = nil
    self.at = nil
  end

  def next_inbox_at
    return nil unless at

    Time.use_zone(timezone) do
      partial_time = Montrose.send(period).at(at)

      daily? ? partial_time.first : partial_time.on(on).first
    end
  end

  def daily?
    period == "daily"
  end

  def remove_scheduled_job
    queue = Sidekiq::ScheduledSet.new
    queue.each do |job|
      job.delete if (job.klass == 'InboxJob' && job.args.first == user.id)
    end
  end
end
