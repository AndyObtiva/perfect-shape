require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Arc do
    it 'constructs with chord type and dimensions' do
      arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50, height: 60, start: 30, extent: 90)

      _(arc.type).must_equal :chord
      _(arc.x).must_equal 2
      _(arc.y).must_equal 3
      _(arc.width).must_equal 50
      _(arc.height).must_equal 60
      _(arc.start).must_equal 30
      _(arc.extent).must_equal 90
    end

    it 'constructs with open type defaults' do
      arc = PerfectShape::Arc.new

      _(arc.type).must_equal :open
      _(arc.x).must_equal 0
      _(arc.y).must_equal 0
      _(arc.width).must_equal 1
      _(arc.height).must_equal 1
      _(arc.start).must_equal 0
      _(arc.extent).must_equal 360
    end

    it 'updates attributes' do
      arc = PerfectShape::Arc.new
      arc.type = :chord
      arc.x = 2
      arc.y = 3
      arc.width = 50
      arc.height = 60
      arc.start = 30
      arc.extent = 90

      _(arc.type).must_equal :chord
      _(arc.x).must_equal 2
      _(arc.y).must_equal 3
      _(arc.width).must_equal 50
      _(arc.height).must_equal 60
      _(arc.start).must_equal 30
      _(arc.extent).must_equal 90
    end

    it 'contains point with chord type circle' do
      arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [arc.x + arc.width / 2.0, arc.y + arc.height / 2.0]

      _(arc).must_be :contain?, point
      _(arc.contain?(*point)).must_equal arc.contain?(point)
    end

    it 'contains point with chord type arc' do
      arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [arc.x + arc.width*3/4.0, arc.y + (arc.height / 2.0)]

      _(arc).must_be :contain?, point
      _(arc.contain?(*point)).must_equal arc.contain?(point)
    end
    
    it 'does not contain point within bounding box with chord type arc' do
      arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 67, height: 46, start: 45, extent: 270)
      point = [arc.x + arc.width*(3.9/4.0), arc.y + (arc.height / 2.0)]
      
      _(arc.contain?(point)).must_equal false
    end
    
    it 'does not contain point in center of chord type arc' do
      arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      point = [arc.x + arc.width / 2.0, arc.y + arc.height / 2.0]

      _(arc.contain?(point)).must_equal false
    end

    it 'does not contain point within bounding box with chord type circle' do
      arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [3.0, 4.0]

      _(arc.contain?(point)).must_equal false
    end

    it 'does not contain point outside bounding box with chord type circle' do
      arc = PerfectShape::Arc.new(type: :chord, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [1.0, 2.0]

      _(arc.contain?(point)).must_equal false
    end

    it 'contains point with open type circle' do
      arc = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [arc.x + arc.width / 2.0, arc.y + arc.height / 2.0]

      _(arc).must_be :contain?, point
      _(arc.contain?(point)).must_equal arc.contain?(*point)
    end

    it 'contains point with open type arc' do
      arc = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 45, extent: 270)
      point = [arc.x + arc.width*3/4.0, arc.y + (arc.height / 2.0)]

      _(arc).must_be :contain?, point
      _(arc.contain?(point)).must_equal arc.contain?(*point)
    end

    it 'does not contain point within bounding box with open type arc' do
      arc = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 67, height: 46, start: 45, extent: 270)
      point = [arc.x + arc.width*(3.9/4.0), arc.y + (arc.height / 2.0)]

      _(arc.contain?(point)).must_equal false
    end

    it 'does not contain point in center of open type arc' do
      arc = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      point = [arc.x + arc.width / 2.0, arc.y + arc.height / 2.0]

      _(arc.contain?(point)).must_equal false
    end

    it 'does not contain point within bounding box with open type circle' do
      arc = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [3.0, 4.0]

      _(arc.contain?(point)).must_equal false
    end

    it 'does not contain point outside bounding box with open type circle' do
      arc = PerfectShape::Arc.new(type: :open, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [1.0, 2.0]

      _(arc.contain?(point)).must_equal false
    end

    it 'contains point with pie type circle' do
      arc = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [arc.x + arc.width / 2.0, arc.y + arc.height / 2.0]

      _(arc).must_be :contain?, point
      _(arc.contain?(point)).must_equal arc.contain?(*point)
    end

    it 'contains point in center of pie type arc' do
      arc = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      point = [arc.x + arc.width / 2.0, arc.y + arc.height / 2.0]

      _(arc).must_be :contain?, point
      _(arc.contain?(point)).must_equal arc.contain?(*point)
    end

    it 'contains point with pie type arc' do
      arc = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      point = [arc.x + arc.width / 2.0 + (arc.width / 4.0), arc.y + (arc.height / 2.0) - (arc.height / 4.0)]

      _(arc).must_be :contain?, point
      _(arc.contain?(point)).must_equal arc.contain?(*point)
    end

    it 'does not contain point within bounding box with pie type arc' do
      arc = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 145)
      point = [arc.x + (arc.width / 2.0) - (arc.width / 4.0), arc.y + arc.height / 2.0]

      _(arc.contain?(point)).must_equal false
    end

    it 'does not contain point within bounding box with pie type circle' do
      arc = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [3.0, 4.0]

      _(arc.contain?(point)).must_equal false
    end

    it 'does not contain point outside bounding box with pie type circle' do
      arc = PerfectShape::Arc.new(type: :pie, x: 2, y: 3, width: 50.5, height: 60.75, start: 0, extent: 360)
      point = [1.0, 2.0]

      _(arc.contain?(point)).must_equal false
    end
  end
end
