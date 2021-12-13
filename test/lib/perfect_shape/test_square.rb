require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Square do
    it 'constructs with dimensions' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)

      _(square.y).must_equal 3
      _(square.y).must_equal 3
      _(square.length).must_equal 50
      _(square.width).must_equal 50
      _(square.height).must_equal 50
      
      square = PerfectShape::Square.new(x: 2, y: 3, width: 50)

      _(square.y).must_equal 3
      _(square.y).must_equal 3
      _(square.length).must_equal 50
      _(square.width).must_equal 50
      _(square.height).must_equal 50
      
      square = PerfectShape::Square.new(x: 2, y: 3, height: 50)

      _(square.y).must_equal 3
      _(square.y).must_equal 3
      _(square.length).must_equal 50
      _(square.width).must_equal 50
      _(square.height).must_equal 50
      
      square = PerfectShape::Square.new(x: 2, y: 3, width: 50, height: 50)

      _(square.y).must_equal 3
      _(square.y).must_equal 3
      _(square.length).must_equal 50
      _(square.width).must_equal 50
      _(square.height).must_equal 50
    end
    
    it 'fails to construct with width, height, and length not equal' do
      proc { PerfectShape::Square.new(x: 2, y: 3, width: 30, height: 50) }.must_raise StandardError
      proc { PerfectShape::Square.new(x: 2, y: 3, length: 25, width: 50) }.must_raise StandardError
      proc { PerfectShape::Square.new(x: 2, y: 3, length: 25, height: 50) }.must_raise StandardError
      proc { PerfectShape::Square.new(x: 2, y: 3, length: 25, width: 50, height: 50) }.must_raise StandardError
    end
    
    it 'constructs with defaults' do
      square = PerfectShape::Square.new

      _(square.y).must_equal 0
      _(square.y).must_equal 0
      _(square.length).must_equal 1
      _(square.width).must_equal 1
      _(square.height).must_equal 1
    end

    it 'updates attributes' do
      square = PerfectShape::Square.new
      square.x = 2
      square.y = 3
      square.length = 50

      _(square.x).must_equal 2
      _(square.y).must_equal 3
      _(square.length).must_equal 50
      _(square.width).must_equal 50
      _(square.height).must_equal 50
      
      square.width = 40
      
      _(square.x).must_equal 2
      _(square.y).must_equal 3
      _(square.length).must_equal 40
      _(square.width).must_equal 40
      _(square.height).must_equal 40
      
      square.height = 30
      _(square.x).must_equal 2
      _(square.y).must_equal 3
      _(square.length).must_equal 30
      _(square.width).must_equal 30
      _(square.height).must_equal 30
    end

    it 'contains point at the top-left corner' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2, 3]

      _(square).must_be :contain?, point
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'contains point at the top-right corner' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 + 50, 3]

      _(square).must_be :contain?, point
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'contains point at the bottom-left corner' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2, 3 + 50]

      _(square).must_be :contain?, point
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'contains point at the bottom-right corner' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 + 50, 3 + 50]

      _(square).must_be :contain?, point
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'contains point at the top side' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 + 25, 3]

      _(square).must_be :contain?, point
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'contains point at the left side' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2, 3 + 25]

      _(square).must_be :contain?, point
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'contains point at the right side' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 + 50, 3 + 25]

      _(square).must_be :contain?, point
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'contains point at the bottom side' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 + 25, 3 + 50]

      _(square).must_be :contain?, point
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'contains point inside square' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 + 25, 3 + 25]

      _(square).must_be :contain?, point
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'does not contain point to the top-left of the square' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 - 1, 3 - 1]

      _(square.contain?(point)).must_equal false
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'does not contain point to the top of the square' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 + 25, 3 - 1]

      _(square.contain?(point)).must_equal false
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'does not contain point to the top-right of the square' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 + 50 + 1, 3 - 1]

      _(square.contain?(point)).must_equal false
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'does not contain point to the right of the square' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 + 50 + 1, 3 + 25]

      _(square.contain?(point)).must_equal false
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'does not contain point to the bottom-right of the square' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 + 50 + 1, 3 + 25 + 1]

      _(square.contain?(point)).must_equal false
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'does not contain point to the bottom of the square' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 + 25, 3 + 50 + 1]

      _(square.contain?(point)).must_equal false
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'does not contain point to the bottom-left of the square' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 - 1, 3 + 50 + 1]

      _(square.contain?(point)).must_equal false
      _(square.contain?(*point)).must_equal square.contain?(point)
    end

    it 'does not contain point to the left of the square' do
      square = PerfectShape::Square.new(x: 2, y: 3, length: 50)
      point = [2 - 1, 3 + 25]

      _(square.contain?(point)).must_equal false
      _(square.contain?(*point)).must_equal square.contain?(point)
    end
  end
end
