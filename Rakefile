require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :specs do |task|
  task.pattern = Dir['spec/**/*_spec.rb']
end

desc "start trasina server"
task :server do |args|
  system %(puma -C config/puma.rb)
end
task :s => :server

desc "start trasina console"
task :console do |args|
  system %(./bin/console)
end
task :c => :console

task :default => ['specs']
