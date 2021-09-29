require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  let(:user) { User.create(username: 'John', password: 'abcdefg') }

  describe "Log in user" do
    it "Happy path" do
      visit '/login'

      fill_in 'username', with: user.username
      fill_in 'password', with: user.password

      click_button 'Log In'

      expect(page).to have_text('John')
      expect(page).to have_text('Jobs')
    end

    it "Wrong user" do
      visit '/login'

      fill_in 'username', with: "Peter"
      fill_in 'password', with: user.password

      click_button 'Log In'

      expect(page).to have_text('Wrong user')
    end

    it "Wrong password" do
      visit '/login'

      fill_in 'username', with: user.username
      fill_in 'password', with: "124214"

      click_button 'Log In'

      expect(page).to have_text('Wrong password')
    end
  end

  describe "Log out user" do
    it "Happy path" do
      visit '/login'

      fill_in 'username', with: user.username
      fill_in 'password', with: user.password

      click_button 'Log In'

      expect(page).to have_text('John')
      
      click_link 'Log Out'

      expect(page).to have_text('You have logged out')
    end
  end
end
