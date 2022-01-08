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
  end
end
