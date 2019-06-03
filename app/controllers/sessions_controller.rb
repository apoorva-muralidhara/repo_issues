class SessionsController < ApplicationController
  def new
  end

  def create
    client = Octokit::Client.new(access_token: personal_access_token)

    begin
      client.repositories
      session[:personal_access_token] = personal_access_token
    rescue Octokit::Error => error
      flash.alert = 'That personal access token is invalid!'
      render :new 
    end
  end

  private

  def personal_access_token
    params[:personal_access_token]
  end
end
