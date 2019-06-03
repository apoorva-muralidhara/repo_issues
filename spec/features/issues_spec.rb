require 'rails_helper'

RSpec.feature "Issues", type: :feature do
  let(:personal_access_token) { 'my_very_own_token' }
  let(:repo_names) { %w(travisjeffery/timecop thoughtbot/shoulda-matchers) }

  let(:earlier) { Time.zone.local(2018, 3, 18, 16, 30, 45).time }
  let(:later) { Time.zone.local(2019, 1, 25, 15, 15, 45).time }

  let(:formatted_earlier_date) { '18/03/2018' }

  let(:later_ago_in_words) { '4 months ago' }

  let(:first_title) { 'Gem never works, unfortunately' }
  let(:second_title) { 'Actually, gem always works, fortunately' }

  let(:avatar_url) { 'https://avatars1.githubusercontent.com/u/7371?v=4' }

  let(:body) do
    [{ title: first_title, created_at: earlier, updated_at: later, assignee: nil },
     { title: second_title, created_at: earlier, updated_at: earlier,
       assignee: { avatar_url: avatar_url } }]
  end
  
  scenario "Shows issues for repo" do
    stub_successful_github_api_call(repo_names: repo_names)


    login
    click_on_repo_link
    
    expect(page).to have_text('Issues:')

    expect(page).to have_text(first_title)
    expect(page).to have_text(second_title)

    expect(page).to have_text(formatted_earlier_date)
    expect(page).to have_text(later_ago_in_words)

    expect(page).to have_xpath("//img[contains(@src, '#{avatar_url}')]")
  end

  scenario "Has link back to repos page" do
    stub_successful_github_api_call(repo_names: repo_names)

    login
    click_on_repo_link

    expect(page).to have_text('Issues:')

    click_link('Repos')

    expect(page).to have_text('Repos:')
  end

  private

  def login
    visit '/login'

    fill_in 'Personal Access Token', with: personal_access_token
    click_button('Login')
  end

  def click_on_repo_link
    visit '/repos'

    stub_successful_github_api_issues_call
    click_link(repo_names.last)
  end


  def stub_successful_github_api_issues_call
    stub_request(:get,
                 "https://api.github.com/repos/#{repo_names.last}/issues")
      .with(headers: { 'Accept' => 'application/vnd.github.v3+json',
       	               'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	               'Content-Type' => 'application/json',
       	               'User-Agent' => 'Octokit Ruby Gem 4.14.0'})
      .to_return(status: 200, body: body, headers: {})
  end
end
