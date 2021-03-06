require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::AffineTransform do
    it 'constructs with (x,y)-operation-named kwargs' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)

      _(affine_transform.xxp).must_equal xxp
      _(affine_transform.xxp).must_be_instance_of BigDecimal
      _(affine_transform.xyp).must_equal xyp
      _(affine_transform.xyp).must_be_instance_of BigDecimal
      _(affine_transform.yxp).must_equal yxp
      _(affine_transform.yxp).must_be_instance_of BigDecimal
      _(affine_transform.yyp).must_equal yyp
      _(affine_transform.yyp).must_be_instance_of BigDecimal
      _(affine_transform.xt).must_equal xt
      _(affine_transform.xt).must_be_instance_of BigDecimal
      _(affine_transform.yt).must_equal yt
      _(affine_transform.yt).must_be_instance_of BigDecimal
      _(affine_transform.m11).must_equal xxp
      _(affine_transform.m11).must_be_instance_of BigDecimal
      _(affine_transform.m12).must_equal xyp
      _(affine_transform.m12).must_be_instance_of BigDecimal
      _(affine_transform.m21).must_equal yxp
      _(affine_transform.m21).must_be_instance_of BigDecimal
      _(affine_transform.m22).must_equal yyp
      _(affine_transform.m22).must_be_instance_of BigDecimal
      _(affine_transform.m13).must_equal xt
      _(affine_transform.m13).must_be_instance_of BigDecimal
      _(affine_transform.m23).must_equal yt
      _(affine_transform.m23).must_be_instance_of BigDecimal
    end
    
    it 'constructs with matrix element kwargs' do
      m11 = 2
      m12 = 3
      m21 = 4
      m22 = 5
      m13 = 6
      m23 = 7
      affine_transform = PerfectShape::AffineTransform.new(m11: m11, m12: m12, m21: m21, m22: m22, m13: m13, m23: m23)

      _(affine_transform.m11).must_equal m11
      _(affine_transform.m12).must_equal m12
      _(affine_transform.m21).must_equal m21
      _(affine_transform.m22).must_equal m22
      _(affine_transform.m13).must_equal m13
      _(affine_transform.m23).must_equal m23
      _(affine_transform.xxp).must_equal m11
      _(affine_transform.xyp).must_equal m12
      _(affine_transform.yxp).must_equal m21
      _(affine_transform.yyp).must_equal m22
      _(affine_transform.xt).must_equal m13
      _(affine_transform.yt).must_equal m23
    end
    
    it 'constructs with standard args' do
      m11 = 2
      m12 = 3
      m21 = 4
      m22 = 5
      m13 = 6
      m23 = 7
      affine_transform = PerfectShape::AffineTransform.new(m11, m12, m21, m22, m13, m23)

      _(affine_transform.m11).must_equal m11
      _(affine_transform.m12).must_equal m12
      _(affine_transform.m21).must_equal m21
      _(affine_transform.m22).must_equal m22
      _(affine_transform.m13).must_equal m13
      _(affine_transform.m23).must_equal m23
      _(affine_transform.xxp).must_equal m11
      _(affine_transform.xyp).must_equal m12
      _(affine_transform.yxp).must_equal m21
      _(affine_transform.yyp).must_equal m22
      _(affine_transform.xt).must_equal m13
      _(affine_transform.yt).must_equal m23
    end
    
    it 'constructs with defaults as identity matrix' do
      affine_transform = PerfectShape::AffineTransform.new

      _(affine_transform.m11).must_equal 1
      _(affine_transform.m12).must_equal 0
      _(affine_transform.m21).must_equal 0
      _(affine_transform.m22).must_equal 1
      _(affine_transform.m13).must_equal 0
      _(affine_transform.m23).must_equal 0
      _(affine_transform.xxp).must_equal 1
      _(affine_transform.xyp).must_equal 0
      _(affine_transform.yxp).must_equal 0
      _(affine_transform.yyp).must_equal 1
      _(affine_transform.xt).must_equal 0
      _(affine_transform.yt).must_equal 0
    end
    
    it 'updates attributes with (x,y)-operation names' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new
      affine_transform.xxp = xxp
      affine_transform.xyp = xyp
      affine_transform.yxp = yxp
      affine_transform.yyp = yyp
      affine_transform.xt = xt
      affine_transform.yt = yt

      _(affine_transform.xxp).must_equal xxp
      _(affine_transform.xyp).must_equal xyp
      _(affine_transform.yxp).must_equal yxp
      _(affine_transform.yyp).must_equal yyp
      _(affine_transform.xt).must_equal xt
      _(affine_transform.yt).must_equal yt
      _(affine_transform.m11).must_equal xxp
      _(affine_transform.m12).must_equal xyp
      _(affine_transform.m21).must_equal yxp
      _(affine_transform.m22).must_equal yyp
      _(affine_transform.m13).must_equal xt
      _(affine_transform.m23).must_equal yt
    end
    
    it 'updates attributes with traditional matrix element names' do
      m11 = 2
      m12 = 3
      m21 = 4
      m22 = 5
      m13 = 6
      m23 = 7
      affine_transform = PerfectShape::AffineTransform.new
      affine_transform.m11 = m11
      affine_transform.m12 = m12
      affine_transform.m21 = m21
      affine_transform.m22 = m22
      affine_transform.m13 = m13
      affine_transform.m23 = m23

      _(affine_transform.m11).must_equal m11
      _(affine_transform.m12).must_equal m12
      _(affine_transform.m21).must_equal m21
      _(affine_transform.m22).must_equal m22
      _(affine_transform.m13).must_equal m13
      _(affine_transform.m23).must_equal m23
      _(affine_transform.xxp).must_equal m11
      _(affine_transform.xyp).must_equal m12
      _(affine_transform.yxp).must_equal m21
      _(affine_transform.yyp).must_equal m22
      _(affine_transform.xt).must_equal m13
      _(affine_transform.yt).must_equal m23
    end
    
    it 'equals another AffineTransform' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform1 = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      affine_transform1b = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      affine_transform2 = PerfectShape::AffineTransform.new(m11: xxp, m12: xyp, m21: yxp, m22: yyp, m13: xt, m23: yt)
      affine_transform3 = PerfectShape::AffineTransform.new(xxp, xyp, yxp, yyp, xt, yt)
    
      _(affine_transform1b).must_equal affine_transform1
      _(affine_transform2).must_equal affine_transform1
      _(affine_transform3).must_equal affine_transform1
    end
     
    it 'does not equal a different AffineTransform' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform1 = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      affine_transform2 = PerfectShape::AffineTransform.new(xxp: xxp + 1, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      affine_transform3 = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp + 1, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      affine_transform4 = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp + 1, yyp: yyp, xt: xt, yt: yt)
      affine_transform5 = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp + 1, xt: xt, yt: yt)
      affine_transform6 = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt + 1, yt: yt)
      affine_transform7 = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt + 1)
      
      _(affine_transform2).wont_equal affine_transform1
      _(affine_transform3).wont_equal affine_transform1
      _(affine_transform4).wont_equal affine_transform1
      _(affine_transform5).wont_equal affine_transform1
      _(affine_transform6).wont_equal affine_transform1
      _(affine_transform7).wont_equal affine_transform1
    end
    
    it 'transforms a point as [x,y] pair Array returning as [x,y] pair Array' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      
      _(affine_transform.transform_point([1, 8])).must_equal [2*1 + 3*8 + 6, 4*1 + 5*8 + 7]
    end
    
    it 'transforms a point as x,y arguments returning as [x,y] pair Array' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      
      _(affine_transform.transform_point(1, 8)).must_equal [2*1 + 3*8 + 6, 4*1 + 5*8 + 7]
    end
    
    it 'transforms points as [x,y] pair Arrays returning as [x,y] pair Arrays' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      
      _(affine_transform.transform_points([[1, 8], [2, 9]])).must_equal [[2*1 + 3*8 + 6, 4*1 + 5*8 + 7], [2*2 + 3*9 + 6, 4*2 + 5*9 + 7]]
    end
    
    it 'transforms points as a flattened Array of alternating [x,y] coordinates returning as [x,y] pair Arrays' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      
      _(affine_transform.transform_points([1, 8, 2, 9])).must_equal [[2*1 + 3*8 + 6, 4*1 + 5*8 + 7], [2*2 + 3*9 + 6, 4*2 + 5*9 + 7]]
    end
    
    it 'transforms points as flattened alternating x,y coordinate arguments returning as [x,y] pair Arrays' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      
      _(affine_transform.transform_points(1, 8, 2, 9)).must_equal [[2*1 + 3*8 + 6, 4*1 + 5*8 + 7], [2*2 + 3*9 + 6, 4*2 + 5*9 + 7]]
    end
    
    it 'inverse transforms a point as [x,y] pair Array returning as [x,y] pair Array' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)

      _(affine_transform.inverse_transform_point([2*1 + 3*8 + 6, 4*1 + 5*8 + 7])).must_equal [1, 8]
    end

    it 'inverse transforms a point as x,y arguments returning as [x,y] pair Array' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)

      _(affine_transform.inverse_transform_point(2*1 + 3*8 + 6, 4*1 + 5*8 + 7)).must_equal [1, 8]
    end

    it 'inverse transforms points as [x,y] pair Arrays returning as [x,y] pair Arrays' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)

      _(affine_transform.inverse_transform_points([[2*1 + 3*8 + 6, 4*1 + 5*8 + 7], [2*2 + 3*9 + 6, 4*2 + 5*9 + 7]])).must_equal [[1, 8], [2, 9]]
    end

    it 'inverse transforms points as a flattened Array of alternating [x,y] coordinates returning as [x,y] pair Arrays' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)

      _(affine_transform.inverse_transform_points([2*1 + 3*8 + 6, 4*1 + 5*8 + 7, 2*2 + 3*9 + 6, 4*2 + 5*9 + 7])).must_equal [[1, 8], [2, 9]]
    end

    it 'inverse transforms points as flattened alternating x,y coordinate arguments returning as [x,y] pair Arrays' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)

      _(affine_transform.inverse_transform_points(2*1 + 3*8 + 6, 4*1 + 5*8 + 7, 2*2 + 3*9 + 6, 4*2 + 5*9 + 7)).must_equal [[1, 8], [2, 9]]
    end
    
    it 'resets to identity matrix' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      return_value = affine_transform.identity!
      
      _(return_value).must_equal affine_transform
      _(affine_transform.m11).must_equal 1
      _(affine_transform.m12).must_equal 0
      _(affine_transform.m21).must_equal 0
      _(affine_transform.m22).must_equal 1
      _(affine_transform.m13).must_equal 0
      _(affine_transform.m23).must_equal 0
      _(affine_transform.xxp).must_equal 1
      _(affine_transform.xyp).must_equal 0
      _(affine_transform.yxp).must_equal 0
      _(affine_transform.yyp).must_equal 1
      _(affine_transform.xt).must_equal 0
      _(affine_transform.yt).must_equal 0
    end
    
    it 'resets to identity matrix' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 3 # point x coordinate y product (m12)
      yxp = 4 # point y coordinate x product (m21)
      yyp = 5 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 7 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      return_value = affine_transform.reset!
      
      _(return_value).must_equal affine_transform
      _(affine_transform.m11).must_equal 1
      _(affine_transform.m12).must_equal 0
      _(affine_transform.m21).must_equal 0
      _(affine_transform.m22).must_equal 1
      _(affine_transform.m13).must_equal 0
      _(affine_transform.m23).must_equal 0
      _(affine_transform.xxp).must_equal 1
      _(affine_transform.xyp).must_equal 0
      _(affine_transform.yxp).must_equal 0
      _(affine_transform.yyp).must_equal 1
      _(affine_transform.xt).must_equal 0
      _(affine_transform.yt).must_equal 0
    end
    
    it 'inverts affine transform with invertible matrix ' do
      xxp = -1 # point x coordinate x product (m11)
      xyp = 1.5 # point x coordinate y product (m12)
      yxp = 1 # point y coordinate x product (m21)
      yyp = -1 # point y coordinate y product (m22)
      xt = 0 # point x coordinate translation (m13)
      yt = 0 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      
      assert affine_transform.invertible?
      
      return_value = affine_transform.invert!
      
      _(return_value).must_equal affine_transform
      _(affine_transform.xxp).must_equal 2
      _(affine_transform.xyp).must_equal 3
      _(affine_transform.yxp).must_equal 2
      _(affine_transform.yyp).must_equal 2
      _(affine_transform.xt).must_equal 0
      _(affine_transform.yt).must_equal 0
    end
    
    it 'cannot invert affine transform with non-invertible matrix ' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 4 # point x coordinate y product (m12)
      yxp = 2 # point y coordinate x product (m21)
      yyp = 4 # point y coordinate y product (m22)
      xt = 0 # point x coordinate translation (m13)
      yt = 0 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      
      refute affine_transform.invertible?
      _(proc {affine_transform.invert!}).must_raise StandardError
    end
    
    it 'multiplies affine transform with another' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 0 # point x coordinate y product (m12)
      yxp = 0 # point y coordinate x product (m21)
      yyp = 4 # point y coordinate y product (m22)
      xt = 0 # point x coordinate translation (m13)
      yt = 0 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
    
      xxp = 1 # point x coordinate x product (m11)
      xyp = 0 # point x coordinate y product (m12)
      yxp = 0 # point y coordinate x product (m21)
      yyp = 1 # point y coordinate y product (m22)
      xt = 30 # point x coordinate translation (m13)
      yt = -90 # point y coordinate translation (m23)
      affine_transform2 = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
    
      return_value = affine_transform.multiply!(affine_transform2)
      
      _(return_value).must_equal affine_transform
      _(affine_transform.xxp).must_equal 2
      _(affine_transform.xyp).must_equal 0
      _(affine_transform.yxp).must_equal 0
      _(affine_transform.yyp).must_equal 4
      _(affine_transform.xt).must_equal 60
      _(affine_transform.yt).must_equal (-360)
    end
    
    it 'translates affine transform by (x,y) pair Array point' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 0 # point x coordinate y product (m12)
      yxp = 0 # point y coordinate x product (m21)
      yyp = 4 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 24 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
    
      return_value = affine_transform.translate!([14, 6])
      
      _(return_value).must_equal affine_transform
      _(affine_transform.xxp).must_equal 2
      _(affine_transform.xyp).must_equal 0
      _(affine_transform.yxp).must_equal 0
      _(affine_transform.yyp).must_equal 4
      _(affine_transform.xt).must_equal 34
      _(affine_transform.yt).must_equal 48
    end
    
    it 'translates affine transform by (x,y) args' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 0 # point x coordinate y product (m12)
      yxp = 0 # point y coordinate x product (m21)
      yyp = 4 # point y coordinate y product (m22)
      xt = 6 # point x coordinate translation (m13)
      yt = 24 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
    
      return_value = affine_transform.translate!(14, 6)
      
      _(return_value).must_equal affine_transform
      _(affine_transform.xxp).must_equal 2
      _(affine_transform.xyp).must_equal 0
      _(affine_transform.yxp).must_equal 0
      _(affine_transform.yyp).must_equal 4
      _(affine_transform.xt).must_equal 34
      _(affine_transform.yt).must_equal 48
    end
    
    it 'scales affine transform by (x,y) pair Array point' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 0 # point x coordinate y product (m12)
      yxp = 0 # point y coordinate x product (m21)
      yyp = 4 # point y coordinate y product (m22)
      xt = 34 # point x coordinate translation (m13)
      yt = 48 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
    
      return_value = affine_transform.scale!([3, 2])
      
      _(return_value).must_equal affine_transform
      _(affine_transform.xxp).must_equal 6
      _(affine_transform.xyp).must_equal 0
      _(affine_transform.yxp).must_equal 0
      _(affine_transform.yyp).must_equal 8
      _(affine_transform.xt).must_equal 34
      _(affine_transform.yt).must_equal 48
    end
    
    it 'scales affine transform by (x,y) args' do
      xxp = 2 # point x coordinate x product (m11)
      xyp = 0 # point x coordinate y product (m12)
      yxp = 0 # point y coordinate x product (m21)
      yyp = 4 # point y coordinate y product (m22)
      xt = 34 # point x coordinate translation (m13)
      yt = 48 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
    
      return_value = affine_transform.scale!(3, 2)
      
      _(return_value).must_equal affine_transform
      _(affine_transform.xxp).must_equal 6
      _(affine_transform.xyp).must_equal 0
      _(affine_transform.yxp).must_equal 0
      _(affine_transform.yyp).must_equal 8
      _(affine_transform.xt).must_equal 34
      _(affine_transform.yt).must_equal 48
    end

    it 'rotates affine transform by angle in degrees counter-clockwise' do
      xxp = 6 # point x coordinate x product (m11)
      xyp = 0 # point x coordinate y product (m12)
      yxp = 0 # point y coordinate x product (m21)
      yyp = 8 # point y coordinate y product (m22)
      xt = 34 # point x coordinate translation (m13)
      yt = 48 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)

      return_value = affine_transform.rotate!(90)

      _(return_value).must_equal affine_transform
      _(affine_transform.xxp - BigDecimal('0.36739403974420596e-15')).must_be :<=, 0.00001
      _(affine_transform.xyp).must_equal BigDecimal('-6.0')
      _(affine_transform.yxp).must_equal BigDecimal('8.0')
      _(affine_transform.yyp - BigDecimal('0.48985871965894128e-15')).must_be :<=, 0.00001
      _(affine_transform.xt).must_equal 34
      _(affine_transform.yt).must_equal 48
    end

    it 'shears affine transform by (x,y) pair Array' do
      xxp = 6 # point x coordinate x product (m11)
      xyp = 0 # point x coordinate y product (m12)
      yxp = 0 # point y coordinate x product (m21)
      yyp = 8 # point y coordinate y product (m22)
      xt = 34 # point x coordinate translation (m13)
      yt = 48 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)

      return_value = affine_transform.shear!([2, 3])

      _(return_value).must_equal affine_transform
      _(affine_transform.xxp).must_equal 42
      _(affine_transform.xyp).must_equal 12
      _(affine_transform.yxp).must_equal 24
      _(affine_transform.yyp).must_equal 8
      _(affine_transform.xt).must_equal 34
      _(affine_transform.yt).must_equal 48
    end

    it 'shears affine transform by (x,y) args' do
      xxp = 6 # point x coordinate x product (m11)
      xyp = 0 # point x coordinate y product (m12)
      yxp = 0 # point y coordinate x product (m21)
      yyp = 8 # point y coordinate y product (m22)
      xt = 34 # point x coordinate translation (m13)
      yt = 48 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)

      return_value = affine_transform.shear!(2, 3)

      _(return_value).must_equal affine_transform
      _(affine_transform.xxp).must_equal 42
      _(affine_transform.xyp).must_equal 12
      _(affine_transform.yxp).must_equal 24
      _(affine_transform.yyp).must_equal 8
      _(affine_transform.xt).must_equal 34
      _(affine_transform.yt).must_equal 48
    end

    it 'skews (alias to shear) affine transform by (x,y) args' do
      xxp = 6 # point x coordinate x product (m11)
      xyp = 0 # point x coordinate y product (m12)
      yxp = 0 # point y coordinate x product (m21)
      yyp = 8 # point y coordinate y product (m22)
      xt = 34 # point x coordinate translation (m13)
      yt = 48 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)

      return_value = affine_transform.skew!(2, 3)

      _(return_value).must_equal affine_transform
      _(affine_transform.xxp).must_equal 42
      _(affine_transform.xyp).must_equal 12
      _(affine_transform.yxp).must_equal 24
      _(affine_transform.yyp).must_equal 8
      _(affine_transform.xt).must_equal 34
      _(affine_transform.yt).must_equal 48
    end
    
    it 'clones affine transform' do
      xxp = 6 # point x coordinate x product (m11)
      xyp = 0 # point x coordinate y product (m12)
      yxp = 0 # point y coordinate x product (m21)
      yyp = 8 # point y coordinate y product (m22)
      xt = 34 # point x coordinate translation (m13)
      yt = 48 # point y coordinate translation (m23)
      affine_transform = PerfectShape::AffineTransform.new(xxp: xxp, xyp: xyp, yxp: yxp, yyp: yyp, xt: xt, yt: yt)
      affine_transform2 = affine_transform.clone
      
      _(affine_transform2).must_equal(affine_transform)
      refute affine_transform2.equal?(affine_transform)
    end
  end
end
