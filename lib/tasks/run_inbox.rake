desc "Runs inbox"
task run_inbox: :environment do
  puts "Running Inbox"
  InboxJob.perform_later
  puts "Finished running inbox"
end
