require 'glimmer-dsl-specification'

require_relative '../../lib/perfect-shape'

module Glimmer::Specification
  specification('Perfect Shape') {
    specification('Arc') {
      use_case('Construction') {
        scenario('construction with :chord type and dimensions') {
          arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50, height: 60, start: 30, extent: 90)
          fact { arc.x == 2 }
          fact { arc.y == 3 }
          fact { arc.width == 50 }
          fact { arc.height == 60 }
          fact { arc.start == 30 }
          fact { arc.extent == 90 }
        }
      }
    }
  }
end
