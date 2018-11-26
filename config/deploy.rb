# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "alexandre_lairan"
set :repo_url, "https://github.com/alex-lairan/website.git"
set :deploy_to, -> { "/data/#{fetch(:application)}" }

set :ssh_options, {
  forward_agent: true,
  keys: [
    File.join(ENV['HOME'], '.ssh', 'id_rsa')
  ]
}

task :compile do
  on roles(:all) do
    execute "cd '#{release_path}'; shards install"
    execute "cd '#{release_path}'; crystal build --release src/lairan_website.cr"
  end
end

task :restart_server do
  on roles(:all) do
    execute "sudo /bin/systemctl restart alexandre-lairan.service;"
  end
end

after :deploy, :compile
after :compile, :restart_server

after 'deploy:rollback', :restart_server

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

set :keep_releases, 5
