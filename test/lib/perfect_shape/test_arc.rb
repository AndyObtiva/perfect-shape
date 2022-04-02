require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Arc do
    it 'constructs with chord type and dimensions (x,y,width,height)' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50, height: 60, start: 30, extent: 90)

      _(shape.type).must_equal :chord
      _(shape.x).must_equal 2
      _(shape.y).must_equal 3
      _(shape.width).must_equal 50
      _(shape.height).must_equal 60
      _(shape.start).must_equal 30
      _(shape.extent).must_equal 90
      _(shape.center_x).must_equal 2 + 25
      _(shape.center_y).must_equal 3 + 30
      _(shape.radius_x).must_equal 25
      _(shape.radius_y).must_equal 30
      _(shape.min_x).must_equal 2
      _(shape.min_y).must_equal 3
      _(shape.max_x).must_equal 2 + 50
      _(shape.max_y).must_equal 3 + 60
      _(shape.bounding_box).must_equal PerfectShape::Rectangle.new(x: shape.min_x, y: shape.min_y, width: shape.width, height: shape.height)
    end

    it 'constructs with chord type and alternate dimensions (center_x, center_y, radius_x, radius_y)' do
      shape = PerfectShape::Arc.new(type: :chord, center_x: 2 + 25, center_y: 3 + 30, radius_x: 25, radius_y: 30, start: 30, extent: 90)

      _(shape.type).must_equal :chord
      _(shape.x).must_equal 2
      _(shape.y).must_equal 3
      _(shape.width).must_equal 50
      _(shape.height).must_equal 60
      _(shape.start).must_equal 30
      _(shape.extent).must_equal 90
      _(shape.center_x).must_equal 2 + 25
      _(shape.center_y).must_equal 3 + 30
      _(shape.radius_x).must_equal 25
      _(shape.radius_y).must_equal 30
    end

    it 'constructs with open type defaults' do
      shape = PerfectShape::Arc.new

      _(shape.type).must_equal :open
      _(shape.x).must_equal 0
      _(shape.y).must_equal 0
      _(shape.width).must_equal 1
      _(shape.height).must_equal 1
      _(shape.start).must_equal 0
      _(shape.extent).must_equal 360
      _(shape.center_x).must_equal 0.5
      _(shape.center_y).must_equal 0.5
      _(shape.radius_x).must_equal 0.5
      _(shape.radius_y).must_equal 0.5
    end

    it 'updates attributes with standard dimensions (x,y,width,height)' do
      shape = PerfectShape::Arc.new
      shape.type = :chord
      shape.x = 2
      shape.y = 3
      shape.width = 50
      shape.height = 60
      shape.start = 30
      shape.extent = 90

      _(shape.type).must_equal :chord
      _(shape.x).must_equal 2
      _(shape.y).must_equal 3
      _(shape.width).must_equal 50
      _(shape.height).must_equal 60
      _(shape.start).must_equal 30
      _(shape.extent).must_equal 90
      _(shape.center_x).must_equal 2 + 25
      _(shape.center_y).must_equal 3 + 30
      _(shape.radius_x).must_equal 25
      _(shape.radius_y).must_equal 30
    end

    it 'updates attributes with alternate dimensions (center_x,center_y,radius_x,radius_y)' do
      shape = PerfectShape::Arc.new
      shape.type = :chord
      shape.center_x = 2 + 25
      shape.center_y = 3 + 30
      shape.radius_x = 25
      shape.radius_y = 30
      shape.start = 30
      shape.extent = 90

      _(shape.type).must_equal :chord
      _(shape.x).must_equal 2
      _(shape.y).must_equal 3
      _(shape.width).must_equal 50
      _(shape.height).must_equal 60
      _(shape.start).must_equal 30
      _(shape.extent).must_equal 90
      _(shape.center_x).must_equal 2 + 25
      _(shape.center_y).must_equal 3 + 30
      _(shape.radius_x).must_equal 25
      _(shape.radius_y).must_equal 30
    end

    it 'equals another arc' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50, height: 60, start: 30, extent: 90)
      shape2 = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50, height: 60, start: 30, extent: 90)

      _(shape).must_equal shape2
    end

    it 'does not equal a different arc' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50, height: 60, start: 30, extent: 90)
      shape2 = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50, height: 60, start: 30, extent: 90)

      _(shape).wont_equal shape2

      shape3 = PerfectShape::Arc.new(type: :chord, x: 3, y: 3, width: 50, height: 60, start: 30, extent: 90)

      _(shape).wont_equal shape3
    end

    it 'contains point with chord type circle' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [shape.x + shape.width / 2.0, shape.y + shape.height / 2.0]

      _(shape).must_be :contain?, point
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'contains point with chord type shape' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x + shape.width*3/4.0, shape.y + (shape.height / 2.0)]

      _(shape).must_be :contain?, point
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'does not contain point on the outline with chord type shape' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x + (shape.width / 2.0), shape.y + (shape.height / 2.0)]

      refute shape.contain?(point, outline: true)
    end

    it 'contains point on the outline with chord type shape' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x, shape.y + (shape.height / 2.0)]

      assert shape.contain?(point, outline: true)
    end

    it 'does not contain point on the outline with chord type shape not having distance tolerance' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x + 1, shape.y + (shape.height / 2.0)]

      refute shape.contain?(point, outline: true)
    end

    it 'contains point on the outline with distance tolerance and chord type shape' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x + 1, shape.y + (shape.height / 2.0)]

      assert shape.contain?(point, outline: true, distance_tolerance: 1)
    end

    it 'does not contain point within bounding box with chord type shape' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 67, height: 46, start: 45, extent: 270)
      point = [shape.x + shape.width*(3.9/4.0), shape.y + (shape.height / 2.0)]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point in center of chord type shape' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      point = [shape.x + shape.width / 2.0, shape.y + shape.height / 2.0]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point within bounding box with chord type circle' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [3.0, 4.0]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point outside bounding box with chord type circle' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [1.0, 2.0]

      _(shape.contain?(point)).must_equal false
    end

    it 'contains point with open type circle' do
      shape = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [shape.x + shape.width / 2.0, shape.y + shape.height / 2.0]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point with open type shape' do
      shape = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x + shape.width*3/4.0, shape.y + (shape.height / 2.0)]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point on the outline with open type shape' do
      shape = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x + (shape.width / 2.0), shape.y + (shape.height / 2.0)]

      refute shape.contain?(point, outline: true)
    end

    it 'contains point on the outline with open type shape' do
      shape = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x, shape.y + (shape.height / 2.0)]

      assert shape.contain?(point, outline: true)
    end

    it 'does not contain point on the outline with open type shape not having distance tolerance' do
      shape = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x + 1, shape.y + (shape.height / 2.0)]

      refute shape.contain?(point, outline: true)
    end

    it 'contains point on the outline with distance tolerance and open type shape' do
      shape = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x + 1, shape.y + (shape.height / 2.0)]

      assert shape.contain?(point, outline: true, distance_tolerance: 1)
    end

    it 'does not contain point within bounding box with open type shape' do
      shape = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 67, height: 46, start: 45, extent: 270)
      point = [shape.x + shape.width*(3.9/4.0), shape.y + (shape.height / 2.0)]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point in center of open type shape' do
      shape = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      point = [shape.x + shape.width / 2.0, shape.y + shape.height / 2.0]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point within bounding box with open type circle' do
      shape = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [3.0, 4.0]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point outside bounding box with open type circle' do
      shape = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [1.0, 2.0]

      _(shape.contain?(point)).must_equal false
    end

    it 'contains point with pie type circle' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [shape.x + shape.width / 2.0, shape.y + shape.height / 2.0]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point in center of pie type shape' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      point = [shape.x + shape.width / 2.0, shape.y + shape.height / 2.0]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point on the outline with pie type shape' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x + (shape.width / 4.0), shape.y + (shape.height / 4.0)]

      refute shape.contain?(point, outline: true)
    end

    it 'contains center point on the outline with pie type shape' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.center_x, shape.center_y]

      assert shape.contain?(point, outline: true)
    end

    it 'contains point on radius on the outline with pie type shape' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 270)
      point = [shape.center_x + 25.25, shape.center_y]

      assert shape.contain?(point, outline: true)
    end

    it 'contains point on the outline with pie type shape' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x, shape.y + (shape.height / 2.0)]

      assert shape.contain?(point, outline: true)
    end

    it 'does not contain point on the outline with pie type shape not having distance tolerance' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x + 1, shape.y + (shape.height / 2.0)]

      refute shape.contain?(point, outline: true)
    end

    it 'contains point on the outline with distance tolerance and pie type shape' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [shape.x + 1, shape.y + (shape.height / 2.0)]

      assert shape.contain?(point, outline: true, distance_tolerance: 1)
    end

    it 'contains point with pie type shape' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      point = [shape.x + shape.width / 2.0 + (shape.width / 4.0), shape.y + (shape.height / 2.0) - (shape.height / 4.0)]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point within bounding box with pie type shape' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      point = [shape.x + (shape.width / 2.0) - (shape.width / 4.0), shape.y + shape.height / 2.0]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point within bounding box with pie type circle' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [3.0, 4.0]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point outside bounding box with pie type circle' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [1.0, 2.0]

      _(shape.contain?(point)).must_equal false
    end

    it 'intersects with rectangle as type chord' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 25.25, height: 30.375)

      assert shape.intersect?(rectangle)
    end

    it 'intersects with rectangle by lying within it as type chord' do
      shape = PerfectShape::Arc.new(type: :chord, x: 3, y: 4, width: 40.5, height: 50.75, start: 0, extent: 145)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50.5, height: 60.75)

      assert shape.intersect?(rectangle)
    end

    it 'intersects with rectangle by containing it as type chord' do
      shape = PerfectShape::Arc.new(type: :chord, x: -20, y: -30, width: 100.5, height: 120.75, start: 0, extent: 145)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 25.25, height: 30.375)

      assert shape.intersect?(rectangle)
    end

    it 'does not intersect with rectangle as type chord' do
      shape = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 2 + 30.375, width: 25.25, height: 30.375)

      refute shape.intersect?(rectangle)
    end

    it 'intersects with rectangle as type open' do
      shape = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 25.25, height: 30.375)

      assert shape.intersect?(rectangle)
    end

    it 'intersects with rectangle by lying within it as type open' do
      shape = PerfectShape::Arc.new(type: :open, x: 3, y: 4, width: 40.5, height: 50.75, start: 0, extent: 145)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50.5, height: 60.75)

      assert shape.intersect?(rectangle)
    end

    it 'intersects with rectangle by containing it as type open' do
      shape = PerfectShape::Arc.new(type: :open, x: -20, y: -30, width: 100.5, height: 120.75, start: 0, extent: 145)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 25.25, height: 30.375)

      assert shape.intersect?(rectangle)
    end

    it 'does not intersect with rectangle as type open' do
      shape = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 2 + 30.375, width: 25.25, height: 30.375)

      refute shape.intersect?(rectangle)
    end

    it 'intersects with rectangle as type pie' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 25.25, height: 30.375)

      assert shape.intersect?(rectangle)
    end

    it 'intersects with rectangle by lying within it as type pie' do
      shape = PerfectShape::Arc.new(type: :pie, x: 3, y: 4, width: 40.5, height: 50.75, start: 0, extent: 145)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50.5, height: 60.75)

      assert shape.intersect?(rectangle)
    end

    it 'intersects with rectangle by containing it as type pie' do
      shape = PerfectShape::Arc.new(type: :pie, x: -20, y: -30, width: 100.5, height: 120.75, start: 0, extent: 145)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 25.25, height: 30.375)

      assert shape.intersect?(rectangle)
    end

    it 'intersects with rectangle getting into pie part as type pie' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 2 + 30.375, width: 25.25, height: 30.375)

      assert shape.intersect?(rectangle)
    end

    it 'does not intersect with rectangle as type pie' do
      shape = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 4 + 30.375, width: 25.25, height: 30.375)

      refute shape.intersect?(rectangle)
    end

    it 'returns path shapes as an open type arc that is an ellipse' do
      shape = PerfectShape::Arc.new(type: :open, x: 300, y: 400, width: 200, height: 100, start: 0, extent: 360)

      _(shape.to_path_shapes.count).must_equal 5
      _(shape.to_path_shapes.map(&:class)).must_equal [PerfectShape::Point, PerfectShape::CubicBezierCurve, PerfectShape::CubicBezierCurve, PerfectShape::CubicBezierCurve, PerfectShape::CubicBezierCurve]

      _(shape.to_path_shapes[0].x).must_equal 500.0
      _(shape.to_path_shapes[0].y).must_equal 350.0

      _(shape.to_path_shapes[1].points[0][0].to_i).must_equal 500
      _(shape.to_path_shapes[1].points[0][1].to_i).must_equal 322
      _(shape.to_path_shapes[1].points[1][0].to_i).must_equal 455
      _(shape.to_path_shapes[1].points[1][1].to_i).must_equal 300
      _(shape.to_path_shapes[1].points[2][0].to_i).must_equal 399
      _(shape.to_path_shapes[1].points[2][1].to_i).must_equal 300

      _(shape.to_path_shapes[2].points[0][0].to_i).must_equal 344
      _(shape.to_path_shapes[2].points[0][1].to_i).must_equal 300
      _(shape.to_path_shapes[2].points[1][0].to_i).must_equal 300
      _(shape.to_path_shapes[2].points[1][1].to_i).must_equal 322
      _(shape.to_path_shapes[2].points[2][0].to_i).must_equal 300
      _(shape.to_path_shapes[2].points[2][1].to_i).must_equal 350

      _(shape.to_path_shapes[3].points[0][0].to_i).must_equal 300
      _(shape.to_path_shapes[3].points[0][1].to_i).must_equal 377
      _(shape.to_path_shapes[3].points[1][0].to_i).must_equal 344
      _(shape.to_path_shapes[3].points[1][1].ceil).must_equal 400
      _(shape.to_path_shapes[3].points[2][0].to_i).must_equal 399
      _(shape.to_path_shapes[3].points[2][1].to_i).must_equal 400

      _(shape.to_path_shapes[4].points[0][0].to_i).must_equal 455
      _(shape.to_path_shapes[4].points[0][1].to_i).must_equal 400
      _(shape.to_path_shapes[4].points[1][0].to_i).must_equal 500
      _(shape.to_path_shapes[4].points[1][1].to_i).must_equal 377
      _(shape.to_path_shapes[4].points[2][0].to_i).must_equal 500
      _(shape.to_path_shapes[4].points[2][1].to_i).must_equal 349
    end

    it 'returns path shapes as an open type arc that is between three quarter and full ellipse' do
      shape = PerfectShape::Arc.new(type: :open, x: 300, y: 400, width: 200, height: 100, start: 0, extent: 315)

      _(shape.to_path_shapes.count).must_equal 5
      _(shape.to_path_shapes.map(&:class)).must_equal [PerfectShape::Point, PerfectShape::CubicBezierCurve, PerfectShape::CubicBezierCurve, PerfectShape::CubicBezierCurve, PerfectShape::CubicBezierCurve]

      _(shape.to_path_shapes[0].x).must_equal 500.0
      _(shape.to_path_shapes[0].y).must_equal 350.0

      _(shape.to_path_shapes[1].points[0][0].to_i).must_equal 500
      _(shape.to_path_shapes[1].points[0][1].to_i).must_equal 326
      _(shape.to_path_shapes[1].points[1][0].to_i).must_equal 466
      _(shape.to_path_shapes[1].points[1][1].to_i).must_equal 305
      _(shape.to_path_shapes[1].points[2][0].to_i).must_equal 419
      _(shape.to_path_shapes[1].points[2][1].to_i).must_equal 300

      _(shape.to_path_shapes[2].points[0][0].to_i).must_equal 372
      _(shape.to_path_shapes[2].points[0][1].to_i).must_equal 296
      _(shape.to_path_shapes[2].points[1][0].to_i).must_equal 325
      _(shape.to_path_shapes[2].points[1][1].to_i).must_equal 308
      _(shape.to_path_shapes[2].points[2][0].to_i).must_equal 307
      _(shape.to_path_shapes[2].points[2][1].to_i).must_equal 330

      _(shape.to_path_shapes[3].points[0][0].to_i).must_equal 289
      _(shape.to_path_shapes[3].points[0][1].to_i).must_equal 352
      _(shape.to_path_shapes[3].points[1][0].to_i).must_equal 304
      _(shape.to_path_shapes[3].points[1][1].to_i).must_equal 378
      _(shape.to_path_shapes[3].points[2][0].to_i).must_equal 344
      _(shape.to_path_shapes[3].points[2][1].to_i).must_equal 391

      _(shape.to_path_shapes[4].points[0][0].to_i).must_equal 384
      _(shape.to_path_shapes[4].points[0][1].to_i).must_equal 404
      _(shape.to_path_shapes[4].points[1][0].to_i).must_equal 436
      _(shape.to_path_shapes[4].points[1][1].to_i).must_equal 402
      _(shape.to_path_shapes[4].points[2][0].to_i).must_equal 470
      _(shape.to_path_shapes[4].points[2][1].to_i).must_equal 385
    end

    it 'returns path shapes as an open type arc that is three quarters of an ellipse' do
      shape = PerfectShape::Arc.new(type: :open, x: 300, y: 400, width: 200, height: 100, start: 0, extent: 270)

      _(shape.to_path_shapes.count).must_equal 4
      _(shape.to_path_shapes.map(&:class)).must_equal [PerfectShape::Point, PerfectShape::CubicBezierCurve, PerfectShape::CubicBezierCurve, PerfectShape::CubicBezierCurve]

      _(shape.to_path_shapes[0].x).must_equal 500.0
      _(shape.to_path_shapes[0].y).must_equal 350.0

      _(shape.to_path_shapes[1].points[0][0].to_i).must_equal 500
      _(shape.to_path_shapes[1].points[0][1].to_i).must_equal 322
      _(shape.to_path_shapes[1].points[1][0].to_i).must_equal 455
      _(shape.to_path_shapes[1].points[1][1].to_i).must_equal 300
      _(shape.to_path_shapes[1].points[2][0].to_i).must_equal 400
      _(shape.to_path_shapes[1].points[2][1].to_i).must_equal 300

      _(shape.to_path_shapes[2].points[0][0].to_i).must_equal 344
      _(shape.to_path_shapes[2].points[0][1].to_i).must_equal 299
      _(shape.to_path_shapes[2].points[1][0].to_i).must_equal 300
      _(shape.to_path_shapes[2].points[1][1].to_i).must_equal 322
      _(shape.to_path_shapes[2].points[2][0].to_i).must_equal 300
      _(shape.to_path_shapes[2].points[2][1].to_i).must_equal 349

      _(shape.to_path_shapes[3].points[0][0].to_i).must_equal 299
      _(shape.to_path_shapes[3].points[0][1].to_i).must_equal 377
      _(shape.to_path_shapes[3].points[1][0].to_i).must_equal 344
      _(shape.to_path_shapes[3].points[1][1].to_i).must_equal 399
      _(shape.to_path_shapes[3].points[2][0].to_i).must_equal 399
      _(shape.to_path_shapes[3].points[2][1].to_i).must_equal 400
    end

    it 'returns path shapes as an open type arc that is between half and three quarters of an ellipse' do
      shape = PerfectShape::Arc.new(type: :open, x: 300, y: 400, width: 200, height: 100, start: 0, extent: 225)

      _(shape.to_path_shapes.count).must_equal 4
      _(shape.to_path_shapes.map(&:class)).must_equal [PerfectShape::Point, PerfectShape::CubicBezierCurve, PerfectShape::CubicBezierCurve, PerfectShape::CubicBezierCurve]

      _(shape.to_path_shapes[0].x).must_equal 500.0
      _(shape.to_path_shapes[0].y).must_equal 350.0

      _(shape.to_path_shapes[1].points[0][0].to_i).must_equal 500
      _(shape.to_path_shapes[1].points[0][1].to_i).must_equal 327
      _(shape.to_path_shapes[1].points[1][0].to_i).must_equal 469
      _(shape.to_path_shapes[1].points[1][1].to_i).must_equal 307
      _(shape.to_path_shapes[1].points[2][0].to_i).must_equal 425
      _(shape.to_path_shapes[1].points[2][1].to_i).must_equal 301

      _(shape.to_path_shapes[2].points[0][0].to_i).must_equal 382
      _(shape.to_path_shapes[2].points[0][1].to_i).must_equal 295
      _(shape.to_path_shapes[2].points[1][0].to_i).must_equal 336
      _(shape.to_path_shapes[2].points[1][1].to_i).must_equal 305
      _(shape.to_path_shapes[2].points[2][0].to_i).must_equal 313
      _(shape.to_path_shapes[2].points[2][1].to_i).must_equal 324

      _(shape.to_path_shapes[3].points[0][0].to_i).must_equal 290
      _(shape.to_path_shapes[3].points[0][1].to_i).must_equal 344
      _(shape.to_path_shapes[3].points[1][0].to_i).must_equal 297
      _(shape.to_path_shapes[3].points[1][1].to_i).must_equal 369
      _(shape.to_path_shapes[3].points[2][0].to_i).must_equal 329
      _(shape.to_path_shapes[3].points[2][1].to_i).must_equal 385
    end

    it 'returns path shapes as an open type arc that is half an ellipse' do
      shape = PerfectShape::Arc.new(type: :open, x: 300, y: 400, width: 200, height: 100, start: 0, extent: 180)

      _(shape.to_path_shapes.count).must_equal 3
      _(shape.to_path_shapes.map(&:class)).must_equal [PerfectShape::Point, PerfectShape::CubicBezierCurve, PerfectShape::CubicBezierCurve]

      _(shape.to_path_shapes[0].x).must_equal 500.0
      _(shape.to_path_shapes[0].y).must_equal 350.0

      _(shape.to_path_shapes[1].points[0][0].to_i).must_equal 500
      _(shape.to_path_shapes[1].points[0][1].to_i).must_equal 322
      _(shape.to_path_shapes[1].points[1][0].to_i).must_equal 455
      _(shape.to_path_shapes[1].points[1][1].to_i).must_equal 300
      _(shape.to_path_shapes[1].points[2][0].to_i).must_equal 400
      _(shape.to_path_shapes[1].points[2][1].to_i).must_equal 300

      _(shape.to_path_shapes[2].points[0][0].to_i).must_equal 344
      _(shape.to_path_shapes[2].points[0][1].to_i).must_equal 299
      _(shape.to_path_shapes[2].points[1][0].to_i).must_equal 300
      _(shape.to_path_shapes[2].points[1][1].to_i).must_equal 322
      _(shape.to_path_shapes[2].points[2][0].to_i).must_equal 300
      _(shape.to_path_shapes[2].points[2][1].to_i).must_equal 349
    end

    it 'returns path shapes as an open type arc that is between one quarter and half an ellipse' do
      shape = PerfectShape::Arc.new(type: :open, x: 300, y: 400, width: 200, height: 100, start: 0, extent: 135)

      _(shape.to_path_shapes.count).must_equal 3
      _(shape.to_path_shapes.map(&:class)).must_equal [PerfectShape::Point, PerfectShape::CubicBezierCurve, PerfectShape::CubicBezierCurve]

      _(shape.to_path_shapes[0].x).must_equal 500.0
      _(shape.to_path_shapes[0].y).must_equal 350.0

      _(shape.to_path_shapes[1].points[0][0].to_i).must_equal 500
      _(shape.to_path_shapes[1].points[0][1].to_i).must_equal 329
      _(shape.to_path_shapes[1].points[1][0].to_i).must_equal 475
      _(shape.to_path_shapes[1].points[1][1].to_i).must_equal 311
      _(shape.to_path_shapes[1].points[2][0].to_i).must_equal 438
      _(shape.to_path_shapes[1].points[2][1].to_i).must_equal 303

      _(shape.to_path_shapes[2].points[0][0].to_i).must_equal 400
      _(shape.to_path_shapes[2].points[0][1].to_i).must_equal 296
      _(shape.to_path_shapes[2].points[1][0].to_i).must_equal 357
      _(shape.to_path_shapes[2].points[1][1].to_i).must_equal 300
      _(shape.to_path_shapes[2].points[2][0].to_i).must_equal 329
      _(shape.to_path_shapes[2].points[2][1].to_i).must_equal 314
    end
    
    it 'returns path shapes as an open type arc that is one quarter of an ellipse' do
      shape = PerfectShape::Arc.new(type: :open, x: 300, y: 400, width: 200, height: 100, start: 0, extent: 90)
      
      _(shape.to_path_shapes.count).must_equal 2
      _(shape.to_path_shapes.map(&:class)).must_equal [PerfectShape::Point, PerfectShape::CubicBezierCurve]
      
      _(shape.to_path_shapes[0].x).must_equal 500.0
      _(shape.to_path_shapes[0].y).must_equal 350.0
      
      _(shape.to_path_shapes[1].points[0][0].to_i).must_equal 500
      _(shape.to_path_shapes[1].points[0][1].to_i).must_equal 322
      _(shape.to_path_shapes[1].points[1][0].to_i).must_equal 455
      _(shape.to_path_shapes[1].points[1][1].to_i).must_equal 300
      _(shape.to_path_shapes[1].points[2][0].to_i).must_equal 400
      _(shape.to_path_shapes[1].points[2][1].to_i).must_equal 300
    end
    
    it 'returns path shapes as an open type arc that is less than one quarter of an ellipse' do
      shape = PerfectShape::Arc.new(type: :open, x: 300, y: 400, width: 200, height: 100, start: 0, extent: 45)
      
      _(shape.to_path_shapes.count).must_equal 2
      _(shape.to_path_shapes.map(&:class)).must_equal [PerfectShape::Point, PerfectShape::CubicBezierCurve]
      
      _(shape.to_path_shapes[0].x).must_equal 500.0
      _(shape.to_path_shapes[0].y).must_equal 350.0
      
      _(shape.to_path_shapes[1].points[0][0].to_i).must_equal 500
      _(shape.to_path_shapes[1].points[0][1].to_i).must_equal 336
      _(shape.to_path_shapes[1].points[1][0].to_i).must_equal 489
      _(shape.to_path_shapes[1].points[1][1].to_i).must_equal 324
      _(shape.to_path_shapes[1].points[2][0].to_i).must_equal 470
      _(shape.to_path_shapes[1].points[2][1].to_i).must_equal 314
    end
    
    it 'returns path shapes as an open type arc that has a start and extent of 0 (angle of 0)' do
      shape = PerfectShape::Arc.new(type: :open, x: 300, y: 400, width: 200, height: 100, start: 0, extent: 0)
      
      _(shape.to_path_shapes.count).must_equal 1
      _(shape.to_path_shapes.map(&:class)).must_equal [PerfectShape::Point]
      
      _(shape.to_path_shapes[0].x).must_equal 500.0
      _(shape.to_path_shapes[0].y).must_equal 350.0
    end
  end
end
