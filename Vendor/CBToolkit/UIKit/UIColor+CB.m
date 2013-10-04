//
//  UIColor+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "CBToolKitHelper.h"
#import "UIColor+CB.h"

@implementation UIColor (CB)

- (CGFloat)alpha
{
    CGFloat alpha = 1;
    [self getRed:nil green:nil blue:nil alpha:&alpha];
    return alpha;
}

- (BOOL)isTransparent
{
    return [self alpha] < 1;
}

- (UIColor *)opaqueColor
{
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 1;
    if ([self getRed:&red green:&green blue:&blue alpha:&alpha]) {
        return [UIColor colorWithRed:red green:green blue:blue alpha:1];
    }
    return self; // If we can't get color RGBA components, just return a self.
                 // iOS5 crash when calling [self copy].
}

- (NSArray *)getRGBAArray
{
    const CGFloat *components = CGColorGetComponents([self CGColor]);
    CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(CGColorGetColorSpace([self CGColor]));
    if (colorSpaceModel == kCGColorSpaceModelRGB) {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithFloat:components[0]],
                [NSNumber numberWithFloat:components[1]],
                [NSNumber numberWithFloat:components[2]],
                [NSNumber numberWithFloat:components[3]],
                nil];
    }
    else if (colorSpaceModel == kCGColorSpaceModelMonochrome) {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithFloat:components[0]],
                [NSNumber numberWithFloat:components[0]],
                [NSNumber numberWithFloat:components[0]],
                [NSNumber numberWithFloat:components[1]],
                nil];
    }
    return nil;
}

+ (UIColor *)colorFromRGBAArray:(NSArray *)array
{
    return [self colorFromRGBAArray:array scale:1];
}

+ (UIColor *)colorFromRGBAArray:(NSArray *)array scale:(CGFloat)scale
{
    UIColor *color = nil;
    if (array && [array count] == 4) {
        NSNumber *r = SAFE_CAST([NSNumber class], [array objectAtIndex:0]);
        NSNumber *g = SAFE_CAST([NSNumber class], [array objectAtIndex:1]);
        NSNumber *b = SAFE_CAST([NSNumber class], [array objectAtIndex:2]);
        NSNumber *a = SAFE_CAST([NSNumber class], [array objectAtIndex:3]);
        if (r && g && b && a) {
            CGFloat rf = [r floatValue]/scale;
            CGFloat gf = [g floatValue]/scale;
            CGFloat bf = [b floatValue]/scale;
            CGFloat af = [a floatValue];
            
            if (rf == gf && gf == bf)
                color = [UIColor colorWithWhite:rf alpha:af];
            else
                color = [UIColor colorWithRed:rf
                                        green:gf
                                         blue:bf
                                        alpha:af];
        }
    }
    return color;
}

+ (UIColor *)blackMono
{
    return [[[UIColor alloc] initWithWhite:0 alpha:1] autorelease];
}
+ (UIColor *)blackRGB
{
    return [[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1] autorelease];
}
@end
