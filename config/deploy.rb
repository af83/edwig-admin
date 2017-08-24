# config valid only for current version of Capistrano
lock "3.8.2"

set :application, "edwig-admin"
set :ruby_version, "2.3.0"

namespace :deploy do
  desc "Run db:seed"
  task :seed do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end
