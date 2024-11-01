# frozen_string_literal: true

require 'minitest/autorun'

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new
  end

  def teardown; end

  def test_add_element
    assert_equal(@stack.push!('ruby'), ['ruby'])
  end

  def test_remove_element
    assert_equal(@stack.pop!.to_a, [])
  end

  def test_clear_work
    assert_equal(@stack.clear!, [])
  end

  def test_stack_is_empty
    assert_empty(@stack, [])
  end

  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
