task :build_frontend do
  cd 'frontend' do
    sh 'npm install && npm run build'
  end
end

Rake::Task["assets:precompile"].enhance(%i(build_frontend))
