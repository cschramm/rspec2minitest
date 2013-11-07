require 'rspec2minitest/test_name'

module RSpec2MiniTest
  module_function

  def add_matcher(matcher_name, matcher_module: nil, assertion_prefix: nil)
    test_names = [
        RSpec2MiniTest::PositiveTestName,
        RSpec2MiniTest::NegativeTestName
    ]

    test_names.each do |test_name|
      define_expectation(
          test_name.new(matcher_name, matcher_module, assertion_prefix)
      )
    end
  end

  module_function

  def add_matchers(matcher_module, assertion_prefix: nil)
    matcher_module.public_instance_methods.each do |matcher_name|
      add_matcher matcher_name,
                  matcher_module: matcher_module,
                  assertion_prefix: assertion_prefix
    end
  end

  def define_expectation(test_name)
    define_assertion test_name
    infect_assertion test_name
  end

  def define_assertion(test_name)
    method_name = test_name.assertion_name
    MiniTest::Assertions.send(:define_method, method_name) do |object, *args|
      matcher = test_name.matcher(*args)

      matches = matcher.send test_name.match_method, object
      failure_message = message { matcher.send test_name.failure_message_method }

      assert matches, failure_message
    end
  end

  def infect_assertion(test_name)
    MiniTest::Expectations.infect_an_assertion test_name.assertion_name, test_name.expectation_name, true
  end
end
