FactoryBot.define do
  factory :post do
    date Date.today
    rationale "Some crap"
    user
  end

  factory :second_post, class: "Post" do
    date Date.yesterday
    rationale "Some other crap"
    user
  end
end
