require 'rails_helper'

feature 'creating a warble', type: :feature do 
  before(:each) do
    create(:user)
    # visit new_warble_url
  end

  scenario 'takes a body' do
    log_user_in(User.last)
    visit new_warble_url
    # save_and_open_page
    # opens the page on your browser the way that capybara sees your page
    # save_and_open_page
    # have content will look at the page for the text 'New Warble'
    # capitalization matters!!!
    expect(page).to have_content 'New Warble'
    expect(page).to have_content 'Body'
  end

  scenario 'takes us to warbles show' do
    log_user_in(User.last)
    visit new_warble_url
    make_warble('Go Wolves?')
    
    # save_and_open_page
    expect(page).to have_content('Go Wolves?')
  end
  
end

feature 'dewarbling a warble', type: :feature do
  before(:each) do
    create(:user)
    log_user_in(User.last)
    make_warble('to be deleted...')
    # save_and_open_page
    click_button('Delete Warble')
  end

  scenario 'dewarbling' do
    # save_and_open_page
    expect(page).to_not have_content('to be deleted...')
    expect(page).to have_content('All Warbles')
  end
end