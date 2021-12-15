# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: perfect-shape 0.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "perfect-shape".freeze
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andy Maleh".freeze]
  s.date = "2021-12-15"
  s.description = "Perfect Shape is a collection of pure Ruby geometric algorithms that are mostly useful for GUI manipulation like checking containment of a mouse click point in popular geometry shapes such as rectangle, square, arc (open, chord, and pie), ellipse, circle, polygon, polyline, polybezier, and paths containing lines, bezier curves, and quadratic curves. Additionally, it contains some purely mathematical algorithms like IEEEremainder (also known as IEEE-754 remainder).".freeze
  s.email = "andy.am@gmail.com".freeze
  s.extra_rdoc_files = [
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md",
    "VERSION",
    "lib/perfect-shape.rb",
    "lib/perfect_shape/arc.rb",
    "lib/perfect_shape/line.rb",
    "lib/perfect_shape/math.rb",
    "lib/perfect_shape/rectangle.rb",
    "lib/perfect_shape/rectangular_shape.rb",
    "lib/perfect_shape/shape.rb",
    "lib/perfect_shape/square.rb",
    "perfect-shape.gemspec"
  ]
  s.homepage = "http://github.com/AndyObtiva/perfect-shape".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.31".freeze
  s.summary = "Perfect Shape - Geometric Algorithms".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.14.4"])
    s.add_development_dependency(%q<puts_debuggerer>.freeze, ["~> 0.13.1"])
    s.add_development_dependency(%q<rake-tui>.freeze, ["> 0"])
  else
    s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.14.4"])
    s.add_dependency(%q<puts_debuggerer>.freeze, ["~> 0.13.1"])
    s.add_dependency(%q<rake-tui>.freeze, ["> 0"])
  end
end

