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
  end
end
