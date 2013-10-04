//
//  UIGestureRecognizer+CB.m
//  PicCollage
//
//  Created by Jaime Cham on 12/19/12.
//
//

#import "UIGestureRecognizer+CB.h"

@implementation UIGestureRecognizer (CB)

- (void)cancel
{
    // See http://goo.gl/g4Hzu
    self.enabled = NO;
    self.enabled = YES;
}

@end
