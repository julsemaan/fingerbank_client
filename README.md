# Fingerbank client (fingerbank\_client)

[![Build Status](https://travis-ci.org/julsemaan/fingerbank_client.svg)](https://travis-ci.org/julsemaan/fingerbank_client)

## About

The Fingerbank client is a ruby client that can accuratly determine what kind of device is using your application based on the client user agent.
It uses the data collected by the Fingerbank project and it's public API to allow the discovery of more than 5000 devices including detailed information of most of the Android devices.

## Installation

First of all, register on https://fingerbank.inverse.ca/users/register and grab your key from your profile page. In this documentation the key will be '1234567890'

Next install the gem 

    gem install fingerbank_client

### Configuring your key in the application.

If you are using Ruby on Rails or don't want to configure your key directly in your application, add your key to your environement.

    export fingerbank_key=1234567890

You can also pass your key while instantiating the FingerbankClient

    fingerbank_client = FingerbankClient.new(:key => "1234567890")

NOTE: If you are using Ruby on Rails, you *ABSOLUTELY* have to configure it in a way that it's available in `ENV['fingerbank_key']`

### Detection with a local database

CAUTION: Heroku does not support the sqlite3 gem which the local database uses. There is unfortunatly no way to go around that so Heroku based app cannot use the local database.

In order to make the detection of the devices faster and prevent the cost of interrogating the Fingerbank public API, you can do a daily download of the Fingerbank database and the library will use it before calling the Fingerbank API. This will make your application faster. In the event that there's no hit in the local database, the library will still interrogate the Fingerbank API.

Also, the Fingerbank API offers a maximum of 300 requests per hour so using the local database is suggested in a mid-size to large size application.

To use it, first setup your key in the environment as explained above.

Then run the following command :

    rake fingerbank:update

We also suggest you install this in a crontab or other job manager so it updates the database nightly. The new Fingerbank database is released everyday at 2AM Eastern time.

## Usage

If you are using Ruby on Rails, then you will have access to the current device computed by Fingerbank by calling `current_device` in your controllers. 

For example : 

    def index
      current_device.name
    end

You also have access to the Fingerbank client, though `fingerbank_client`

If you are using the library outside of Ruby on Rails, then the following code will allow you to obtain the result of `current_device`.

    fingerbank_client = FingerbankClient.new(:key => "1234567890")
    current_device = fingerbank_client.lookup(:user_agent => "Some user agent")

Here are the most interesting methods for a device

    current_device.name      # friendly device name
    current_device.parents   # friendly names of the hierarchy of this device. From closest to furtest
    current_device.version   # The OS version of the device. Mostly applies to mobile devices
    current_device.android?
    current_device.ios?
    current_device.windows?
    current_device.mac?
    current_device.windows_phone?
    current_device.blackberry?
    # For the two following methods, you can browse the Fingerbank devices
    # on https://fingerbank.inverse.ca/devices
    current_device.has_parent?("Generic Android") # Check if the device has for parent Generic Android
    current_device.is?("Samsung Android") # Check if the device is or has for parent Samsung Android

## Performance

When used in Ruby on Rails, Fingerbank will automatically use the Rails cache so make sure it's setup properly. This will prevent duplicate requests to the Fingerbank public API.

TODO: Support for overriding the cache when using outside of Ruby on Rails

## LICENSE
This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
USA.

