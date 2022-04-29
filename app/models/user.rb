class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true

  has_one :preference

  after_create :create_preference

  def create_preference
    User::Preference.create(
      user: self,
      period: 'daily',
      at: '12:00'
    )
  end

  def should_send_newsletter?
    return false

    #Time.zone.now > next_inbox_at && next_inbox_at > last_inbox_at
  end
end
