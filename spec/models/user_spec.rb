require 'rails_helper'

RSpec.describe 'User', type: :model do
  describe '#should_send_newsletter?' do
    it 'returns false when next_inbox_at is nil' do
      user = User.new
      expect(user.should_send_newsletter?).to be false
    end

    it 'returns false when inbox already sent today' do
      user = User.new(next_inbox_at: 5.minutes.from_now, last_inbox_at: 20.minutes.ago)

      expect(user.should_send_newsletter?).to be false
    end

    it 'returns true when it is the first time' do
      user = User.new(next_inbox_at: 5.minutes.ago)

      expect(user.should_send_newsletter?).to be true
    end

    it 'returns true when it should send the newsletter' do
      user = User.new(next_inbox_at: 5.minutes.ago, last_inbox_at: 24.hours.ago)

      expect(user.should_send_newsletter?).to be true
    end
  end
end
