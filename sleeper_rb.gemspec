# frozen_string_literal: true

require_relative "lib/sleeper_rb/version"

Gem::Specification.new do |spec|
  spec.name          = "sleeper_rb"
  spec.version       = SleeperRb::VERSION
  spec.authors       = ["Stephen Weil"]
  spec.email         = ["stephen.weil@gmail.com"]

  spec.summary       = "A wrapper for interacting with the Sleeper Fantasy Football API."
  spec.description   = "Provides an object-oriented interface for the Sleeper Fantasy Football API."
  spec.homepage      = "https://github.com/sjweil9/sleeper_rb"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/sjweil9/sleeper_rb"
  spec.metadata["changelog_uri"] = "https://github.com/sjweil9/sleeper_rb/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
