# config valid for current version and patch releases of Capistrano
lock '~> 3.18.0'

set :application, 'municipes_crud'
set :repo_url, 'git@github.com:ppires/municipes-crud.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, :main

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/ubuntu/#{fetch(:application)}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor', 'storage'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :rvm_ruby_version, 'ruby-3.2.2'

set :nvm_type, :user
set :nvm_node, 'v18.18.2'
set :nvm_map_bins, %w[node npm yarn rake]

set :migration_command, 'db:prepare'

set :puma_enable_socket_service, true
