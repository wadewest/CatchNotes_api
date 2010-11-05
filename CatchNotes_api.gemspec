# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{CatchNotes_api}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Wade West"]
  s.date = %q{2010-11-05}
  s.description = %q{An ActiveResource like interface to catch.com}
  s.email = %q{wwest81@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "CatchNotes_api.gemspec",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/catch_notes.rb",
     "lib/catch_notes/base.rb",
     "lib/catch_notes/errors.rb",
     "test/faker.rb",
     "test/helper.rb",
     "test/note_class.rb",
     "test/test_catch_notes.rb"
  ]
  s.homepage = %q{http://github.com/wadewest/CatchNotes_api}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{An ActiveResource like interface to catch.com}
  s.test_files = [
    "test/faker.rb",
     "test/helper.rb",
     "test/note_class.rb",
     "test/test_catch_notes.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.6.1"])
      s.add_runtime_dependency(%q<json>, [">= 1.4.6"])
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_development_dependency(%q<sinatra>, [">= 1.1.0"])
    else
      s.add_dependency(%q<httparty>, [">= 0.6.1"])
      s.add_dependency(%q<json>, [">= 1.4.6"])
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 1.1.0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.6.1"])
    s.add_dependency(%q<json>, [">= 1.4.6"])
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 1.1.0"])
  end
end

