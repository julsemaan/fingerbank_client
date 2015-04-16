require 'test_helper'

class FingerbankClientTest < ActiveSupport::TestCase
  test 'has_parent?' do
    client = FingerbankClient.new
    device = client.lookup("MobileSafari/600.1.4 CFNetwork/711.3.18 Darwin/14.0.0")
    assert device.has_parent?("Smartphones/PDAs/Tablets")
    assert !device.has_parent?("Linux")
  end

  test 'is?' do
    client = FingerbankClient.new
    device = client.lookup("MobileSafari/600.1.4 CFNetwork/711.3.18 Darwin/14.0.0")
    assert device.is?("Apple iPod, iPhone or iPad")
    assert device.is?("Smartphones/PDAs/Tablets")
    assert !device.is?("Linux")
  end

  test 'detect android' do
    client = FingerbankClient.new
    assert client.lookup("Mozilla/5.0 (Linux; U; Android 4.1.2; ko-kr; SHV-E160K/KKJNE4 Build/JZO54K) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30").android?
  end

  test 'detect ios' do
    client = FingerbankClient.new
    assert client.lookup("MobileSafari/600.1.4 CFNetwork/711.3.18 Darwin/14.0.0").ios?
  end

  test 'detect windows' do
    client = FingerbankClient.new
    assert client.lookup("Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.91 Safari/537.36").windows?
  end

  test 'detect mac' do
    client = FingerbankClient.new
    assert client.lookup("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.5; rv:13.0) Gecko/20100101 Firefox/13.0").mac?
  end

  test 'detect windows phone' do
    client = FingerbankClient.new
    assert client.lookup("Mozilla/5.0 (compatible; MSIE 9.0; Windows Phone OS 7.5; Trident/5.0; IEMobile/9.0; NOKIA; Lumia 710)").windows_phone?
  end

  test 'detect blackberry' do
    client = FingerbankClient.new
    assert client.lookup("Mozilla/5.0 (BB10; Kbd) AppleWebKit/537.10+ (KHTML, like Gecko) Version/10.1.0.1720 Mobile Safari/537.10+").blackberry?
  end
end
