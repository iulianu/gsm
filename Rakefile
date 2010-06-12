# vim:ts=2:sw=2:et:

require 'rubygems'
require 'rake/gempackagetask'
gem 'rspec', '>= 1.3.0'
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new do |t|
  t.libs << 'lib'
  t.spec_opts = ["--color" ]
end

PKG_VERSION='0.0.1'

spec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.summary = "GSM library"
  s.name = 'gsm'
  s.version = PKG_VERSION
  s.requirements << 'none'
  s.require_path = 'lib'
  s.autorequire = 'gsm.rb'
  s.files      = FileList["{bin,docs,lib,test}/**/*"].exclude("rdoc").to_a
  s.description = <<EOF
Description goes here
EOF
end

Rake::GemPackageTask.new(spec) do |pkg|
#  pkg.need_zip = true
#  pkg.need_tar = true
end
