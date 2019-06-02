require 'rails_helper'

RSpec.feature "List repos" do
  let(:personal_access_token) { 'my_very_own_token' }
  let(:repo_names) { %w(led zeppelin) }

  scenario 'Login and list repos' do
    stub_github_api_call(repo_names: repo_names)

    # visit '/login'
  end

  private

  def stub_github_api_call(repo_names:)
    body = repo_names.map { |name| { name: name } }

    stub_request(:get, "https://api.github.com/user/repos").
      with(headers:
             { 'Accept' => 'application/vnd.github.v3+json',
       	       'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	       'Authorization' => "token #{personal_access_token}",
       	       'Content-Type'=>'application/json',
       	       'User-Agent'=>'Octokit Ruby Gem 4.14.0'})
      .to_return(status: 200, body: body, headers: {})
  end
end
