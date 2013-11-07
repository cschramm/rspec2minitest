require 'rspec2minitest'
require 'paperclip/matchers'

RSpec2MiniTest.add_matchers Paperclip::Shoulda::Matchers, assertion_prefix: 'model'
