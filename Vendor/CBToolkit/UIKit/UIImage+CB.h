//
//  UIImage+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (CB)
- (UIImage *)safeResizableImageWithCapInsets:(UIEdgeInsets)capInsets;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithPatternImage:(UIImage *)patternImage size:(CGSize)size;
+ (UIImage *)imageWithContentsOfURL:(NSURL *)url
                            timeout:(NSTimeInterval)timeout
                              error:(NSError **)outError;
@end

@interface UIImage (ImageNamedExtension)
+ (UIImage *)imageNamed:(NSString *)name
          fromDirectory:(NSString *)directory;
@end

@interface UIImage (Border)
+ (UIImage *)imageWithBorderWidth:(NSInteger)width color:(UIColor *)color;
+ (UIImage *)imageWithClearBorderColor:(UIColor *)color;
@end