require 'rails_helper'

describe 'visitor' do
  context 'admin visits /admin/dashboard' do
    it 'should see a list of stations with all attributes' do
      admin = User.create(username: "penelope", password: "boom", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/dashboard'

      expect(current_path).to eq('/admin/dashboard')
    end
  end
end