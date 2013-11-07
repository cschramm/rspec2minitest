require 'rspec2minitest'
require 'capybara/rspec/matchers'

RSpec2MiniTest.add_matchers Capybara::RSpecMatchers, assertion_prefix: 'page'