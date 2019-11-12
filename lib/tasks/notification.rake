namespace :notification do
  desc "Sends SMS notification to employees asking them to log if they had overtime or not"
  task sms: :environment do
    # User.all.each do |user|
    #   SmsTool.send_sms()
    # end

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
        ManagerMailer.email(admin).deliver_later
      end
    end
  end

end
