task :build_frontend do
  sh 'yarn install && yarn run build'
end

Rake::Task["assets:precompile"].enhance(%i(build_frontend))
