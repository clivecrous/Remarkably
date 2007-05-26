require 'rake'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s| 
  s.name = "Remarkably"
  s.version = "0.4.0"
  s.author = "Clive Crous"
  s.email = "clive@darkarts.co.za"
  s.homepage = "http://www.darkarts.co.za/"
  s.platform = Gem::Platform::RUBY
  s.summary = "Remarkably is a very tiny Markaby-like XML builder"
  s.files = FileList["lib/**/*"].to_a
  s.require_path = "lib"
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end 

desc "Run the unit tests"
task :test do
  sh "spec spec/"
end

desc "Create the documentation"
task :doc do
  sh "rdoc lib"
end

task :default => %w{test}
