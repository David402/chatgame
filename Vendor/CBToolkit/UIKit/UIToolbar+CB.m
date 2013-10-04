//
//  UIToolbar+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "CBToolkitHelper.h"
#import "UIToolbar+CB.h"

@implementation UIToolbar (CB)
- (void)setCustomBackgroundImage:(UIImage *)image {
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:image] autorelease];
    imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    // Add the tab bar controller's view to the window and display.
    if ([self respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)])
        [self setBackgroundImage:image
              forToolbarPosition:UIToolbarPositionAny
                      barMetrics:UIBarMetricsDefault];
    else
        [self insertSubview:imageView atIndex:0]; // iOS4 atIndex:0
}

- (void)setCustomBackgroundColor:(UIColor *)color
{
    UIView *view = [[[UIView alloc] init] autorelease];
    view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    view.backgroundColor = color;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5"))
        [self insertSubview:view atIndex:1]; // iOS5 atIndex:1
    else
        [self insertSubview:view atIndex:0]; // iOS4 atIndex:0
}
@end
