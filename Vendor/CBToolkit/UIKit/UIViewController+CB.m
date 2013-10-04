//
//  UIViewController+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <objc/runtime.h>
#import "UIViewController+CB.h"

static char const * const kHideNavBarKey = "kHideNavBarKey";

@implementation UIViewController (CB)
@dynamic hidesNavBarWhenPushed;

- (BOOL)hidesNavBarWhenPushed
{
    id value = objc_getAssociatedObject(self, kHideNavBarKey);
    if (!value)
        return NO;
    
    return value;
}

- (void)setHidesNavBarWhenPushed:(BOOL)hidesNavBarWhenPushed
{
    objc_setAssociatedObject(self, kHideNavBarKey, hidesNavBarWhenPushed, OBJC_ASSOCIATION_ASSIGN);
}

- (void)safeSetPreferredContentSize:(CGSize)preferredContentSize
{
    if ([self respondsToSelector:@selector(setPreferredContentSize:)]) {
#ifdef __IPHONE_7_0
        [self setPreferredContentSize:preferredContentSize];
#endif
    } else {
        self.contentSizeForViewInPopover = preferredContentSize;
    }
}

@end
