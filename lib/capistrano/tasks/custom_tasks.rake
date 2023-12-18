namespace :app do
  desc 'Instala dependências yarn'
  task 'yarn:install' do
    on roles(:all) do
      within release_path do
        execute(:yarn, :install, '--frozen-lockfile')
      end
    end
  end
end

before 'deploy:updated', 'app:yarn:install'
