
@employee = Employee.create!(first_name: "Jason", last_name: "Leach", email: "jlspursfan@seeds.com",
            password: "asdfasdf", password_confirmation: "asdfasdf", phone: "7343898627", ssn: 1234, company: "Company Name")
puts "1 Employee created"

AdminUser.create!(first_name: "Admin", last_name: "User", email: "admin@seeds.com",
        password: "asdfasdf", password_confirmation: "asdfasdf", phone: "7343898627", ssn: 1234, company: "Company Name")

puts "1 AdminUser created"

AuditLog.create!(user_id: @employee.id, status: 0, start_date: (Date.today - 6.days))
AuditLog.create!(user_id: @employee.id, status: 0, start_date: (Date.today - 13.days))
AuditLog.create!(user_id: @employee.id, status: 0, start_date: (Date.today - 20.days))

puts "Audit Logs have been created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content lorem ipsum some other yadayada content stuff and face", status: 0, user_id: @employee.id, overtime_request: 2.5 )
end

puts "100 Posts have been created"
