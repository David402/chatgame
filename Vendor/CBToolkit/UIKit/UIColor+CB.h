//
//  UIColor+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <UIKit/UIKit.h>

#define CBRGBA(r,g,b,a)  \
    [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]

@interface UIColor (CB)

- (CGFloat)alpha;
- (BOOL)isTransparent;
- (UIColor *)opaqueColor;

- (NSArray *)getRGBAArray;
+ (UIColor *)colorFromRGBAArray:(NSArray *)array;
+ (UIColor *)colorFromRGBAArray:(NSArray *)array scale:(CGFloat)scale;

+ (UIColor *)blackMono;
+ (UIColor *)blackRGB;
@end
