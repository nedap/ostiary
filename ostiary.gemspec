# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ostiary/version'

Gem::Specification.new do |spec|
  spec.name          = "ostiary"
  spec.version       = Ostiary::VERSION
  spec.author        = "Jacques Hakvoort"
  spec.authors       = ["Jacques Hakvoort"]
  spec.email         = ["jacques.hakvoort@nedap.com"]

  spec.homepage      = "https://www.pepme.net"
  spec.summary       = "Limit access to controllers/actions with policies"
  spec.description   = <<-TXT;
    from wikipedia: "An ostiarius, a Latin word sometimes anglicized as ostiary
    but often literally translated as porter or doorman, originally was a
    servant or guard posted at the entrance of a building. See also gatekeeper."
    Ostiary is a security gem for your controllers & actions.
    It employs a before_filter-like call to set policies per controller/action.
    You can pass your own security call in block and handle the PolicyBroken
    yourself.
    Policies are also inherited from parent classes.
  TXT
  spec.license = 'MIT'

  spec.metadata['allowed_push_host'] = "https://github.com/nedap'"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
