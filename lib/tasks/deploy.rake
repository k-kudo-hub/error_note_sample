# frozen_string_literal: true

task deploy: :environment do
  puts 'Want to deploy a default branch?( y / Branch name )'
  input = $stdin.gets.chomp
  if input == 'y'
    sh %(bundle exec cap production deploy --trace --dry-run)
  else
    sh "BRANCH=#{input} bundle exec cap production deploy --trace --dry-run"
  end
end
