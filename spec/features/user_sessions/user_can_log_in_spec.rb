require 'rails_helper'

describe 'visitor' do
  context 'logging in' do
    it 'should log in default user and bring to dashboard' do
      username = 'jerrel2'

      user = User.create!(username: username, password: 'secret')

      visit root_path

      click_on 'Log In'

      expect(current_path).to eq(login_path)

      fill_in :username, with: username
      fill_in :password, with: user.password
      click_button 'Log In'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_link('Log Out')
    end
    it 'can log out of account after signing in' do
      name1 = 'john316'
      password1 = 'secret'
      user = User.create!(username: name1, password: password1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_path(user)

      click_on 'Log Out'

      expect(current_path).to eq(root_path)
    end
  end

  context 'fills out registration form' do
    it 'should make a user account successfully and redirect to dashboard page' do
      username = 'sabrina1'

      visit root_path

      click_on 'Create Account'

      expect(current_path).to eq(new_user_path)

      fill_in :user_username, with: username
      fill_in :user_password, with: 'supersecret'
      fill_in :user_password_confirmation, with: 'supersecret'

      click_on 'Create User'

      expect(current_path).to eq(dashboard_path(User.last.id))
      expect(page).to have_content(username)
    end

    context 'tries to make a username already in use' do
      it 'should not create new user and show an error on the screen' do
        error = 'That username is taken, or information submitted was incomplete. Try again.'
        username = 'sabrina1'
        User.create!(username: username, password: 'password1')

        visit new_user_path

        fill_in :user_username, with: username
        fill_in :user_password, with: 'supersecret'
        fill_in :user_password_confirmation, with: 'supersecret'

        click_on 'Create User'

        expect(page).to have_content(error)
      end
    end
  end
end
