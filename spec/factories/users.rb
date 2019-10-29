FactoryBot.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    first_name 'Jon'
    last_name 'Snow'
    email { generate :email }
    password 'asdfasdf'
    password_confirmation 'asdfasdf'
  end

  factory :second_user, class: "User" do
    first_name 'Albert'
    last_name 'Einstein'
    email { generate :email }
    password 'relativity'
    password_confirmation 'relativity'
  end

  factory :admin_user, class: "AdminUser" do
    first_name 'Mr'
    last_name 'Admin'
    email { generate :email }
    password 'asdfasdf'
    password_confirmation 'asdfasdf'
  end

  factory :non_authorized_user, class: "User" do
    first_name 'Mr'
    last_name 'Non Authorized'
    email { generate :email }
    password 'asdfasdf'
    password_confirmation 'asdfasdf'
  end
end
