require 'rails_helper'

RSpec.feature "Login" do
  let(:personal_access_token) { 'my_very_own_token' }
  let(:repo_names) { %w(led zeppelin) }

  scenario "Personal access token is invalid" do
    stub_failed_github_api_call

    visit '/login'

    fill_in 'Personal Access Token', with: personal_access_token
    click_button('Login')

    expect(page).to have_text('That personal access token is invalid!')
  end

  xscenario 'Personal access token is valid' do
    stub_successful_github_api_call(repo_names: repo_names)

    visit '/login'

    fill_in 'Personal Access Token', with: personal_access_token
    click_button('Login')
    
    expect(page).to have_text('Login successful!')
  end

  private

  def stub_failed_github_api_call
    stub_request(:get, "https://api.github.com/user/repos").
      with(headers: { 'Accept' => 'application/vnd.github.v3+json',
       	              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	              'Authorization' => "token #{personal_access_token}",
       	              'Content-Type'=>'application/json',
       	              'User-Agent'=>'Octokit Ruby Gem 4.14.0'})
      .to_return(status: 401, body: '', headers: {})
  end

  def stub_successful_github_api_call(repo_names:)
    body = repo_names.map { |name| { name: name } }

    stub_request(:get, "https://api.github.com/user/repos").
      with(headers: { 'Accept' => 'application/vnd.github.v3+json',
       	              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	              'Authorization' => "token #{personal_access_token}",
       	              'Content-Type'=>'application/json',
       	              'User-Agent'=>'Octokit Ruby Gem 4.14.0'})
      .to_return(status: 200, body: body, headers: {})
  end
end
