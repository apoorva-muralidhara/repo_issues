class ReposController < ApplicationController
  def index
    if personal_access_token = session[:personal_access_token]
      client = Octokit::Client.new(access_token: personal_access_token)
      @repo_names = client.repositories.pluck(:name)
    else
      flash.alert = 'You are not logged in!'
      @repo_names = []
    end
  end
end
