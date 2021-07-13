# frozen_string_literal: true

server '54.95.167.123', user: 'ec2-user', roles: %w[app web]
set :deploy_to, '/var/www/html/error_note_sample'
set :ssh_options, {
  keys: %w[/Users/kazuto/.ssh/ErrorNote/ErrorNoteKeyPair.pem],
  forward_agent: true,
  port: 22
}
