# usps

[![Gem Version](https://badge.fury.io/rb/usps.svg)](https://rubygems.org/gems/usps)
[![Run tests](https://github.com/gaffneyc/usps/actions/workflows/test.yml/badge.svg)](https://github.com/gaffneyc/usps/actions/workflows/test.yml)

Ruby API for accessing the USPS WebTools API found here: https://www.usps.com/business/webtools.htm

PDF Guides can be found here: https://www.usps.com/business/webtools-technical-guides.htm

Usage of this library assumes you already have a USPS API account and that all privileges have been granted.

## Exposed API Calls

The following USPS API calls are currently exposed through this library:

```
<AddressValidateRequest>             -- USPS::Request::AddressStandardization
<CityStateLookupRequest>             -- USPS::Request::CityAndStateLookup
<ZipCodeLookupRequest>               -- USPS::Request::ZipCodeLookup
<TrackRequest>                       -- USPS::Request::TrackingLookup
<TrackFieldRequest>                  -- USPS::Request::TrackingFieldLookup

<DeliveryConfirmationV3.0Request>    -- USPS::Request::DeliveryConfirmation        (for production)
<DeliveryConfirmCertifyV3.0Request>  -- USPS::Request::DeliveryConfirmationCertify (for testing)
```

## Usage

Using the library is as simple as building a new `USPS::Request::[type]` object, calling `#send!` and using the response.
For example, to send a tracking request you'd do the following:

```ruby
USPS.username = "XXXXXX" # your USPS API username, or set ENV['USPS_USER']
request = USPS::Request::TrackingLookup.new(tracking_number)
response = request.send!

response.summary
response.details
```

The library assumes that either `ENV['USPS_USER']` is set, or that you set `USPS.username` to your USPS API username.

See the individual USPS::Request classes for details on how to use them.

## USPS API Certification

Part of the process of setting up an account with the USPS API is to run certain tests against the USPS API.
This library has all the requisite tests built in, runnable with rake:

```bash
USPS_USER="[username]" bundle exec rake certify
```

or as an installed gem:

```bash
USPS_USER="[username]" bundle exec ruby -e "require 'usps/test'"
```

If any of the tests fail, you don't have access to that API and may need to work with USPS to fix it.

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Testing

```
bundle exec rspec
```

## Further Reading

- [USPS API docs](https://www.usps.com/business/web-tools-apis/welcome.htm)
- [18F's USPS API Notes](https://github.com/18F/usps-api-notes)

## Copyright

Copyright (c) 2014 Chris Gaffney. See LICENSE for details.
