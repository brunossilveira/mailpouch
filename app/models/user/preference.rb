class User::Preference < ApplicationRecord
  belongs_to :user

  before_update :clear_fields_when_never

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
end
