require './helper_methods.rb'
require "test/unit"

class TestHelperMethods < Test::Unit::TestCase

  def test_length
    s = "Hello, World!"
    assert_equal(13, s.length)
  end

  def test_add_8192
    assert_equal(8191, add8192(-1) )
  end

  def test_subtr_8192
    assert_equal(1, subtr8192(8193) )
  end

  def test_encode
    assert_equal('4000', encode(0) )
    assert_equal('0000', encode(-8192) )
    assert_equal('7f7f', encode(8191) )
    assert_equal('5000', encode(2048) )
    assert_equal('2000', encode(-4096) )
    assert_equal('0a05', encode(-6907) )
    assert_equal('5500', encode(2688) )
  end

  def test_decode
    assert_equal('0000', decode('4000') )
    assert_equal('-8192', decode('0000') )
    assert_equal('8191', decode('7f7f') )
    assert_equal('2048', decode('5000') )
    assert_equal('-4096', decode('2000') )
    assert_equal('-6907', decode('0A05') )
    assert_equal('2688', decode('5500') )
  end
end
