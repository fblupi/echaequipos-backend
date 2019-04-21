server '192.168.1.21', user: 'pi', roles: %w[app db]

set :deploy_to, '/home/pi'
set :rails_env, 'production'
set :branch, ENV['BRANCH'] || 'develop'
set :passenger_restart_command, 'sudo /usr/bin/passenger-config restart-app'
