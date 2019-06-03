class IssuesController < ApplicationController
  def index
    repo_name = params[:repo_id]
    @issues = Octokit.list_issues(repo_name)
  end
end
