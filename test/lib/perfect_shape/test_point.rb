require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Point do
    it 'constructs' do
      shape = PerfectShape::Point.new(200, 150)

      _(shape.x).must_equal 200
      _(shape.y).must_equal 150
      _(shape.min_x).must_equal 200
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 200
      _(shape.max_y).must_equal 150
      _(shape.width).must_equal 0
      _(shape.height).must_equal 0
      _(shape.center_x).must_equal 200
      _(shape.center_y).must_equal 150
    end

#     it 'constructs with flattened points' do
#       shape = PerfectShape::Point.new(points: [200, 150, 270, 170])
#
#       _(shape.points).must_equal [[200, 150], [270, 170]]
#       _(shape.min_x).must_equal 200
#       _(shape.min_y).must_equal 150
#       _(shape.max_x).must_equal 270
#       _(shape.max_y).must_equal 170
#       _(shape.width).must_equal 70
#       _(shape.height).must_equal 20
#       _(shape.center_x).must_equal 200 + 35
#       _(shape.center_y).must_equal 150 + 10
#     end
#
#     it 'constructs with defaults' do
#       shape = PerfectShape::Point.new
#
#       _(shape.points).must_equal []
#       _(shape.min_x).must_equal nil
#       _(shape.min_y).must_equal nil
#       _(shape.max_x).must_equal nil
#       _(shape.max_y).must_equal nil
#       _(shape.width).must_equal nil
#       _(shape.height).must_equal nil
#       _(shape.center_x).must_equal nil
#       _(shape.center_y).must_equal nil
#     end
#
#     it 'updates attributes' do
#       shape = PerfectShape::Point.new
#       shape.points = [[200, 150], [270, 170]]
#
#       _(shape.points).must_equal [[200, 150], [270, 170]]
#       _(shape.min_x).must_equal 200
#       _(shape.min_y).must_equal 150
#       _(shape.max_x).must_equal 270
#       _(shape.max_y).must_equal 170
#       _(shape.width).must_equal 70
#       _(shape.height).must_equal 20
#       _(shape.center_x).must_equal 200 + 35
#       _(shape.center_y).must_equal 150 + 10
#     end
#
#     it 'returns distance between two points' do
#       distance = PerfectShape::Point.distance([0, 0], [100, 0])
#
#       _(distance).must_equal 100
#     end
  end
end
