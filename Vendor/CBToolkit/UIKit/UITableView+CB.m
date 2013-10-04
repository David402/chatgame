//
//  UITableView+Background.m
//  PicCollage
//
//  Created by yyjim on 2/22/13.
//
//

#import "UITableView+CB.h"

@implementation UITableView (CB)
- (void)setBackgroundWithPatternImage:(UIImage *)patternImage
{
    UIView *backgroundView = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
    backgroundView.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    self.backgroundView = backgroundView;
}
@end
