require 'rails_helper'

describe 'navigate' do


  describe 'index' do
    it 'can be reached' do
      visit posts_path
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      visit posts_path
      expect(page).to have_content(/Posts/)
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
      fill_in 'post_date', with: '08/22/2019'
      fill_in 'post_rationale', with: "Some stuff"
      click_on "Save"
      expect(page).to have_content("Some stuff")
    end

  end


end
