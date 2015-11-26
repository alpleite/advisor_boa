# config valid only for Capistrano 3.1
lock '3.4.0'

set :application, 'advisor'
set :repo_url, 'git@github.com:alpleite/advisor_boa.git'

set :deploy_to, "/home/advisor_boa/"
set :rvm_ruby_version, 'ruby-2.2.0'
set :rvm_custom_path, "/usr/local/rvm"

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp vendor/bundle public/system}

after :deploy, "deploy:migrate"

after :deploy, 'deploy:assets:precompile'

namespace :deploy do

  desc 'Copy config files'
  task :copy_files do
    run_locally do
      execute "scp ./config/database.yml #{roles(:app).first.user}@#{roles(:app).first.hostname}:#{shared_path}/config"
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :"chown -R www-data:www-data #{release_path}"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart


end