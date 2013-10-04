//
//  NSCharacterSet+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSCharacterSet+CB.h"

@implementation NSCharacterSet (CB)
static NSCharacterSet *_nonAlphanumericCharacterSet = nil;
+ (NSCharacterSet *)nonAlphanumericCharacterSet
{
    if (!_nonAlphanumericCharacterSet)
        _nonAlphanumericCharacterSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet]
                                        retain];
    return _nonAlphanumericCharacterSet;
}
@end
