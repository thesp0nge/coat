require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new

task :default => :spec
task :test => :spec

namespace :parser do
  desc "Generate parser"
  task :generate do
    system "bundle exec racc -o lib/coat/parser.rb lib/coat/grammar.y"
  end

end
