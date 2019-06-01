require 'rails_helper'

describe "Spike" do
  let(:personal_access_token) { 'my_very_own_token' }

  specify do
    stub_request(:get, "https://api.github.com/user/repos").
         with(
           headers: {
       	  'Accept' => 'application/vnd.github.v3+json',
       	  'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Authorization' => "token #{personal_access_token}",
       	  'Content-Type'=>'application/json',
       	  'User-Agent'=>'Octokit Ruby Gem 4.14.0'
           }).
         to_return(status: 200,
                   body: [ { name: 'led'},
                           { name: 'zeppelin' } ],
                   headers: {})

    client = Octokit::Client.new(:access_token => personal_access_token)
    expect(client.repositories.pluck(:name))
      .to eq(%w(led zeppelin))
  end
end
