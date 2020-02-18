# MTN MoMo API Ruby Gem

[![Build Status](https://travis-ci.com/sparkplug/momoapi-ruby.svg?branch=master)](https://travis-ci.com/sparkplug/momoapi-ruby)


## Usage

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'momoapi-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install momoapi-ruby


## Creating a sandbox environment API user
Type this command into your terminal:

```
momoapi --host Your-Provider-Callback-Host --key Your-Ocp-Apim-Subscription-Key
```

A User ID and API Key will be generated:

```
User ID: Generated user ID
API key: Generated API key
```

## Using live credentials

Add the following configurations in an initializer file (for example, `config/initializers/momoapi-ruby.rb` in a Rails app):

```
Momoapi.configure do |config|
  config.base_url = 'Your MoMo account base URL'
  config.callback_host = 'Your Provider Callback Host'
  config.collection_primary_key = 'Your Collection Subscription Key'
  config.collection_user_id = 'Your Collection User ID'
  config.collection_api_secret = 'Your Collection API Key'
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sparkplug/momoapi-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Momoapi::Ruby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sparkplug/momoapi-ruby/blob/master/CODE_OF_CONDUCT.md).
