# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: perfect-shape 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "perfect-shape".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andy Maleh".freeze]
  s.date = "2021-12-22"
  s.description = "Perfect Shape is a collection of pure Ruby geometric algorithms that are mostly useful for GUI manipulation like checking containment of a mouse click point in popular geometry shapes such as rectangle, square, arc (open, chord, and pie), ellipse, circle, polygon, polyline, polyquad, polycubic, and paths containing lines, quadratic b\u00E9zier curves, and cubic b\u00E9zier curves (including both Ray Casting Algorithm, aka Even-odd Rule, and Winding Number Algorithm, aka Nonzero Rule). Additionally, it contains some purely mathematical algorithms like IEEEremainder (also known as IEEE-754 remainder).".freeze
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
    "lib/perfect_shape/circle.rb",
    "lib/perfect_shape/ellipse.rb",
    "lib/perfect_shape/line.rb",
    "lib/perfect_shape/math.rb",
    "lib/perfect_shape/multi_point.rb",
    "lib/perfect_shape/path.rb",
    "lib/perfect_shape/point.rb",
    "lib/perfect_shape/point_location.rb",
    "lib/perfect_shape/polygon.rb",
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
    s.add_runtime_dependency(%q<equalizer>.freeze, ["= 0.0.11"])
    s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.14.4"])
    s.add_development_dependency(%q<puts_debuggerer>.freeze, ["~> 0.13.1"])
    s.add_development_dependency(%q<rake-tui>.freeze, ["> 0"])
  else
    s.add_dependency(%q<equalizer>.freeze, ["= 0.0.11"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.14.4"])
    s.add_dependency(%q<puts_debuggerer>.freeze, ["~> 0.13.1"])
    s.add_dependency(%q<rake-tui>.freeze, ["> 0"])
  end
end

