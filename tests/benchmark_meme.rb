require 'minitest/benchmark' if ENV["BENCH"]
require './meme'

class BenchmarkMeme < MiniTest::Unit::TestCase
  # Override self.bench_range or default range is [1, 10, 100, 1_000, 10_000]
  def bench_my_algorithm
    assert_performance_linear 0.9999 do |n| # n is a range value
      @obj.my_algorithm(n)
    end
  end
end