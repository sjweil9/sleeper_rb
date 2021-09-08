# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

require "rdoc/task"

RDoc::Task.new(
  rdoc: "rdoc",
  clobber_rdoc: "rdoc:clean",
  rerdoc: "rdoc:force"
)

task default: %i[spec rubocop rdoc]
