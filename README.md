# Ostiary

An ostiarius, a Latin word sometimes anglicized as ostiary but often literally translated as porter or doorman, originally was a servant or guard posted at the entrance of a building. See also gatekeeper.

## Functionality

[![Build Status](https://travis-ci.com/nedap/ostiary.svg?token=4BotuBJP2R9yGGT125VA&branch=master)](https://travis-ci.com/nedap/ostiary)

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

In your base Controller class include `Ostiary::ControllerHelper`
then create a before_filter, ie. `ensure_authorized` and create its method:

```ruby
def ensure_authorized!
  self.class.ostiary.authorize!(scene.action) do |role|
    # Your authorization method using role.
  end
rescue Ostiary::PolicyBroken => e
  raise ActionController::RoutingError.new(e.message)
end
```

in each controller you wish to secure, you can call `ostiary_policy`, just like `before_filter` & `after_filter` of Rails.

```ruby
# Require the :list role on the entire controller
ostiary_policy :list

# Require the :view role only on the index & show actions
ostiary_policy :view, only: [:index, :show]

# Require the :edit role except on the index & show actions
ostiary_policy :edit, except: [:index, :show]
```
