class SessionsController < ApplicationController
  def new
  end

  def create
    client = Octokit::Client.new(access_token: params[:personal_access_token])

    begin
      client.repositories
      render :create
    rescue Octokit::Error => error
      flash.alert = 'That personal access token is invalid!'
      render :new 
    end
  end
end
