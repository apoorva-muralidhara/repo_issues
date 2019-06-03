require 'rails_helper'

RSpec.feature "Repos", type: :feature do
  let(:personal_access_token) { 'my_very_own_token' }
  let(:repo_names) { %w(led zeppelin) }

  scenario "User is not logged in" do
    visit '/repos'

    expect(page).to have_text('You are not logged in!')
  end

  scenario "User is logged in" do
    stub_successful_github_api_call(repo_names: repo_names)

    login

    visit '/repos'

    repo_names.each do |repo_name|
      expect(page).to have_text(repo_name)
    end
  end

  private

  def login
    visit '/login'

    fill_in 'Personal Access Token', with: personal_access_token
    click_button('Login')
  end
end
