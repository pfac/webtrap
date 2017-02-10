# frozen_string_literal: true

namespace :lint do
  require "rubocop/rake_task"
  RuboCop::RakeTask.new(:ruby)
end
task lint: %i(lint:ruby)

namespace :test do
  require "cucumber/rake/task"
  Cucumber::Rake::Task.new(:acceptance)
end
task test: %i(test:acceptance)

task default: %i(lint test)
