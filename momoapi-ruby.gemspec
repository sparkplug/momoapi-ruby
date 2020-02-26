# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'momoapi-ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'momoapi-ruby'
  spec.version       = Momoapi::VERSION
  spec.authors       = ['Lydia Sanyu Naggayi']
  spec.email         = ['lydiansanyu@gmail.com']

  spec.summary       = 'MTN MoMo API gem'
  # spec.description   = %q{TODO: Write a longer description}
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  # spec.license       = "MIT"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = ""
  # spec.metadata["changelog_uri"] = ""

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the
  # RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0")
                     .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = 'momoapi-ruby'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'faraday'
  spec.add_development_dependency 'pry', '~> 0.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr', '~> 5.1'
  spec.add_development_dependency 'webmock', '~> 2.1'
end
