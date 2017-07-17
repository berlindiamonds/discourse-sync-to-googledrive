# -*- encoding: utf-8 -*-
# stub: hurley 0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "hurley".freeze
  s.version = "0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Rick Olson".freeze, "Wynn Netherland".freeze, "Ben Maraney".freeze, "Kevin Kirsche".freeze]
  s.date = "2015-09-05"
  s.description = "Hurley provides a common interface for working with different HTTP adapters.".freeze
  s.email = ["technoweenie@gmail.com".freeze, "kev.kirsche@gmail.com".freeze]
  s.homepage = "https://github.com/lostisland/hurley".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "HTTP client wrapper".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
  end
end
