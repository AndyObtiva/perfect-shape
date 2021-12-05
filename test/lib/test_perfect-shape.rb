require "minitest/autorun"

require_relative '../../lib/perfect-shape'

describe PerfectShape do
  describe 'Arc' do
    it 'constructs with chord type and dimensions' do
      arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50, height: 60, start: 30, extent: 90)
      
      _(arc.type).must_equal :chord
      _(arc.y).must_equal 3
      _(arc.y).must_equal 3
      _(arc.width).must_equal 50
      _(arc.height).must_equal 60
      _(arc.start).must_equal 30
      _(arc.extent).must_equal 90
    end
    
    it 'constructs with chord type and defaults' do
      arc = PerfectShape::Arc.new

      _(arc.type).must_equal :open
      _(arc.x).must_equal 0
      _(arc.y).must_equal 0
      _(arc.width).must_equal 1
      _(arc.height).must_equal 1
      _(arc.start).must_equal 0
      _(arc.extent).must_equal 360
    end
  end
  
#   specification('Arc') {
#     use_case('Construction') {
#       scenario('construction with :chord type and dimensions') {
#       }
#
#       scenario('construction with defaults') {
#       }
#
#       scenario('updating attributes') {
#         arc = PerfectShape::Arc.new
#         arc.type = :chord
#         arc.x = 2
#         arc.y = 3
#         arc.width = 50
#         arc.height = 60
#         arc.start = 30
#         arc.extent = 90
#
#         fact { arc.type == :chord }
#         fact { arc.y == 3 }
#         fact { arc.y == 3 }
#         fact { arc.width == 50 }
#         fact { arc.height == 60 }
#         fact { arc.start == 30 }
#         fact { arc.extent == 90 }
#       }
#     }
#
#     use_case('check if arc contains point') {
#       scenario('point is inside chord arc') {
#         arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50, height: 60, start: 30, extent: 90)
#         point = [arc.x + arc.width / 2, arc.y + arc.height / 2]
#
#         fact { arc.contain?(*point) }
#         fact { arc.contain?(point) }
#       }
#
#       scenario('point is not inside chord arc') {
#         arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50, height: 60, start: 30, extent: 90)
#         point = [arc.x + arc.width / 2, arc.y + arc.height / 2]
#
#         fact { arc.contain?(*point) }
#         fact { arc.contain?(point) }
#       }
#     }
#   }
end
