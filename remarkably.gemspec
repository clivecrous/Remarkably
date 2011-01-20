# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "remarkably/version"

Gem::Specification.new do |s|
  s.name        = "Remarkably"
  s.version     = Remarkably::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Clive Crous"]
  s.email       = ["clive@crous.co.za"]
  s.homepage    = "http://www.darkarts.co.za/remarkably"
  s.summary     = %q{A very tiny Markaby-like XML,HTML and CSS builder}
  s.description = %q{Remarkably is a very tiny Markaby-like XML,HTML and CSS builder}

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rake", ">= 0.8.7"
  s.add_development_dependency "rspec", ">= 1.3.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
