require 'rails_helper'

describe 'Homepage' do

  it 'allows the admin to approve posts from homepage' do
    post = FactoryBot.create(:post)
    admin_user = FactoryBot.create(:admin_user)
    login_as(admin_user, :scope => :user)

    visit root_path
    click_on("approve_#{post.id}")

    expect(post.reload.status).to eq('approved')
  end
end
