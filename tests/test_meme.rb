require 'minitest/autorun'
require 'minitest/benchmark' if ENV["BENCH"]
require './meme'

describe Meme do
  before do
    @meme = Meme.new
  end

  describe "when asked about cheeseburgers" do
    it "must respond positively" do
      @meme.i_can_has_cheezburger?.must_equal "OHAI!"
    end
  end

  describe "when asked about blending possibilities" do
    it "won't say no" do
      @meme.will_it_blend?.wont_match /^no/i
    end
  end
  
  describe Meme do
    if ENV["BENCH"] then
      bench_performance_linear "my_algorithm", 0.9999 do |n|
        100.times do
          @obj.my_algorithm(n)
        end
      end
    end
  end
end