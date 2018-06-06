require 'rails_helper'

describe 'user or admin' do
  context 'fills out edit account form' do
    it 'should update user account successfully and redirect to dashboard page' do
      name1 = 'john316'
      new_name = 'JohnJohn'
      password1 = 'secret'
      user = User.create!(username: name1, password: password1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_path(user)

      click_on 'Edit Profile'

      fill_in :user_username, with: new_name
      fill_in :user_password, with: 'supersecret'
      fill_in :user_password_confirmation, with: 'supersecret'

      click_on 'Update User'

      expect(current_path).to eq(dashboard_path(User.last.id))
    end
  end
  context 'does not completely fill out edit account form' do
    it 'should not update user account successfully and render with error' do
      name1 = 'john316'
      new_name = 'JohnJohn'
      password1 = 'secret'
      user = User.create!(username: name1, password: password1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit edit_user_path(user)

      fill_in :user_username, with: new_name

      click_on 'Update User'

      expect(page).to have_content('Editing User Profile')
      expect(page).to have_content('Please make sure your passwords match!')
    end
  end
end
