# README

This is a Rails 5.2.3, Ruby 2.6.3 application.  I configured it for PostgreSQL (so you may need to do `rails db:create:all` to run it), but it doesn't use a database.

As discussed, I'm really a back end developer, so the app works but looks terrible.  I know ERB and HTML tags, but not CSS.

You can run the server with `rails server` or `rails s`, go to `localhost:3000/login` (I have not put anything on the root page), enter your GitHub personal access key (you should see a 'Login successful!' page), click on `Repos`, and see a list of the repos you have access to.

Clicking on a repo name will bring you to a page listing its issues, with assignee avatar if it exists; title; created time; and last updated.  Clicking on the `Title` header will sort in ascending alphabetical order by title; clicking on the `Last Updated` header will sort in descending chronological order by updated_at.

This app uses the Octokit gem to 