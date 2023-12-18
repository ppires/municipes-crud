namespace :app do
  desc 'Instala dependências yarn'
  task 'yarn:install' do
    on roles(:all) do
      within release_path do
        execute(:yarn, :install, '--frozen-lockfile')
      end
    end
  end

  desc 'Faz o restart do servidor puma'
  task 'puma:restart' do
    on roles(:all) do
      within shared_path do
        execute('ls')
        puts shared_path
        execute("cd #{shared_path} && kill -9 $(cat tmp/pids/server.pid)", raise_on_non_zero_exit: false)
      end
      within current_path do
        execute('ls')
        puts current_path
        execute("cd #{current_path} && RAILS_ENV=production bin/rails server -e production -d")
      end
    end
  end
end

before 'deploy:updated', 'app:yarn:install'
after 'deploy:published', 'app:puma:restart'
