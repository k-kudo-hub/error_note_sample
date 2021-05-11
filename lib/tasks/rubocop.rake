# frozen_string_literal: true

task rubocop: :environment do
  sh %(rubocop --fail-level W --display-only-fail-level-offenses)

  puts "Want to run 'rubocop -A'? [Y/n]"
  input = $stdin.gets.chomp
  if input.empty? || input.match?(/[Yy]/)
    sh %(rubocop -A)
  end
end
