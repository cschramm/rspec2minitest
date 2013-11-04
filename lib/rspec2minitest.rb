require 'rspec2minitest/test_name'

module RSpec2MiniTest
  module_function

  def add_matcher(matcher_name, matcher_module: nil, assertion_prefix: nil)
    positive_name = RSpec2MiniTest::PositiveTestName.new(
        matcher_name, matcher_module: matcher_module, assertion_prefix: assertion_prefix
    )
    negative_name = RSpec2MiniTest::NegativeTestName.new(
        matcher_name, matcher_module: matcher_module, assertion_prefix: assertion_prefix
    )
    [positive_name, negative_name].each do |test_name|
      define_expectation test_name
    end
  end

  def define_expectation(test_name)
    define_assertion test_name
    infect_assertion test_name
  end

  def define_assertion(test_name)
    method_name = test_name.assertion_name
    MiniTest::Assertions.send(:define_method, method_name) do |page, *args|
      matcher = test_name.matcher(*args)

      matches = matcher.send test_name.match_method, page
      failure_message = message { matcher.send test_name.failure_message_method }

      assert matches, failure_message
    end
  end

  def infect_assertion(test_name)
    MiniTest::Expectations.infect_an_assertion test_name.assertion_name, test_name.expectation_name, true
  end
end
