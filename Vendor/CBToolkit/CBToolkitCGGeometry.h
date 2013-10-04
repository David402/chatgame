//
//  CBCGGeometry.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <UIKit/UIKit.h>
#import <math.h>

extern CGFloat CGDistanceBetweenPoints(CGPoint point1, CGPoint point2);

#pragma mark - Utility macros
//==============================================================================

#pragma mark - CGAffineTransform
const CGAffineTransform CGAffineTransformInvalid;
extern BOOL CGAffineTransformIsInvalid(CGAffineTransform t);
#define CGAffineTransformConcat3(a, b, c)       CGAffineTransformConcat(CGAffineTransformConcat(a,b), c)

#define CGAffineTransformCalculateScale(t)          sqrt(t.a * t.a + t.b * t.b)
#define CGAffineTransformCalculateRotation(t)       atan2(t.b, t.a)
#define CGAffineTransformCalculateTranslation(t)    CGPointMake(t.tx, t.ty)

//==============================================================================

#pragma mark - CGSize
extern CGSize CGSizeScale(CGSize size, CGFloat scale);
extern CGSize CGSizeScaleBySize(CGSize size, CGSize scaleSize);
extern CGFloat CGSizeToArea(CGSize size);
#define CGSizeGetArea(size)             (size.width * size.height)
#define CGSizeMaxDimension(size)        MAX(size.width, size.height)

//==============================================================================

#pragma mark - CGPoint

#define CGPOINT_UNDEFINED               (CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX))

#define CGPointInvalid                  CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)
#define CGPointIsInvalid(p)             CGPointEqualToPoint(p, CGPointInvalid)

extern CGPoint CGPointAdd(CGPoint p1, CGPoint p2);
extern CGPoint CGPointSubtract(CGPoint p1, CGPoint p2);
extern CGPoint CGPointScale(CGPoint p, CGFloat scale);
extern CGPoint CGPointScaleXY(CGPoint p, CGFloat scaleX, CGFloat scaleY);
extern NSUInteger CGPointHash(CGPoint p);

//==============================================================================

#pragma mark - CGRect

#define CGRectMakeSized(x, y, size)     CGRectMake(x, y, (size).width, (size).height)
#define CGRectModify(rect, offsetRect)  { \
    CGRect _rect = rect; \
    _rect = CGRectMake(_rect.origin.x + offsetRect.origin.x, \
                       _rect.origin.y + offsetRect.origin.y, \
                       _rect.size.width + offsetRect.size.width, \
                       _rect.size.height + offsetRect.size.height); \
    rect = _rect; };

extern CGRect CGRectTranslate(CGRect rect, CGPoint translation);
extern CGRect CGRectDenormalize(CGRect rect, CGRect normalRect);
extern CGRect CGRectScaleToSize(CGRect rect, CGSize);
extern CGRect CGRectApplyAffineTransformAboutPoint(CGRect rect,
                                                   CGAffineTransform transform,
                                                   CGPoint point);
extern CGRect CGRectCopyWithOriginX(CGRect rect, CGFloat x);
extern CGRect CGRectCopyWithOriginY(CGRect rect, CGFloat y);
extern CGRect CGRectCopyWithWidth(CGRect rect, CGFloat width);
extern CGRect CGRectCopyWithHeight(CGRect rect, CGFloat height);

//==============================================================================
