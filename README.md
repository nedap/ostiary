# Ostiary

An ostiarius, a Latin word sometimes anglicized as ostiary but often literally translated as porter or doorman, originally was a servant or guard posted at the entrance of a building. See also gatekeeper.

## Functionality

[![CircleCI Status](https://circleci.com/gh/nedap/ostiary.svg?style=svg)](https://circleci.com/gh/nedap/ostiary)

This gem will help you enforce 'policies' when viewing controllers/actions.
This is done by requiring certain roles for controllers, where you can
optionally include or exclude certain actions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ostiary'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ostiary

## Usage

### Primary setup

In your base Controller class do the following for Rails:

```ruby
# This class creates a class accessor called :ostiary on each (inherited) controller.
#  With each controller created, it will stack the policies you add
include Ostiary::ControllerHelper

before_filter :ensure_authorized!

# Because each ostiary is unique for a controller, you only have to supply the current action.
#  With this, it can check if there are certain policies that will be broken.
def ensure_authorized!
  self.class.ostiary.authorize!(action) do |name|
    # Your authorization method using name.
    #  e.g. `current_user.has_right?(name)`
  end
rescue Ostiary::PolicyBroken => error
  # We re-raise the Error as a RoutingError in Rails
  #  You can also do `return head :forbidden` if that's more in line with your needs.
  raise ActionController::RoutingError.new(error.message)
end
```

### Securing controllers

In each controller you wish to secure, you can call `ostiary_policy`, just like `before_filter` & `after_filter` of Rails.

```ruby
# Require the :list role on the entire controller
ostiary_policy :list

# Require the :view role only on the index & show actions
ostiary_policy :view, only: [:index, :show]

# Require the :edit role except on the index & show actions
ostiary_policy :edit, except: [:index, :show]
```

These policies will be added to the ostiary instance created for each Controller Class. It will also include each policy inherited from parent classes.

### Checking for a right

You can also ask if a user is authorized to access to a certain path (url).

in your Controller:

```ruby
def authorized?(path)
  # recognize_path is a Rails Routing helper that will return a hash with the controller
  #  and action of the path you supplied. We'll have to transform that String of the
  #  controller into an actual Class.
  return false unless route = Rails.application.routes.recognize_path(path)
  requested_controller = "#{route[:controller]}_controller".camelize.constantize
  requested_controller.ostiary.authorized?(route[:action]) do |role|
    # Your authorization method using name.
  end
end
```

## Development

### Docker

Build the image:

    docker build -t ostiary

Run the image:

    docker run --mount 'type=bind,src=/home/jacques.hakvoort/Development/ostiary,dst=/app' -i -t ostiary sh

You can now run the tests using:

    rspec

Release a new gem version using:

    rake release

## License

ostiary is Copyright 2017 nedap and released under the MIT license which you should find included in the [LICENSE.txt](LICENSE.txt) file.
