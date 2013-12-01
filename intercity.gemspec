lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |spec|
  spec.name = 'intercity'
  spec.version =  '0.0.4'
  spec.licenses = ['MIT']
  spec.homepage = "https://github.com/intercity/intercity-gem"
  spec.description = "Use this gem to set up and deploy your application on your server."
  spec.authors = ['Michiel Sikkes']
  spec.email = ['michiel@firmhouse.com']
  spec.summary = %q{Integrations for using Intercity}
  spec.files = `git ls-files`.split($/)
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "capistrano", "~>2.15.4"
  spec.add_runtime_dependency "unicorn", "~> 4.7.0"
end