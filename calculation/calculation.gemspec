require_relative "lib/calculation/version"

Gem::Specification.new do |spec|
  spec.name        = "calculation"
  spec.version     = Calculation::VERSION
  spec.authors     = ["jeniaefimov"]
  spec.email       = ["e.effimov@gmail.com"]
  spec.homepage    = ""
  spec.summary     = ""
  spec.description = ""

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.2.3"
  spec.add_dependency "httparty", "~> 0.20.0"

  spec.add_development_dependency "rspec-rails", "~> 5.1.1"
  spec.add_development_dependency "factory_bot_rails", "~> 6.2.0"
end
