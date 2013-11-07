require 'verbs'

module RSpec2MiniTest
  class TestName
    def initialize(matcher_name, matcher_module, assertion_prefix)
      extend matcher_module if matcher_module

      @matcher_name = matcher_name.to_s
      @assertion_prefix = assertion_prefix && "#{assertion_prefix}_" || ''
    end

    def matcher(*args)
      send @matcher_name, *args
    end

    private

    def conjugated
      pieces = @matcher_name.split('_', 2)
      pieces[0] = pieces[0].verb.conjugate(person: :third)
      pieces.join('_')
    end
  end

  class PositiveTestName < TestName
    def assertion_name
      "assert_#{@assertion_prefix}_#{conjugated}"
    end

    def expectation_name
      "must_#{@matcher_name}"
    end

    def match_method
      :matches?
    end

    def failure_message_method
      :failure_message_for_should
    end
  end

  class NegativeTestName < TestName
    def assertion_name
      "refute_#{@assertion_prefix}#{conjugated}"
    end

    def expectation_name
      "wont_#{@matcher_name}"
    end

    def match_method
      :does_not_match?
    end

    def failure_message_method
      :failure_message_for_should_not
    end
  end
end
