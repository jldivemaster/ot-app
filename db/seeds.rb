
@user = User.create!(first_name: "Jason", last_name: "Leach", email: "jlspursfan@gmail.com",
            password: "asdfasdf", password_confirmation: "asdfasdf", phone: "7343898627")
puts "1 User created"

AdminUser.create!(first_name: "Admin", last_name: "User", email: "admin@gmail.com",
        password: "asdfasdf", password_confirmation: "asdfasdf", phone: "7343898627")

puts "1 AdminUser created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content", status: 0, user_id: @user.id, overtime_request: 2.5 )
end

puts "100 Posts have been created"

100.times do |audit_log|
  AuditLog.create!(user_id: User.last.id, status: 0, start_date: (Date.today - 6.days))
end

puts "100 Audit Logs have been created"
