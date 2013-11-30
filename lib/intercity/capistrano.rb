configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do

  _cset :user, "deploy"
  _cset :use_sudo, false
  _cset :shell, '/bin/bash --login'

  _cset :bluepill_bin, '/opt/chef/embedded/bin/bluepill'

  default_run_options[:pty] = true
  default_run_options[:shell] = '/bin/bash --login'
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
    desc "Start bluepill daemon"
    task :start do
      run "sudo #{bluepill_bin} load /etc/bluepill/#{application}.pill"
    end
    desc "Stop bluepill daemon"
    task :stop do
      run "sudo #{bluepill_bin} #{application} stop"
    end
    desc "Restart bluepill daemon"
    task :restart, :roles => :app, :except => { :no_release => true } do
      run "sudo #{bluepill_bin} #{application} restart"
    end
    desc "Show status of the bluepill daemon"
    task :status do
      run "sudo #{bluepill_bin} #{application} status"
    end
  end

end
