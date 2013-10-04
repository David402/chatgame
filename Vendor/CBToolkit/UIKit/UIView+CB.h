//
//  UIView+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <UIKit/UIKit.h>

@interface UIView (CB)
- (CGSize)convertSize:(CGSize)size toView:(UIView *)refView;
- (CGPoint)convertCenterToView:(UIView *)refView;
- (void)setBackgroundGradientFromColor:(UIColor *)color0 toColor:(UIColor *)color1;
@end
