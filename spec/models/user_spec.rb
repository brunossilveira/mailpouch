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

  describe '#send_inbox' do
    it 'works' do
      user = User.create(email: 'user@email.com', password: 'password', next_inbox_at: 5.minutes.ago, last_inbox_at: 24.hours.ago)

      newsletter = Newsletter.create(name: '1', email: '1@email.com', user: user)
      newsletter2 = Newsletter.create(name: '2', email: '2@email.com', user: user)

      NewsletterMessage.create(body: 'body', created_at: 15.minutes.ago, user: user, newsletter: newsletter)
      NewsletterMessage.create(body: 'body', created_at: 15.minutes.ago, user: user, newsletter: newsletter2)

      user.send_inbox

      expect(Event.count).to eq(1)
    end
  end
end
