require 'glimmer-dsl-specification'

require_relative '../../lib/perfect-shape'

module Glimmer::Specification
  specification('Arc') {
    use_case('Construction') {
      scenario('construction with :chord type and dimensions') {
        arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50, height: 60, start: 30, extent: 90)
        
        fact { arc.type == :chord }
        fact { arc.y == 3 }
        fact { arc.y == 3 }
        fact { arc.width == 50 }
        fact { arc.height == 60 }
        fact { arc.start == 30 }
        fact { arc.extent == 90 }
      }
      
      scenario('construction with defaults') {
        arc = PerfectShape::Arc.new
        
        fact { arc.type == :open }
        fact { arc.x == 0 }
        fact { arc.y == 0 }
        fact { arc.width == 1 }
        fact { arc.height == 1 }
        fact { arc.start == 0 }
        fact { arc.extent == 360 }
      }
      
      scenario('updating attributes') {
        arc = PerfectShape::Arc.new
        arc.type = :chord
        arc.x = 2
        arc.y = 3
        arc.width = 50
        arc.height = 60
        arc.start = 30
        arc.extent = 90
        
        fact { arc.type == :chord }
        fact { arc.y == 3 }
        fact { arc.y == 3 }
        fact { arc.width == 50 }
        fact { arc.height == 60 }
        fact { arc.start == 30 }
        fact { arc.extent == 90 }
      }
    }
    
    use_case('check if arc contains point') {
      scenario('point is inside chord arc') {
        arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50, height: 60, start: 30, extent: 90)
        point = [arc.x + arc.width / 2, arc.y + arc.height / 2]
        
        fact { arc.contain?(*point) }
        fact { arc.contain?(point) }
      }
      
#       scenario('point is not inside chord arc') {
#         arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50, height: 60, start: 30, extent: 90)
#         point = [arc.x + arc.width / 2, arc.y + arc.height / 2]
#
#         fact { arc.contain?(*point) }
#         fact { arc.contain?(point) }
#       }
    }
  }
end
