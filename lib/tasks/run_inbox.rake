desc "Runs inbox"
task run_inbox: :environment do
  Event.create(user: User.first, name: 'started_inbox_task')

  InboxJob.perform_later

  Event.create(user: User.first, name: 'finished_inbox_task')
end
