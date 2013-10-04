//
//  UINavigationController+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSArray+CB.h"
#import "UINavigationController+CB.h"

@implementation UINavigationController (CB)
- (void)replaceRootViewController:(UIViewController *)viewController
{
    [self setViewControllers:[NSArray array] animated:NO];
    [self pushViewController:viewController animated:NO];
}

- (UIViewController *)previousViewControllerTo:(UIViewController *)viewController;
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    
    if (index == NSNotFound || index == 0)
        return nil;
    
    UIViewController *previousViewController = [self.viewControllers objectAtSafeIndex:index - 1];
    return previousViewController;
}

@end
