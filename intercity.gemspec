lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |spec|
  spec.name = 'intercity'
  spec.version =  '0.0.1'
  spec.licenses = ['MIT']
  spec.authors = ['Michiel Sikkes']
  spec.email = ['michiel@firmhouse.com']
  spec.summary = %q{Integrations for using Intercity}
  spec.files = `git ls-files`.split($/)
  spec.require_paths = ["lib"]
  spec.add_dependency "capistrano", "~>2.15.4"
end