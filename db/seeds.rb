100.times do |post|
  Post.create(date: Date.today, rationale: "#{post} rationale content")
end

puts "100 Posts have been created"

User.create!(first_name: "Jason", last_name: "Leach", email: "yourmom@sucks.com", password: "asdfasdf", password_confirmation: "asdfasdf")
