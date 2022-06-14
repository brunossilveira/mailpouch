class User::Preference < ApplicationRecord
  belongs_to :user

  after_commit :update_next_run_at

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
