require 'rails_helper'

RSpec.feature "Issues", type: :feature do
  let(:personal_access_token) { 'my_very_own_token' }
  let(:repo_names) { %w(led zeppelin) }

  scenario "User is logged in" do
    stub_successful_github_api_call(repo_names: repo_names)

    login

    visit '/repos'

    click_link(repo_names.last)

    expect(page).to have_text('Issues:')
  end

  private

  def login
    visit '/login'

    fill_in 'Personal Access Token', with: personal_access_token
    click_button('Login')
  end
end
