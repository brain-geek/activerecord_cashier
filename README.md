# ActiverecordCashier

[![Build Status](https://secure.travis-ci.org/brain-geek/activerecord_cashier.png?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/brain-geek/activerecord_cashier.png)](https://codeclimate.com/github/brain-geek/activerecord_cashier)
[![Test Coverage](https://codeclimate.com/github/brain-geek/activerecord_cashier/badges/coverage.svg)](https://codeclimate.com/github/brain-geek/activerecord_cashier)

[gem]: https://rubygems.org/gems/activerecord_cashier
[travis]: http://travis-ci.org/brain-geek/activerecord_cashier

Automaticaly expires your cache entries triggered by ActiveRecord events.

## Installation

Add this line to your application's Gemfile:

    gem 'activerecord_cashier'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord_cashier

## Usage

After installation, you can specify strings, AR objects and classes as keys to trigger cache entry expiry.

    cache 'newstand', :tag => [Article]

And then when you trigger save/create/destroy on any article, the cache expires.

You can also specify records as tags:

    cache 'newstand', :tag => [@article]

After any action on this article this cache entry then expire.

You can also trigger expiry on all article caches:

    Article.expire_all_cache

You can see more examples in [spec](https://github.com/brain-geek/activerecord_cashier/blob/master/spec/lib/activerecord_cashier/active_record_extension_spec.rb).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
