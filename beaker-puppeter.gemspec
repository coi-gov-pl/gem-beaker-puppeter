
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "beaker/puppeter/version"

Gem::Specification.new do |spec|
  spec.name          = "beaker-puppeter"
  spec.version       = Beaker::Puppeter::VERSION
  spec.authors       = ["Suszyński Krzysztof"]
  spec.email         = ["krzysztof.suszynski@coi.gov.pl"]

  spec.summary       = "Integrates Puppeter into Beaker by adding extra helper methods"
  spec.description   = <<~eos
                        Puppeter is a automated, unattended, Puppet installer, and beaker-puppeter
                        is a Beaker extension that adds helper methods to use in your
                        spec_helper_acceptance file.
                       eos
  spec.homepage      = "https://github.com/coi-gov-pl/gem-beaker-puppeter"
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
