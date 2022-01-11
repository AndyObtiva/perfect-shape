require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Ellipse do
    it 'constructs with dimensions (x,y,width,height)' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 50, height: 60)

      _(shape.type).must_equal :open
      _(shape.start).must_equal 0
      _(shape.extent).must_equal 360
      _(shape.x).must_equal 2
      _(shape.y).must_equal 3
      _(shape.width).must_equal 50
      _(shape.height).must_equal 60
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

    it 'constructs with alternate dimensions (center_x, center_y, radius_x, radius_y)' do
      shape = PerfectShape::Ellipse.new(center_x: 2 + 25, center_y: 3 + 30, radius_x: 25, radius_y: 30)

      _(shape.type).must_equal :open
      _(shape.start).must_equal 0
      _(shape.extent).must_equal 360
      _(shape.x).must_equal 2
      _(shape.y).must_equal 3
      _(shape.width).must_equal 50
      _(shape.height).must_equal 60
      _(shape.center_x).must_equal 2 + 25
      _(shape.center_y).must_equal 3 + 30
      _(shape.radius_x).must_equal 25
      _(shape.radius_y).must_equal 30
    end

    it 'constructs with defaults' do
      shape = PerfectShape::Ellipse.new

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
      shape = PerfectShape::Ellipse.new
      shape.x = 2
      shape.y = 3
      shape.width = 50
      shape.height = 60

      _(shape.type).must_equal :open
      _(shape.start).must_equal 0
      _(shape.extent).must_equal 360
      _(shape.x).must_equal 2
      _(shape.y).must_equal 3
      _(shape.width).must_equal 50
      _(shape.height).must_equal 60
      _(shape.center_x).must_equal 2 + 25
      _(shape.center_y).must_equal 3 + 30
      _(shape.radius_x).must_equal 25
      _(shape.radius_y).must_equal 30
    end

    it 'raises error for attempting to update type, start, or extent' do
      shape = PerfectShape::Ellipse.new
      _(proc { shape.type = :chord }).must_raise StandardError
      _(proc { shape.start = 30 }).must_raise StandardError
      _(proc { shape.extent = 45 }).must_raise StandardError
    end

    it 'updates attributes with alternate dimensions (center_x,center_y,radius_x,radius_y)' do
      shape = PerfectShape::Ellipse.new
      shape.center_x = 2 + 25
      shape.center_y = 3 + 30
      shape.radius_x = 25
      shape.radius_y = 30

      _(shape.type).must_equal :open
      _(shape.start).must_equal 0
      _(shape.extent).must_equal 360
      _(shape.x).must_equal 2
      _(shape.y).must_equal 3
      _(shape.width).must_equal 50
      _(shape.height).must_equal 60
      _(shape.center_x).must_equal 2 + 25
      _(shape.center_y).must_equal 3 + 30
      _(shape.radius_x).must_equal 25
      _(shape.radius_y).must_equal 30
    end

    it 'contains point in center' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 60, height: 40)
      point = [shape.center_x, shape.center_y]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point in center on outline' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 60, height: 40)
      point = [shape.center_x, shape.center_y]

      refute shape.contain?(point, outline: true)
    end

    it 'contains point on left side on outline' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 60, height: 40)
      point = [2, shape.center_y]

      assert shape.contain?(point, outline: true)
    end

    it 'does not contain point outside the left side on outline' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 60, height: 40)
      point = [2 - 1, shape.center_y]

      refute shape.contain?(point, outline: true)
    end

    it 'contains point on left side on outline with distance tolerance' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 60, height: 40)
      point = [2 - 1, shape.center_y]

      assert shape.contain?(point, outline: true, distance_tolerance: 1)
    end

    it 'contains point near left' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 60, height: 40)
      point = [shape.x + shape.width * 1.0 / 4.0, shape.y + (shape.height * 2.0 / 4.0)]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near right' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 60, height: 40)
      point = [shape.x + shape.width * 3.0 / 4.0, shape.y + (shape.height * 2.0 / 4.0)]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near top-right' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 60, height: 40)
      point = [shape.x + shape.width * 3.0 / 4.0, shape.y + (shape.height * 1.0 / 4.0)]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near top' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 60, height: 40)
      point = [shape.x + shape.width * 2.0 / 4.0, shape.y + (shape.height * 1.0 / 4.0)]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near top-left' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 60, height: 40)
      point = [shape.x + shape.width * 1.0 / 4.0, shape.y + (shape.height * 1.0 / 4.0)]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near bottom-right' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 60, height: 40)
      point = [shape.x + shape.width * 3.0 / 4.0, shape.y + (shape.height * 3.0 / 4.0)]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near bottom' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 60, height: 40)
      point = [shape.x + shape.width * 2.0 / 4.0, shape.y + (shape.height * 3.0 / 4.0)]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near bottom-left' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 60, height: 40)
      point = [shape.x + shape.width * 1.0 / 4.0, shape.y + (shape.height * 3.0 / 4.0)]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point near top-right within bounding box' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 67, height: 46)
      point = [shape.x + shape.width*(3.9/4.0), shape.y + (shape.height * 1.0 / 4.0)]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point near bottom-right within bounding box' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 67, height: 46)
      point = [shape.x + shape.width*(3.9/4.0), shape.y + (shape.height * 3.0 / 4.0)]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point near top-left within bounding box' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 67, height: 46)
      point = [shape.x + shape.width*(0.1/4.0), shape.y + (shape.height * 1.0 / 4.0)]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point near bottom-left within bounding box' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 67, height: 46)
      point = [shape.x + shape.width*(0.1/4.0), shape.y + (shape.height * 3.0 / 4.0)]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point outside of bounding box' do
      shape = PerfectShape::Ellipse.new(x: 2, y: 3, width: 67, height: 46)
      point = [0, 0]

      _(shape.contain?(point)).must_equal false
    end

  end
end
