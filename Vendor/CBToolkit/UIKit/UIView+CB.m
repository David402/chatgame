//
//  UIView+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <QuartzCore/QuartzCore.h>
#import "CBToolkitCGGeometry.h"

#import "UIView+CB.h"

@implementation UIView (CB)
- (CGSize)convertSize:(CGSize)size toView:(UIView *)refView
{
    CGPoint p0 = [self convertPoint:CGPointMake(0, 0)           toView:refView];
    CGPoint p1 = [self convertPoint:CGPointMake(size.width, 0)  toView:refView];
    CGPoint p2 = [self convertPoint:CGPointMake(0, size.height) toView:refView];
    
    return CGSizeMake(CGDistanceBetweenPoints(p0, p1),
                      CGDistanceBetweenPoints(p0, p2));
}

- (CGPoint)convertCenterToView:(UIView *)refView
{
    return [self.superview convertPoint:self.center toView:refView];
}

- (void)setBackgroundGradientFromColor:(UIColor *)color0 toColor:(UIColor *)color1
{
    CAGradientLayer *gradientLayer = [[[CAGradientLayer alloc] init] autorelease];
    [gradientLayer setFrame:[self bounds]];
    
    // Insert the layer at position zero to make sure the
    // text of the button is not obscured
    [[self layer] insertSublayer:gradientLayer atIndex:0];
    
    // Set the colors for the gradient to the
    // two colors specified for high and low
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[color0 CGColor],
                              (id)[color1 CGColor],
                              nil]];
}
@end