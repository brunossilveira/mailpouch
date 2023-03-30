# Preview all emails at http://localhost:3000/rails/mailers/inbox_mailer
class ReminderMailerPreview < ActionMailer::Preview
  def reminder_email
    ReminderMailer.with(user: User.first).reminder_email
  end
end
