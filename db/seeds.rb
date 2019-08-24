puts "1 User created"
@user = User.create!(first_name: "Jason", last_name: "Leach", email: "yourmom@sucks.com", password: "asdfasdf", password_confirmation: "asdfasdf")

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content", user_id: @user.id)
end

puts "100 Posts have been created"
