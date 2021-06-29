lock "~> 3.16.0"

set :application, "error_note_sample"
set :repo_url, "git@github.com:k-kudo-hub/error_note_sample.git"

append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

set :rbenv_type, :user
set :rbenv_ruby, '3.0.0'

set :keep_releases, 5

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
