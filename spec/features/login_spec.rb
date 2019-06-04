require 'rails_helper'

RSpec.feature "Login" do
  let(:personal_access_token) { 'my_very_own_token' }
  let(:repo_names) { %w(travisjeffery/timecop thoughtbot/shoulda-matchers) }

  scenario "Personal access token is invalid" do
    stub_failed_github_api_call

    visit '/login'

    fill_in 'Personal Access Token', with: personal_access_token
    click_button('Login')

    expect(page).to have_text('Enter your GitHub personal access token below')
    expect(page).to have_text('That personal access token is invalid!')
  end

  scenario 'Personal access token is valid' do
    stub_successful_github_api_call(repo_names: repo_names)

    visit '/login'

    fill_in 'Personal Access Token', with: personal_access_token
    click_button('Login')
    
    expect(page).to have_text('Login successful!')

    click_link('Repos')

    expect(page).to have_text('Repos:')
  end
end
