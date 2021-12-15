require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Ellipse do
    it 'constructs with dimensions (x,y,width,height)' do
      ellipse = PerfectShape::Ellipse.new(x: 2, y: 3, width: 50, height: 60)

      _(ellipse.type).must_equal :open
      _(ellipse.start).must_equal 0
      _(ellipse.extent).must_equal 360
      _(ellipse.x).must_equal 2
      _(ellipse.y).must_equal 3
      _(ellipse.width).must_equal 50
      _(ellipse.height).must_equal 60
      _(ellipse.center_x).must_equal 2 + 25
      _(ellipse.center_y).must_equal 3 + 30
      _(ellipse.radius_x).must_equal 25
      _(ellipse.radius_y).must_equal 30
    end

    it 'constructs with alternate dimensions (center_x, center_y, radius_x, radius_y)' do
      ellipse = PerfectShape::Ellipse.new(center_x: 2 + 25, center_y: 3 + 30, radius_x: 25, radius_y: 30)

      _(ellipse.type).must_equal :open
      _(ellipse.start).must_equal 0
      _(ellipse.extent).must_equal 360
      _(ellipse.x).must_equal 2
      _(ellipse.y).must_equal 3
      _(ellipse.width).must_equal 50
      _(ellipse.height).must_equal 60
      _(ellipse.center_x).must_equal 2 + 25
      _(ellipse.center_y).must_equal 3 + 30
      _(ellipse.radius_x).must_equal 25
      _(ellipse.radius_y).must_equal 30
    end

    it 'constructs with defaults' do
      ellipse = PerfectShape::Ellipse.new

      _(ellipse.type).must_equal :open
      _(ellipse.x).must_equal 0
      _(ellipse.y).must_equal 0
      _(ellipse.width).must_equal 1
      _(ellipse.height).must_equal 1
      _(ellipse.start).must_equal 0
      _(ellipse.extent).must_equal 360
      _(ellipse.center_x).must_equal 0.5
      _(ellipse.center_y).must_equal 0.5
      _(ellipse.radius_x).must_equal 0.5
      _(ellipse.radius_y).must_equal 0.5
    end

    it 'updates attributes with standard dimensions (x,y,width,height)' do
      ellipse = PerfectShape::Ellipse.new
      ellipse.x = 2
      ellipse.y = 3
      ellipse.width = 50
      ellipse.height = 60

      _(ellipse.type).must_equal :open
      _(ellipse.start).must_equal 0
      _(ellipse.extent).must_equal 360
      _(ellipse.x).must_equal 2
      _(ellipse.y).must_equal 3
      _(ellipse.width).must_equal 50
      _(ellipse.height).must_equal 60
      _(ellipse.center_x).must_equal 2 + 25
      _(ellipse.center_y).must_equal 3 + 30
      _(ellipse.radius_x).must_equal 25
      _(ellipse.radius_y).must_equal 30
    end

    it 'raises error for attempting to update type, start, or extent' do
      ellipse = PerfectShape::Ellipse.new
      proc { ellipse.type = :chord }.must_raise StandardError
      proc { ellipse.start = 30 }.must_raise StandardError
      proc { ellipse.extent = 45 }.must_raise StandardError
    end

    it 'updates attributes with alternate dimensions (center_x,center_y,radius_x,radius_y)' do
      ellipse = PerfectShape::Ellipse.new
      ellipse.center_x = 2 + 25
      ellipse.center_y = 3 + 30
      ellipse.radius_x = 25
      ellipse.radius_y = 30

      _(ellipse.type).must_equal :open
      _(ellipse.start).must_equal 0
      _(ellipse.extent).must_equal 360
      _(ellipse.x).must_equal 2
      _(ellipse.y).must_equal 3
      _(ellipse.width).must_equal 50
      _(ellipse.height).must_equal 60
      _(ellipse.center_x).must_equal 2 + 25
      _(ellipse.center_y).must_equal 3 + 30
      _(ellipse.radius_x).must_equal 25
      _(ellipse.radius_y).must_equal 30
    end

