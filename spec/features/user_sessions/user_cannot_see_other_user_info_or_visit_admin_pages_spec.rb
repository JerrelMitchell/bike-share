require 'rails_helper'

describe 'user' do
  context 'logged in' do
    it 'should not be able to visit an admin page or other user show page' do
      name1 = 'john316'
      password1 = 'secret'
      user = User.create!(username: name1, password: password1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_admin_trip_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page).to_not have_content("Create a new user!")
    end
  end
  context 'not logged in or is a visitor visiting page' do
    it 'should not be able to visit an admin page or other user show page' do
      visit new_admin_trip_path

      expect(page).to have_link("Log In")
      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page).to_not have_content("Create a new user!")
    end
  end

end
