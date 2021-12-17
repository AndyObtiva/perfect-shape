require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Polygon do
    it 'constructs with points' do
      shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])

      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'constructs with flattened points' do
      shape = PerfectShape::Polygon.new(points: [200, 150, 270, 170, 250, 220, 220, 190, 200, 200, 180, 170])

      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'constructs with defaults' do
      shape = PerfectShape::Polygon.new

      _(shape.points).must_equal []
      _(shape.min_x).must_equal nil
      _(shape.min_y).must_equal nil
      _(shape.max_x).must_equal nil
      _(shape.max_y).must_equal nil
      _(shape.width).must_equal nil
      _(shape.height).must_equal nil
      _(shape.center_x).must_equal nil
      _(shape.center_y).must_equal nil
    end

    it 'updates attributes' do
      shape = PerfectShape::Polygon.new
      shape.points = [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]

      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
      
      shape.points = [200, 150]

      _(shape.points).must_equal [[200, 150]]
      _(shape.min_x).must_equal 200
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 200
      _(shape.max_y).must_equal 150
      _(shape.width).must_equal 0
      _(shape.height).must_equal 0
      _(shape.center_x).must_equal 200
      _(shape.center_y).must_equal 150
      
      shape.points << [270, 170]
      shape.points << [250, 220]
      shape.points << [220, 190]
      shape.points << [200, 200]
      shape.points << [180, 170]
      shape.points.delete [180, 170]
      shape.points << [180, 170]

      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

#     it 'contains point in center' do
#       shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
#       center = [shape.center_x, shape.center_y]
#
#       _(shape).must_be :contain?, center
#       _(shape.contain?(center)).must_equal shape.contain?(*center)
#     end
#
#     it 'contains point near left' do
#       shape = PerfectShape::Polygon.new(x: 2, y: 3, diameter: 60)
#       point = [shape.x + shape.width * 1.0 / 4.0, shape.y + (shape.height * 2.0 / 4.0)]
#
#       _(shape).must_be :contain?, point
#       _(shape.contain?(point)).must_equal shape.contain?(*point)
#     end
#
#     it 'contains point near right' do
#       shape = PerfectShape::Polygon.new(x: 2, y: 3, diameter: 60)
#       point = [shape.x + shape.width * 3.0 / 4.0, shape.y + (shape.height * 2.0 / 4.0)]
#
#       _(shape).must_be :contain?, point
#       _(shape.contain?(point)).must_equal shape.contain?(*point)
#     end
#
#     it 'contains point near top-right' do
#       shape = PerfectShape::Polygon.new(x: 2, y: 3, diameter: 60)
#       point = [shape.x + shape.width * 3.0 / 4.0, shape.y + (shape.height * 1.0 / 4.0)]
#
#       _(shape).must_be :contain?, point
#       _(shape.contain?(point)).must_equal shape.contain?(*point)
#     end
#
#     it 'contains point near top' do
#       shape = PerfectShape::Polygon.new(x: 2, y: 3, diameter: 60)
#       point = [shape.x + shape.width * 2.0 / 4.0, shape.y + (shape.height * 1.0 / 4.0)]
#
#       _(shape).must_be :contain?, point
#       _(shape.contain?(point)).must_equal shape.contain?(*point)
#     end
#
#     it 'contains point near top-left' do
#       shape = PerfectShape::Polygon.new(x: 2, y: 3, diameter: 60)
#       point = [shape.x + shape.width * 1.0 / 4.0, shape.y + (shape.height * 1.0 / 4.0)]
#
#       _(shape).must_be :contain?, point
#       _(shape.contain?(point)).must_equal shape.contain?(*point)
#     end
#
#     it 'contains point near bottom-right' do
#       shape = PerfectShape::Polygon.new(x: 2, y: 3, diameter: 60)
#       point = [shape.x + shape.width * 3.0 / 4.0, shape.y + (shape.height * 3.0 / 4.0)]
#
#       _(shape).must_be :contain?, point
#       _(shape.contain?(point)).must_equal shape.contain?(*point)
#     end
#
#     it 'contains point near bottom' do
#       shape = PerfectShape::Polygon.new(x: 2, y: 3, diameter: 60)
#       point = [shape.x + shape.width * 2.0 / 4.0, shape.y + (shape.height * 3.0 / 4.0)]
#
#       _(shape).must_be :contain?, point
#       _(shape.contain?(point)).must_equal shape.contain?(*point)
#     end
#
#     it 'contains point near bottom-left' do
#       shape = PerfectShape::Polygon.new(x: 2, y: 3, diameter: 60)
#       point = [shape.x + shape.width * 1.0 / 4.0, shape.y + (shape.height * 3.0 / 4.0)]
#
#       _(shape).must_be :contain?, point
#       _(shape.contain?(point)).must_equal shape.contain?(*point)
#     end
#
#     it 'does not contain point near top-right within bounding box' do
#       shape = PerfectShape::Polygon.new(x: 2, y: 3, diameter: 60)
#       point = [shape.x + shape.width*(3.9/4.0), shape.y + (shape.height * 1.0 / 4.0)]
#
#       _(shape.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point near bottom-right within bounding box' do
#       shape = PerfectShape::Polygon.new(x: 2, y: 3, diameter: 60)
#       point = [shape.x + shape.width*(3.9/4.0), shape.y + (shape.height * 3.0 / 4.0)]
#
#       _(shape.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point near top-left within bounding box' do
#       shape = PerfectShape::Polygon.new(x: 2, y: 3, diameter: 60)
#       point = [shape.x + shape.width*(0.1/4.0), shape.y + (shape.height * 1.0 / 4.0)]
#
#       _(shape.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point near bottom-left within bounding box' do
#       shape = PerfectShape::Polygon.new(x: 2, y: 3, diameter: 60)
#       point = [shape.x + shape.width*(0.1/4.0), shape.y + (shape.height * 3.0 / 4.0)]
#
#       _(shape.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point outside of bounding box' do
#       shape = PerfectShape::Polygon.new(x: 2, y: 3, diameter: 60)
#       point = [0, 0]
#
#       _(shape.contain?(point)).must_equal false
#     end
  end
end
