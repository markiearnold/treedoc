$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "treedoc/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "treedoc"
  s.version     = Treedoc::VERSION
  s.authors     = ["Justin French"]
  s.email       = ["justin@indent.com.au"]
  s.homepage    = "http://github.com/justinfrench/treedoc"
  s.summary     = "Github + Markdown files as a CMS for your Rails app."
  s.description = "Render a tree of Markdown documents inside your Rails app."
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5.2.2"
  s.add_dependency "redcarpet"
end