#     it 'contains point with chord type circle' do
#       ellipse = PerfectShape::Ellipse.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
#       point = [ellipse.x + ellipse.width / 2.0, ellipse.y + ellipse.height / 2.0]
#
#       _(ellipse).must_be :contain?, point
#       _(ellipse.contain?(*point)).must_equal ellipse.contain?(point)
#     end
#
#     it 'contains point with chord type ellipse' do
#       ellipse = PerfectShape::Ellipse.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
#       point = [ellipse.x + ellipse.width*3/4.0, ellipse.y + (ellipse.height / 2.0)]
#
#       _(ellipse).must_be :contain?, point
#       _(ellipse.contain?(*point)).must_equal ellipse.contain?(point)
#     end
#
#     it 'does not contain point within bounding box with chord type ellipse' do
#       ellipse = PerfectShape::Ellipse.new(type: :chord, x: 2, y: 3, width: 67, height: 46, start: 45, extent: 270)
#       point = [ellipse.x + ellipse.width*(3.9/4.0), ellipse.y + (ellipse.height / 2.0)]
#
#       _(ellipse.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point in center of chord type ellipse' do
#       ellipse = PerfectShape::Ellipse.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
#       point = [ellipse.x + ellipse.width / 2.0, ellipse.y + ellipse.height / 2.0]
#
#       _(ellipse.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point within bounding box with chord type circle' do
#       ellipse = PerfectShape::Ellipse.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
#       point = [3.0, 4.0]
#
#       _(ellipse.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point outside bounding box with chord type circle' do
#       ellipse = PerfectShape::Ellipse.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
#       point = [1.0, 2.0]
#
#       _(ellipse.contain?(point)).must_equal false
#     end
#
#     it 'contains point with open type circle' do
#       ellipse = PerfectShape::Ellipse.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
#       point = [ellipse.x + ellipse.width / 2.0, ellipse.y + ellipse.height / 2.0]
#
#       _(ellipse).must_be :contain?, point
#       _(ellipse.contain?(point)).must_equal ellipse.contain?(*point)
#     end
#
#     it 'contains point with open type ellipse' do
#       ellipse = PerfectShape::Ellipse.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
#       point = [ellipse.x + ellipse.width*3/4.0, ellipse.y + (ellipse.height / 2.0)]
#
#       _(ellipse).must_be :contain?, point
#       _(ellipse.contain?(point)).must_equal ellipse.contain?(*point)
#     end
#
#     it 'does not contain point within bounding box with open type ellipse' do
#       ellipse = PerfectShape::Ellipse.new(type: :open, x: 2, y: 3, width: 67, height: 46, start: 45, extent: 270)
#       point = [ellipse.x + ellipse.width*(3.9/4.0), ellipse.y + (ellipse.height / 2.0)]
#
#       _(ellipse.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point in center of open type ellipse' do
#       ellipse = PerfectShape::Ellipse.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
#       point = [ellipse.x + ellipse.width / 2.0, ellipse.y + ellipse.height / 2.0]
#
#       _(ellipse.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point within bounding box with open type circle' do
#       ellipse = PerfectShape::Ellipse.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
#       point = [3.0, 4.0]
#
#       _(ellipse.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point outside bounding box with open type circle' do
#       ellipse = PerfectShape::Ellipse.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
#       point = [1.0, 2.0]
#
#       _(ellipse.contain?(point)).must_equal false
#     end
#
#     it 'contains point with pie type circle' do
#       ellipse = PerfectShape::Ellipse.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
#       point = [ellipse.x + ellipse.width / 2.0, ellipse.y + ellipse.height / 2.0]
#
#       _(ellipse).must_be :contain?, point
#       _(ellipse.contain?(point)).must_equal ellipse.contain?(*point)
#     end
#
#     it 'contains point in center of pie type ellipse' do
#       ellipse = PerfectShape::Ellipse.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
#       point = [ellipse.x + ellipse.width / 2.0, ellipse.y + ellipse.height / 2.0]
#
#       _(ellipse).must_be :contain?, point
#       _(ellipse.contain?(point)).must_equal ellipse.contain?(*point)
#     end
#
#     it 'contains point with pie type ellipse' do
#       ellipse = PerfectShape::Ellipse.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
#       point = [ellipse.x + ellipse.width / 2.0 + (ellipse.width / 4.0), ellipse.y + (ellipse.height / 2.0) - (ellipse.height / 4.0)]
#
#       _(ellipse).must_be :contain?, point
#       _(ellipse.contain?(point)).must_equal ellipse.contain?(*point)
#     end
#
#     it 'does not contain point within bounding box with pie type ellipse' do
#       ellipse = PerfectShape::Ellipse.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
#       point = [ellipse.x + (ellipse.width / 2.0) - (ellipse.width / 4.0), ellipse.y + ellipse.height / 2.0]
#
#       _(ellipse.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point within bounding box with pie type circle' do
#       ellipse = PerfectShape::Ellipse.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
#       point = [3.0, 4.0]
#
#       _(ellipse.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point outside bounding box with pie type circle' do
#       ellipse = PerfectShape::Ellipse.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
#       point = [1.0, 2.0]
#
#       _(ellipse.contain?(point)).must_equal false
#     end
  end
end
