require 'rails_helper'

RSpec.describe 'InboxJob', type: :job do
  it "sends email when it should" do
    user = instance_double('User', should_send_newsletter?: false)
    InboxJob.perform_now
  end
end
