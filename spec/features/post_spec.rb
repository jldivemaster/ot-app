require 'rails_helper'

describe 'navigate' do
  let(:user) { FactoryBot.create(:user) }
  let(:post) do
    Post.create(date: Date.today, rationale: "Rationale", user_id: user.id, overtime_request: 3.5)
  end

  before do
    login_as(user, :scope => :user)
  end

  describe 'index' do
    before do
      visit posts_path
    end

    it 'can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of posts' do
      post1 = FactoryBot.build_stubbed(:post)
      post2 = FactoryBot.build_stubbed(:second_post)
      visit posts_path
      expect(page).to have_content(/Rationale|content/)
    end

    it 'has a scope so that only post creators can see their posts' do
      non_authorized_user = User.create(first_name: 'Non', last_name: 'Authorized', email: 'nonauth@test.com', password: 'asdfasdf', password_confirmation: 'asdfasdf', phone: '5555555555')
      post_from_other_user = Post.create(date: Date.today, rationale: 'This post should not be seen', user_id: non_authorized_user.id, overtime_request: 4.0)

      visit posts_path
      expect(page).to_not have_content(/This post should not be seen/)
    end
  end

  describe 'new' do
    it 'has a link from homepage' do
      visit root_path
      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      logout(:user)
      delete_user = FactoryBot.create(:user)
      login_as(delete_user, :scope => :user)

      post_to_delete = Post.create(date: Date.today, rationale: "Rationale", user_id: delete_user.id, overtime_request: 2.0)

      visit posts_path

      click_link("delete_post_#{post_to_delete.id}_from_index")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'creation' do
    before do
      visit new_post_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'post_date', with: Date.today
      fill_in 'post_rationale', with: "Some stuff"
      fill_in 'post_overtime_request', with: 4.5

      expect { click_on "Save" }.to change(Post, :count).by(1)
    end

    it 'will have a user associated with it' do
      fill_in 'post_date', with: Date.today
      fill_in 'post_rationale', with: "User_Assoc"
      fill_in 'post_overtime_request', with: 4.5
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("User_Assoc")
    end
  end

  describe 'edit' do
    before do
      @edit_user = User.create(first_name: 'asdf', last_name: 'asdf', email: 'asdf@gmail.com', password: 'asdfasdf', password_confirmation: 'asdfasdf', phone: "5555555555")
      login_as(@edit_user, :scope => :user)
      @edit_post = Post.create(date: Date.today, rationale: 'asdf', user_id: @edit_user.id, overtime_request: 5.0)
    end

    it 'can be edited' do
      visit edit_post_path(@edit_post)
      fill_in 'post_date', with: Date.today
      fill_in 'post_rationale', with: "Edited_Content"
      click_on "Save"

      expect(page).to have_content("Edited_Content")
    end

    it 'cannot be edited by a non-authorized user' do
      logout(:user)
      non_authorized_user = FactoryBot.create(:non_authorized_user)
      login_as(non_authorized_user, :scope => :user)

      visit edit_post_path(post)

      expect(current_path).to eq(root_path)
    end
  end


end
