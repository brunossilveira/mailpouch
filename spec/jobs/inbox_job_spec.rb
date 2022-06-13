require 'rails_helper'

RSpec.describe 'InboxJob', type: :job do
  it "sends email when it should" do
    User.create(email: 'test@email.com', password: 'password', next_inbox_at: 5.minutes.ago)
    User.create(email: 'test@email.com', password: 'password', next_inbox_at: nil)
    User.create(email: 'test@email.com', password: 'password', next_inbox_at: nil)

    InboxJob.new.perform

    expect(Event.count).to eq(1)
  end
end
