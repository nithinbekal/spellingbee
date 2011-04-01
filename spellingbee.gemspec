# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spellingbee/version"

Gem::Specification.new do |s|
  s.name        = "spellingbee"
  s.version     = SpellingBee::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nithin Bekal"]
  s.email       = ["nithinbekal@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/spellingbee"
  s.summary     = %q{A spelling correction tool for ruby.}
  s.description = %q{Suggests corrections for mis-spelled words.}

  s.rubyforge_project = "spellingbee"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
