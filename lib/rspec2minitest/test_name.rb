module RSpec2MiniTest
  class TestName
    def initialize(matcher_name, matcher_module: nil, assertion_prefix: nil)
      extend matcher_module if matcher_module

      @matcher_name = matcher_name.to_s
      @assertion_prefix = assertion_prefix
    end

    def matcher(*args)
      send @matcher_name, *args
    end

    private

    def has
      @matcher_name.sub /^have/, 'has'
    end
  end

  class PositiveTestName < TestName
    def assertion_name
      "assert_#{@assertion_prefix && "#{@assertion_prefix}_" || ''}#{has}"
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
      "refute_#{@assertion_prefix && "#{@assertion_prefix}_" || ''}#{has}"
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
