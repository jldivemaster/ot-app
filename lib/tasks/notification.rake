namespace :notification do
  desc "Sends SMS notification to employees asking them to log if they had overtime or not"
  task sms: :environment do
    if Time.now.sunday?
      notification_message = "Please log into the OT mgmt dashboard to request OT or confirm your hours. #{request.domain}"
      Employee.all.each do |employee|
        AuditLog.create!(user_id: employee.id)
        SmsTool.send_sms(number: employee.phone, message: notification_message)
      end
    end
  end

  desc "Sends Mail notification to mgrs each day to inform of pending OT requests"
  task manager_email: :environment do
    # User.all.each do |user|
    #   SmsTool.send_sms()
    # end
    submitted_posts = Post.submitted
    admin_users = AdminUser.all

    if submitted_posts.count > 0
      admin_users.each do |admin|
        ManagerMailer.email(admin).deliver_now
      end
    end
  end

end
