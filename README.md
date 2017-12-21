WebTrap
=======

[![Gem Version](https://badge.fury.io/rb/webtrap.svg)](https://badge.fury.io/rb/webtrap)
[![Build Status](https://travis-ci.org/pfac/webtrap.svg?branch=master)](https://travis-ci.org/pfac/webtrap)
[![Dependency Status](https://gemnasium.com/badges/github.com/pfac/webtrap.svg)](https://gemnasium.com/github.com/pfac/webtrap)
[![Code Climate](https://codeclimate.com/github/pfac/webtrap/badges/gpa.svg)](https://codeclimate.com/github/pfac/webtrap)

Documentation:
[![Usage Documentation](https://img.shields.io/badge/usage-0.1.1-brightgreen.svg?style=flat)](http://www.relishapp.com/pfac/webtrap/docs)
[![API Documentation](https://img.shields.io/badge/api-0.1.1-brightgreen.svg?style=flat)](http://www.rubydoc.info/gems/webtrap)
[![Documentation Coverage](https://inch-ci.org/github/pfac/webtrap.svg?branch=master)](https://inch-ci.org/github/pfac/webtrap)

WebTrap allows you to write tests that assert on outgoing requests. This allows
you to verify that such requests match the documentation of external services
without actually having to hit them.

## Install

To install this library, just run the following command on your shell:

```sh
#!/bin/sh
gem install webtrap
```

Or, if you're using [Bundler][bundler], add the following to your project's
`Gemfile`:

```ruby
# Gemfile
gem "webtrap", group: :test
```


## Usage

WebTrap consists on a set of matchers that given a block where an HTTP request
is sent provide the ability to assert over on the outgoing request.


### Configuration

In order to use WebTrap matchers, make sure you require the correct file into
your configuration:


#### RSpec

```ruby
require "webtrap/rspec"
```

Include this line in the specs where you wish to use these matchers. If you
prefer to make WebTrap matchers available to all specs add this line to
`specs/spec_helper.rb`, or, if you are using `rspec-rails`, add it to
`specs/support/webtrap.rb`.


### Examples

* Verify that a request is sent anywhere:
  ```ruby
  expect do
    # ...
  end.to send_request
  ```

* Verify that a request is send with a specific XML body (or [equivalent][equivalent-xml]):
  ```ruby
  expect do
    # ...
  end.to send_request.with_xml(xml)
  ```


## Contributing

If you find a problem, have an idea or a suggestion, but don't know how to
implement it, or if you simply have a question regarding this project,
[please create an issue on GitHub][github-issue]. Your issue will be reviewed by
one of the main contributors and taken into consideration in the development of
the project.

On the other hand, if you are able to take action on the issue
[please submit a pull request][github-pull-request] instead. Development will go
a lot faster with contributions from the community, be it in code, documentation
or any other form.

Any contribution is more than welcome.

### Setup

Start by cloning the project into your system and running the bootstrapping
script included to set up your development environment:

```sh
#!/bin/sh
git clone https://github.com/pfac/webtrap.git
cd webtrap
./bin/setup
```

Here's what the script does:

1. Checks the existence of a compatible Ruby environment (MRI 2.0+);
2. Checks the presence of [Bundler][bundler], and installs it if missing;
3. Installs all dependencies.

Feel free to check the script before running it. To check if everything is
correctly set up run:

```sh
#!/bin/sh
bundle exec rake
```

That will run the linters and acceptance tests. If the tests fail please check
the [build status][travis-ci] for the branch you checked out. Unless the build
status is already failing, please investigate the issue on your environment. If
you found a defect in the bootstraping script, please file an issue to let us
know (be as detailed as possible).


### Development

In this project we use BDD with Cucumber. Ideally you should start with a
successful build, which you can check by running:

```sh
#!/bin/sh
bundle exec rake
```

It may happen that the branch where you started (usually `master`) is already
broken on [the CI][travis-ci]. If that is the case try to focus only on the scenarios you
are working on, by running instead:

```sh
#!/bin/sh
cucumber features/<path-to-file>
```

Start by describing your idea in either a new scenario or a whole new feature
file. If you are not sure which one to go for, create a new feature file and
someone will point you in the right direction during code revision. Make sure
your scenario fails before proceeding.

After that, implement the necessary code required to make your scenario pass. If
you find yourself in trouble feel free to [create an issue][github-issue]
pointing to your changes and someone will try to help you.

Once your scenario passes, refactor as required. Make sure your code gets
properly checked by the linters. When you feel your changes are ready,
[submit a pull request][github-pull-request]. We'll review it in the nicest way
possible. :smile:

For a short-list to follow before submitting your pull request, see
[CONTRIBUTING](./CONTRIBUTING.md).


### Deployment

Any main contributor can deploy a new version. To do so, update the version
number as appropriate according to [Semantic Versioning][semver] and run the
deployment script:

```sh
#!/bin/sh
./bin/deploy
```

On the other hand, if you are not a main contributor with deployment
permissions your idea will have to wait for a new version release to become
available in [RubyGems][rubygems] once it gets accepted.

At the moment there is no need for a release schedule, so new versions will be
released at the discretion of the main contributors team. Should you require
a pending feature to be released, feel free to mention it in your pull request
once it gets merged, or to open a new issue. We'll try to honor such requests
as much as possible when reasonable.


## About

WebTrap was originally designed by and is currently maintained by
[Pedro Costa][pfac]. All artifacts in this project are released under the
[MIT license](./LICENSE.txt).


[bundler]: http://bundler.io/
[equivalent-xml]: https://github.com/mbklein/equivalent-xml
[github-issue]: https://github.com/pfac/webtrap/issues/new
[github-pull-request]: https://github.com/pfac/webtrap/pull/new
[pfac]: https://github.com/pfac
[rubygems]: https://rubygems.org/gems/webtrap
[semver]: http://semver.org/
[travis-ci]: https://travis-ci.org/pfac/webtrap
