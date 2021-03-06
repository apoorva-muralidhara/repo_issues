class IssuesController < ApplicationController
  def index
    repo_name = params[:repo_id]
    @issues = Octokit.list_issues(repo_name, options)
    sort_by_title
  end

  private

  def sort_by_title
    @issues = @issues.sort_by { |issue| issue[:title] } if params[:sortBy] == 'title'
  end

  def options
    return { sort: :updated, direction: :desc } if params[:sortBy] == 'updated_at'
    { }
  end
end
