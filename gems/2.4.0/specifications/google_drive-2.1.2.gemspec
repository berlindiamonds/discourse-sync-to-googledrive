# -*- encoding: utf-8 -*-
# stub: google_drive 2.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "google_drive".freeze
  s.version = "2.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Hiroshi Ichikawa".freeze]
  s.date = "2016-12-10"
  s.description = "A library to read/write files/spreadsheets in Google Drive/Docs.".freeze
  s.email = ["gimite+github@gmail.com".freeze]
  s.homepage = "https://github.com/gimite/google-drive-ruby".freeze
  s.licenses = ["BSD-3-Clause".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "2.6.12".freeze
  s.summary = "A library to read/write files/spreadsheets in Google Drive/Docs.".freeze

  s.installed_by_version = "2.6.12" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>.freeze, ["< 2.0.0", ">= 1.5.3"])
      s.add_runtime_dependency(%q<google-api-client>.freeze, ["< 1.0.0", ">= 0.9.0"])
      s.add_runtime_dependency(%q<googleauth>.freeze, ["< 1.0.0", ">= 0.5.0"])
      s.add_development_dependency(%q<test-unit>.freeze, ["< 4.0.0", ">= 3.0.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0.8.0"])
      s.add_development_dependency(%q<rspec-mocks>.freeze, ["< 4.0.0", ">= 3.4.0"])
    else
      s.add_dependency(%q<nokogiri>.freeze, ["< 2.0.0", ">= 1.5.3"])
      s.add_dependency(%q<google-api-client>.freeze, ["< 1.0.0", ">= 0.9.0"])
      s.add_dependency(%q<googleauth>.freeze, ["< 1.0.0", ">= 0.5.0"])
      s.add_dependency(%q<test-unit>.freeze, ["< 4.0.0", ">= 3.0.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0.8.0"])
      s.add_dependency(%q<rspec-mocks>.freeze, ["< 4.0.0", ">= 3.4.0"])
    end
  else
    s.add_dependency(%q<nokogiri>.freeze, ["< 2.0.0", ">= 1.5.3"])
    s.add_dependency(%q<google-api-client>.freeze, ["< 1.0.0", ">= 0.9.0"])
    s.add_dependency(%q<googleauth>.freeze, ["< 1.0.0", ">= 0.5.0"])
    s.add_dependency(%q<test-unit>.freeze, ["< 4.0.0", ">= 3.0.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0.8.0"])
    s.add_dependency(%q<rspec-mocks>.freeze, ["< 4.0.0", ">= 3.4.0"])
  end
end
