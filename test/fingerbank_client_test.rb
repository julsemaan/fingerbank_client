require 'test_helper'

class FingerbankClientTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, FingerbankClient
  end

  test 'download valid database' do
    client = FingerbankClient.new
    assert client.update
    assert File.exist? 'fingerbank.sqlite'
    assert (File.stat("fingerbank.sqlite").size > 0)
  end

  test 'lookup device in local' do
    client = FingerbankClient.new
    device = client.lookup(:user_agent => "A/4.4.4/samsung/SAMSUNG-SGH-I337/MSM8960/AT&T")
    assert device
    assert_equal device.name, "Galaxy S4"
    assert device.has_parent? "Generic Android"
  end

  test 'lookup device in upstream' do
    client = FingerbankClient.new
    device = client.lookup(:user_agent => "iphone")
    assert device
    assert_equal device.name, "Apple iPhone"
    assert device.has_parent?("Apple iPod, iPhone or iPad")
  end
end
