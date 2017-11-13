task :build_frontend do
  sh 'npm install --global yarn'
  sh 'yarn install && yarn run build'
end

Rake::Task["assets:precompile"].enhance(%i(build_frontend))
