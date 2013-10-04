//
//  UINavigationController+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <UIKit/UIKit.h>

@interface UINavigationController (CB)
- (void)replaceRootViewController:(UIViewController *)viewController;
- (UIViewController *)previousViewControllerTo:(UIViewController *)viewController;
@end
