class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true, allow_blank: true

  has_one :preference

  after_create :create_preference

  def create_preference
    preference = User::Preference.create(
      user: self,
      period: 'daily',
      at: '12:00'
    )

    update(next_inbox_at: preference.next_inbox_at)
  end

  def should_send_newsletter?
    return false if next_inbox_at.nil?
    return true if last_inbox_at.nil?

    Time.zone.now > next_inbox_at && next_inbox_at > last_inbox_at
  end
end
