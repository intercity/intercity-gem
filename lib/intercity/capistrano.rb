Capistrano::Configuration.instance(:must_exist).load do

  after "deploy:finalize_update", "db:symlink"
  after "deploy:finalize_update", "unicorn:symlink"

  namespace :db do
    task :symlink do
      run "rm -f #{release_path}/config/database.yml && ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  end

  namespace :unicorn do
    task :symlink do
      run "ln -nfs #{shared_path}/sockets #{release_path}/tmp/sockets"
    end
  end

end
