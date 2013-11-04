# RSpec2MiniTest

Provides a generic factory to automatically convert the RSpec matchers of your favorite
gems into assertions and expectations for MiniTest::Unit and MiniTest::Spec.
It is a generalization of [Jared Ning's capybara_minitest_spec](https://github.com/ordinaryzelig/capybara_minitest_spec).

## Installation

In your `Gemfile`:

    gem 'rspec2minitest'

## Examples

### Capybara

To create assertions / expectations from all Capybara RSpec matchers add to your `test_helper`:

    require 'rspec2minitest'
    require 'capybara/rspec/matchers'
    Capybara::RSpecMatchers.public_instance_methods.each do |matcher_name|
        RSpec2MiniTest.add_matcher matcher_name,
                                   matcher_module: Capybara::RSpecMatchers,
                                   assertion_prefix: 'page'
    end

This is exactly what the `capybara_minitest_spec` gem does. If Capybara
matchers are the only ones you need to convert, I recommend using that gem.

### Paperclip

To create attachment assertions / expectations for your models add to your `test_helper`:

    require 'rspec2minitest'
    require 'paperclip/matchers'
    RSpec2MiniTest.add_matcher 'have_attached_file', matcher_module: Paperclip::Shoulda::Matchers