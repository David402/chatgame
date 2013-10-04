//
//  UIViewController+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (CB)
@property (nonatomic) BOOL hidesNavBarWhenPushed;
- (void)safeSetPreferredContentSize:(CGSize)preferredContentSize;
@end
