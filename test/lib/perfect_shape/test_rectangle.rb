require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Rectangle do
    it 'constructs with dimensions' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)

      _(rectangle.y).must_equal 3
      _(rectangle.y).must_equal 3
      _(rectangle.width).must_equal 50
      _(rectangle.height).must_equal 60
    end
    
    it 'constructs with defaults' do
      rectangle = PerfectShape::Rectangle.new

      _(rectangle.y).must_equal 0
      _(rectangle.y).must_equal 0
      _(rectangle.width).must_equal 1
      _(rectangle.height).must_equal 1
    end
    
    it 'updates attributes' do
      rectangle = PerfectShape::Rectangle.new
      rectangle.x = 2
      rectangle.y = 3
      rectangle.width = 50
      rectangle.height = 60

      _(rectangle.x).must_equal 2
      _(rectangle.y).must_equal 3
      _(rectangle.width).must_equal 50
      _(rectangle.height).must_equal 60
    end
    
    it 'contains point at the top-left corner' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2, 3]
      
      _(rectangle).must_be :contain?, point
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'contains point at the top-right corner' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50, 3]
      
      _(rectangle).must_be :contain?, point
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'contains point at the bottom-left corner' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2, 3 + 60]
      
      _(rectangle).must_be :contain?, point
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'contains point at the bottom-right corner' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50, 3 + 60]
      
      _(rectangle).must_be :contain?, point
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'contains point at the top side' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 25, 3]
      
      _(rectangle).must_be :contain?, point
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'contains point at the left side' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2, 3 + 30]
      
      _(rectangle).must_be :contain?, point
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'contains point at the right side' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50, 3 + 30]
      
      _(rectangle).must_be :contain?, point
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'contains point at the bottom side' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 25, 3 + 60]
      
      _(rectangle).must_be :contain?, point
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'contains point inside rectangle' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 25, 3 + 30]
      
      _(rectangle).must_be :contain?, point
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'does not contain point to the top-left of the rectangle' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 - 1, 3 - 1]
      
      _(rectangle.contain?(point)).must_equal false
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'does not contain point to the top of the rectangle' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 25, 3 - 1]
      
      _(rectangle.contain?(point)).must_equal false
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'does not contain point to the top-right of the rectangle' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50 + 1, 3 - 1]
      
      _(rectangle.contain?(point)).must_equal false
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'does not contain point to the right of the rectangle' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50 + 1, 3 + 30]
      
      _(rectangle.contain?(point)).must_equal false
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'does not contain point to the bottom-right of the rectangle' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50 + 1, 3 + 30 + 1]
      
      _(rectangle.contain?(point)).must_equal false
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'does not contain point to the bottom of the rectangle' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 25, 3 + 60 + 1]
      
      _(rectangle.contain?(point)).must_equal false
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'does not contain point to the bottom-left of the rectangle' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 - 1, 3 + 60 + 1]
      
      _(rectangle.contain?(point)).must_equal false
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
    
    it 'does not contain point to the left of the rectangle' do
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 - 1, 3 + 30]
      
      _(rectangle.contain?(point)).must_equal false
      _(rectangle.contain?(*point)).must_equal rectangle.contain?(point)
    end
  end
end
