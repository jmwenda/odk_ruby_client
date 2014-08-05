Gem::Specification.new do |s|
  s.name               = "opendatakit"
  s.version            = "0.0.4"
  s.default_executable = "opendatakit"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jude Mwenda"]
  s.date = %q{2014-07-28}
  s.description = %q{A wrapper gem to help in making queries to OpenDataKit aggregate instance}
  s.email = %q{judemwenda@gmail.com}
  s.files = ["Rakefile", "lib/opendatakit.rb", "bin/ODKInstance"]
  s.homepage = %q{http://rubygems.org/gems/opendatakit}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Open Data Kit!}
  s.licenses    = ['MIT']

  s.add_dependency('httpclient', '~> 2.4')

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
