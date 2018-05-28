# Beaker::Puppeter

This plugin integrates [Puppeter](https://github.com/coi-gov-pl/puppeter/) into [Beaker](https://github.com/puppetlabs/beaker) testing harness, by installing and running it with user provided answer files.

## Installation

Add this line to your module's Gemfile:

```ruby
gem 'beaker-puppeter', require: false
```

## Usage

To use beaker-puppeter add those lines to yours `spec/spec_helper_acceptance.rb` file:

```ruby
require 'beaker/puppeter'
run_puppeter
```

This configuration will look automatically for Puppeter answers in `spec/acceptance/answers/default.yml`, so place it there.

Answer file must be in format accepted by Puppeter. Consult [Puppeter documentation](https://github.com/coi-gov-pl/puppeter/blob/develop/README.rst) for more details.

Sample answer file can be as simple as:

```yaml
# will install puppet agent 5.x from Puppet Inc. managed deb repositories
installer:
  mode: Agent
  type: pc5x
```

### Changing Puppeter answer file

You can change answers file in tree ways:

1. Using environment variable `PUPPETER_ANSWERS`:
```bash
PUPPETER_ANSWERS=puppet4 RS_SET=centos7 bundle exec rake acceptance
```

2. Using directly in code:
```ruby
run_puppeter 'puppet4' # will run spec/acceptance/answers/puppet4.yml
```

3. Configuring `puppeter_answers` variable in nodeset:

```yaml
CONFIG:
  puppeter_answers: puppet4
```

The importance of those set methods are: environment variables, direct code, nodeset settings.

### Fine tuned usage

You can also utilize `run_puppeter_on` helper method to run Puppeter on specific hosts. It's useful when you would like to run different answer files on different hosts.

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `bundle exec rake spec` to run the unit tests. You can also run `bundle exec rake acceptance` to run Docker/Vagrant based acceptance tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/coi-gov-pl/beaker-puppeter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [Apache 2.0 License](https://opensource.org/licenses/Apache-2.0).

## Code of Conduct

Everyone interacting in the Beaker::Puppeter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/coi-gov-pl/beaker-puppeter/blob/master/CODE_OF_CONDUCT.md).
