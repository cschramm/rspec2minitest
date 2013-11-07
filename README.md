[![Gem Version](https://badge.fury.io/rb/rspec2minitest.png)](http://badge.fury.io/rb/rspec2minitest)
[![Dependency Status](https://gemnasium.com/cschramm/rspec2minitest.png)](https://gemnasium.com/cschramm/rspec2minitest)
[![Code Climate](https://codeclimate.com/github/cschramm/rspec2minitest.png)](https://codeclimate.com/github/cschramm/rspec2minitest)

# RSpec2MiniTest

Provides a generic factory to automatically convert the RSpec matchers of your favorite
gems into assertions and expectations for MiniTest::Unit and MiniTest::Spec.
It is a generalization of [Jared Ning's capybara_minitest_spec](https://github.com/ordinaryzelig/capybara_minitest_spec).

## Installation

    # Gemfile
    gem 'rspec2minitest'

## Integrations

### Capybara

To create assertions / expectations from all Capybara RSpec matchers add to your `test_helper`:

    require 'rspec2minitest'
    require 'capybara/rspec/matchers'

    RSpec2MiniTest.add_matchers Capybara::RSpecMatchers, assertion_prefix: 'page'

For the `have_text` matcher you can then use:

    # Unit
    assert_page_has_text(page, text)
    refute_page_has_text(page, text)

    # Spec
    it { must_have_text(text) }
    it { wont_have_text(text) }

For all matchers see [Capybara/RSpecMatchers](http://rubydoc.info/gems/capybara/Capybara/RSpecMatchers)

This is exactly what the `capybara_minitest_spec` gem does. If Capybara
matchers are the only ones you need to convert, I recommend using that gem.

### Paperclip

    # test_helper
    require 'rspec2minitest'
    require 'paperclip/matchers'

    RSpec2MiniTest.add_matchers Paperclip::Shoulda::Matchers, assertion_prefix: 'model'

For all matchers see [Paperclip::Shoulda::Matchers](http://rubydoc.info/gems/paperclip/Paperclip/Shoulda/Matchers)

### Custom integrations

You can use the API of rspec2minitest to easily create your own integrations
within your test_helper. `require 'rspec2minitest'` provides you with an
RSpec2MiniTest module that provides an `add_matcher` function to convert
single matchers and an `add_matchers` function to convert all public instance
methods of a given module.