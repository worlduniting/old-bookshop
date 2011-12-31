require 'minitest/autorun'

class TestBuild < MiniTest::Unit::TestCase
  def setup
    @build = Build.new
    @mock = Minitest::Mock.new

    # mock expects:
    #            method      return  arguments
    #-------------------------------------------------------------
    mock.expect(:load_book_yaml,  nil, 'config/book.yml')
    mock.expect(:select,        nil, ['INBOX'])
    mock.expect(:search,        ids, [["BEFORE #{formatted_date}"]])
    mock.expect(:store,         nil, [ids, "+FLAGS", [:Deleted]])   
  end
  def test_load_book_yaml
    @mock.load_book_yaml('config/book.yml')
    assert_match /Bookshop (PDF Version)/, @book.pdf.title
  end
end






date = Date.new(2010,1,1)
formatted_date = '01-Jan-2010'
ids = [4,5,6]

mock = MiniTest::Mock.new

# mock expects:
#            method      return  arguments
#-------------------------------------------------------------
mock.expect(:load_book_yaml,  nil, ['config/book.yml'])
mock.expect(:select,        nil, ['INBOX'])
mock.expect(:search,        ids, [["BEFORE #{formatted_date}"]])
mock.expect(:store,         nil, [ids, "+FLAGS", [:Deleted]])


mp = MailPurge.new(mock)
mp.purge(date)

assert mock.verify