require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Math do
    describe '#ieee754_remainder' do
      it 'returns a negative number rounding ceiling' do
        result = PerfectShape::Math.ieee754_remainder(7.5, 4.5)
        
        _(result).must_equal -1.5
      end
      
      it 'returns a positive number rounding floor' do
        result = PerfectShape::Math.ieee754_remainder(7.5, 3.5)
        
        _(result).must_equal 0.5
      end
      
      it 'returns a positive number rounding halfway to floor even number' do
        result = PerfectShape::Math.ieee754_remainder(5, 10)
        
        _(result).must_equal 5
      end
      
      it 'returns a negative number rounding halfway to ceiling even number' do
        result = PerfectShape::Math.ieee754_remainder(15, 10)
        
        _(result).must_equal -5
      end
      
      it 'returns NaN for x=NaN' do
        result = PerfectShape::Math.ieee754_remainder(Float::NAN, 10)

        _(result).must_be :nan?
      end
      
      it 'returns NaN for x=Infinity' do
        result = PerfectShape::Math.ieee754_remainder(Float::INFINITY, 10)

        _(result).must_be :nan?
      end
      
      it 'returns NaN for y=NaN' do
        result = PerfectShape::Math.ieee754_remainder(10, Float::NAN)

        _(result).must_be :nan?
      end
      
      it 'returns NaN for y=0' do
        result = PerfectShape::Math.ieee754_remainder(10, 0)

        _(result).must_be :nan?
      end
      
      it 'returns NaN for y=+0.0' do
        result = PerfectShape::Math.ieee754_remainder(10, 0.0)

        _(result).must_be :nan?
      end
      
      it 'returns NaN for y=-0.0' do
        result = PerfectShape::Math.ieee754_remainder(10, -0.0)

        _(result).must_be :nan?
      end
      
      it 'returns x for y=Infinity' do
        result = PerfectShape::Math.ieee754_remainder(10, Float::INFINITY)

        _(result).must_equal 10
      end
    end
  end
end
