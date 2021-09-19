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
) do |rdoc|
  rdoc.main = "Client.rb"
  rdoc.rdoc_dir = "docs/"
  rdoc.rdoc_files.include("lib/**/*.rb")
end

task default: %i[spec rubocop rdoc]
