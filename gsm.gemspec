$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'gsm'
  s.version     = '0.0.1'
  s.authors     = ["Iulian Dogariu"]
  s.description = 'Utility belt for SMS and the GSM protocol stack'
  s.summary     = "gsm-#{s.version}"
  s.email       = 'code@iuliandogariu.com'
  s.homepage    = "http://github.com/iulianu/gsm"

  s.platform    = Gem::Platform::RUBY

  s.add_dependency 'ruby-hmac', '~> 0.4.0'
  s.add_dependency 'wbxml', '~> 0.0.1'
 
  s.add_development_dependency 'rake', '~> 0.8.7'
  s.add_development_dependency 'rspec', '>= 2.0.0'

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- spec/*`.split("\n")
  s.require_path     = "lib"
end
