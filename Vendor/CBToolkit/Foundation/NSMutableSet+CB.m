//
//  NSMutableSet+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSSet+CB.h"
#import "NSMutableSet+CB.h"

@implementation NSMutableSet (CB)
- (id)takeObject
{
	id obj = [[self anyObject] retain];
	if (obj) {
		[self removeObject:obj];
	}
	return [obj autorelease];
}

- (id)takeObjectEqualTo:(id)anObject
{
    id takee = [self findObjectEqualTo:anObject];
    [[takee retain] autorelease];
    [self removeObject:takee];
    return takee;
}
@end
