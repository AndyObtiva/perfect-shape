# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'juwelier'
Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "perfect-shape"
  gem.homepage = "http://github.com/AndyObtiva/perfect-shape"
  gem.license = "MIT"
  gem.summary = %Q{Perfect Shape - Geometric Algorithms}
  gem.description = %Q{Perfect Shape is a collection of pure Ruby geometric algorithms that are mostly useful for GUI manipulation like checking containment of a mouse click point in popular geometry shapes such as rectangle, square, arc (open, chord, and pie), ellipse, circle, polygon, polyline, polybezier, and paths containing lines, bezier curves, and quadratic curves. Additionally, it contains some purely mathematical algorithms like IEEEremainder (also known as IEEE-754 remainder).}
  gem.email = "andy.am@gmail.com"
  gem.authors = ["Andy Maleh"]
  gem.files = ['README.md', 'CHANGELOG.md', 'VERSION', 'LICENSE.txt', 'perfect-shape.gemspec', 'lib/**/*']

  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new

require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "perfect-shape #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
