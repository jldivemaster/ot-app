
@user = User.create!(first_name: "Jason", last_name: "Leach", email: "jlspursfan@gmail.com", password: "asdfasdf", password_confirmation: "asdfasdf")
puts "1 User created"

AdminUser.create!(first_name: "Admin", last_name: "User", email: "admin@gmail.com", password: "asdfasdf", password_confirmation: "asdfasdf")
puts "1 AdminUser created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content", user_id: @user.id)
end

puts "100 Posts have been created"
