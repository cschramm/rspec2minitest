# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rspec2minitest/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'rspec2minitest'
  s.version = RSpec2MiniTest::Version.to_s
  s.platform = Gem::Platform::RUBY
  s.author = 'Christopher Schramm'
  s.email = 'rspec2minitest@cschramm.eu'
  s.homepage = 'https://github.com/cschramm/rspec2minitest'
  s.description = %q{
    Provides a generic factory to automatically convert RSpec matchers
    into assertions and expections for MiniTest::Unit and MiniTest::Spec
}
  s.summary = %q{
    Provides a generic factory to automatically convert RSpec matchers
    into assertions and expections for MiniTest::Unit and MiniTest::Spec.
    It is a generalization of Jared Ning's capybara_minitest_spec.
}
  s.licenses = %w(MIT)
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = %w(lib)
  s.extra_rdoc_files = %w(README.md)

  s.required_ruby_version = '>= 2.0.0'

  s.add_development_dependency 'rake'

  s.add_runtime_dependency 'minitest', '>= 2.0.0'
end
