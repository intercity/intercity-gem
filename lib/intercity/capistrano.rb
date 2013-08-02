Capistrano::Configuration.instance(:must_exist).load do
  set :user, "deploy"
  set :use_sudo, false
  default_run_options[:pty] = true
  ssh_options[:forward_agent] = true

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

  namespace :deploy do
    desc "Starts the bluepill daemon for the application"
    task :start do
      run "sudo bluepill load /etc/bluepill/#{application}.pill"
    end
    desc "Stops the bluepill daemon for your application"
    task :stop do
      run "sudo bluepill #{application} stop"
    end
    desc "Restarts the bluepill daemon for the application"
    task :restart, :roles => :app, :except => { :no_release => true } do
      run "sudo bluepill #{application} restart"
    end
    desc "Checks the status of the bluepill daemon for the application"
    task :status do
      run "sudo bluepill #{application} status"
    end
    desc "Kills the bluepill daemon for the application"
    task :quit do
      run "sudo bluepill #{application} quit"
    end
  end
end
