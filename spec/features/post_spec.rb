require 'rails_helper'

describe 'navigate' do
  before do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
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
      post1 = FactoryGirl.build_stubbed(:post)
      post2 = FactoryGirl.build_stubbed(:second_post)
      visit posts_path
      expect(page).to have_content(/crap|other/)
    end
  end

  describe 'new' do
    it 'has a link from homepage' do
      visit root_path
      click_link("new_post_from_nav")
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

    it 'can be created from new page' do
      fill_in 'post_date', with: Date.today
      fill_in 'post_rationale', with: "Some stuff"
      click_on "Save"
      expect(page).to have_content("Some stuff")
    end

    it 'will have a user associated with it' do
      fill_in 'post_date', with: Date.today
      fill_in 'post_rationale', with: "User_Assoc"
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("User_Assoc")
    end
  end

  describe 'edit' do
    before do
      @post = FactoryGirl.create(:post)
    end

    it 'can be reached by clicking edit on index page' do
      visit posts_path
      click_link("edit_#{@post.id}")
      expect(page.status_code).to eq(200)
    end

    it 'can be edited' do
      visit edit_post_path(@post)
      fill_in 'post_date', with: Date.today
      fill_in 'post_rationale', with: "Edited_Content"
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("Edited_Content")
    end
  end


end
