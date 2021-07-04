lock "~> 3.16.0"

set :application, "error_note_sample"
set :repo_url, "git@github.com:k-kudo-hub/error_note_sample.git"
set :branch, ENV['BRANCH'] || "master"

set :linked_dirs, fetch(:linked_dirs, []).push('node_modules', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public')
set :linked_files, fetch(:linked_files, []).push('config/master.key', '.env')

set :rbenv_type, :user
set :rbenv_ruby, '2.7.2'

set :keep_releases, 5

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
