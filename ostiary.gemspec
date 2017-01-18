# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ostiary/version'

Gem::Specification.new do |spec|
  spec.name          = "ostiary"
  spec.version       = Ostiary::VERSION
  spec.authors       = ["Jacques Hakvoort"]
  spec.email         = ["jacques.hakvoort@nedap.com"]

  spec.homepage      = "https://www.pepme.net"
  spec.summary       = "Ostiar will enforce security per controller/action"
  spec.description   = <<-TXT;
    from wikipedia: "The porter had in ancient times the duty of opening and closing the church-door and of guarding the church;"
    Ostiary is a security gem for your controllers & actions.
    It employs a :before_filter like call to set restrictions per controller/action.
    You can pass your own security call in block and handle the PolicyBroken yourself.
    Rules are inherited from parent classes.
  TXT

  spec.metadata['allowed_push_host'] = "https://github.com/nedap'"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
